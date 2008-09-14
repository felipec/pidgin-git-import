#include "ruby.h"

#include <stdbool.h>
#include <sqlite3.h>
#include <glib.h>

static GHashTable *revisions;
static GHashTable *tags;

typedef struct Revision Revision;

struct Revision
{
    gchar *id;
    GSList *parents;
    GSList *childs;

    gboolean visited;
    GSList *branches;
    gchar *date;
    gchar *author;
    gchar *changelog;
    gchar *comment;
    gchar *committer;
};

static VALUE rb_mMtn;
static VALUE rb_cMtn_Db;

struct mtn_data
{
    VALUE tag;
    sqlite3 *db;
    gboolean initialized;
};

static Revision *
revision_new (const gchar *id)
{
    Revision *revision;
    revision = g_new0 (Revision, 1);
    revision->id = g_strdup (id);
    g_hash_table_insert (revisions, g_strdup (id), revision);
    return revision;
}

static void
revision_free (Revision *revision)
{
    g_free (revision->comment);
    g_free (revision->changelog);
    g_free (revision->author);
    g_free (revision->date);
    g_slist_free (revision->branches); /* @todo free strings. */
    g_slist_free (revision->parents);
    g_slist_free (revision->childs);
    g_free (revision);
}

static void
create_revisions_cb (sqlite3_stmt *sql_statement,
		     gpointer cb_data)
{
    const char *val;
    val = sqlite3_column_text (sql_statement, 0);
    revision_new (val);
}

static inline Revision *
get_revision (const gchar *id)
{
    return g_hash_table_lookup (revisions, id);
}

static void
import_ancestry_cb (sqlite3_stmt *sql_statement,
		    gpointer cb_data)
{
    const char *parent_id;
    const char *child_id;
    Revision *parent;
    Revision *child;

    parent_id = sqlite3_column_text (sql_statement, 0);
    child_id = sqlite3_column_text (sql_statement, 1);

    parent = get_revision (parent_id);
    child = get_revision (child_id);

    if (!parent)
    {
	/* g_warning ("no parent: %s: %s", child_id, parent_id); */
	return;
    }

    if (!child)
    {
	/* g_warning ("no child: %s: %s", parent_id, child_id); */
	return;
    }

    parent->childs = g_slist_append (parent->childs, child);
    child->parents = g_slist_append (child->parents, parent);
}

static void
import_certs_cb (sqlite3_stmt *sql_statement,
		 gpointer data)
{
    Revision *revision;
    const char *id;
    const char *name;
    const char *value;
    const char *keypair;

    id = sqlite3_column_text (sql_statement, 0);
    name = sqlite3_column_text (sql_statement, 1);
    value = sqlite3_column_text (sql_statement, 2);
    keypair = sqlite3_column_text (sql_statement, 3);

    revision = get_revision (id);

    /* g_debug ("%s=%s", name, value); */

    if (strcmp (name, "branch") == 0)
    {
	revision->branches = g_slist_append (revision->branches, g_strdup (value));
    }
    else if (strcmp (name, "date") == 0)
    {
	if (revision->date)
	    return;
	revision->date = g_strdup (value);
    }
    else if (strcmp (name, "author") == 0)
    {
	if (revision->author)
	    return;
	revision->author = g_strdup (value);
    }
    else if (strcmp (name, "changelog") == 0)
    {
	if (revision->changelog)
	    return;
	revision->changelog = g_strdup (value);
	revision->committer = g_strdup (keypair);
    }
    else if (strcmp (name, "tag") == 0)
    {
	g_hash_table_insert (tags, g_strdup (value), revision);
    }
#if 0
    else if (strcmp (name, "comment") == 0)
    {
    }
    else if (strcmp (name, "suspend") == 0)
    {
	/* who cares? */
    }
    else
    {
	g_warning ("unknown cert: %s=%s (%s)", name, value, keypair);
    }
#endif
}

typedef void (*EachRowFunc) (sqlite3_stmt *, gpointer cb_data);

static inline void
each_row (sqlite3 *db,
	  const char *statement,
	  EachRowFunc cb,
	  gpointer cb_data)
{
    int rc = SQLITE_OK;
    sqlite3_stmt *sql_statement;

    sql_statement = NULL;
    rc = sqlite3_prepare (db, statement, -1, &sql_statement, NULL);

    do
    {
	rc = sqlite3_step (sql_statement);

	if (rc != SQLITE_ROW)
	    break;

	cb (sql_statement, cb_data);
    } while (rc == SQLITE_ROW);

    rc = sqlite3_finalize (sql_statement);
}

static VALUE
rb_db_alloc (VALUE self)
{
    struct mtn_data *data;

    return Data_Make_Struct (self, struct mtn_data, NULL, free, data);
}

static VALUE
rb_db_initialize (VALUE self,
		  VALUE file_name)
{
    struct mtn_data *data;
    char *c_file_name;

    Data_Get_Struct (self, struct mtn_data, data);

    c_file_name = rb_string_value_ptr (&file_name);

    {
	int rc;

	rc = sqlite3_open_v2 (c_file_name, &data->db, SQLITE_OPEN_READONLY, NULL);
	if (rc != SQLITE_OK)
	{
	    rb_raise (rb_eArgError, "bad database '%s'", c_file_name);
	    return Qnil;
	}

	revisions = g_hash_table_new_full (g_str_hash, g_str_equal, g_free, revision_free);
	tags = g_hash_table_new_full (g_str_hash, g_str_equal, g_free, NULL);
    }

    return Qnil;
}

static VALUE
rb_db_finalize (VALUE self)
{
    struct mtn_data *data;

    Data_Get_Struct (self, struct mtn_data, data);

    g_hash_table_destroy (tags);
    g_hash_table_destroy (revisions);

    sqlite3_close (data->db);

    return Qnil;
}

static inline void
initialize_revisions (struct mtn_data *data)
{
    each_row (data->db, "select id from revisions", create_revisions_cb, NULL);
    each_row (data->db, "select parent,child from revision_ancestry", import_ancestry_cb, NULL);
    each_row (data->db, "select id,name,value,keypair from revision_certs", import_certs_cb, NULL);
}

static void
clear_visited_cb (gpointer key,
		  gpointer value,
		  gpointer data)
{
    Revision *revision;
    revision = value;
    revision->visited = false;
}

static inline void
traverse_begin (struct mtn_data *data)
{
    if (!data->initialized)
    {
	initialize_revisions (data);
	data->initialized = true;
    }

    g_hash_table_foreach (revisions, clear_visited_cb, NULL);
}

static inline void
traverse (Revision *revision,
	  VALUE ary)
{
    if (revision->visited)
	return;

    revision->visited = true;
    {
	GSList *cur;
	for (cur = revision->parents; cur; cur = g_slist_next (cur))
	{
	    traverse (cur->data, ary);
	}
    }

    rb_ary_push (ary, rb_str_new (revision->id, 40));
}

static VALUE
traverse_id (VALUE i,
	     VALUE data)
{
    const char *c_i;

    c_i = rb_string_value_ptr (&i);

    traverse (get_revision (c_i), data);

    return Qnil;
}

static VALUE
rb_db_get_topology (VALUE self,
		    VALUE roots)
{
    struct mtn_data *data;

    Data_Get_Struct (self, struct mtn_data, data);

    traverse_begin (data);

    {
	VALUE ary;
	ary = rb_ary_new ();
	rb_iterate (rb_each, roots, traverse_id, ary);
	return ary;
    }
}

static void
get_heads_cb (sqlite3_stmt *sql_statement,
	      gpointer cb_data)
{
    const char *val;
    val = sqlite3_column_text (sql_statement, 0);
    rb_ary_push (cb_data, rb_str_new (val, 40));
}

static VALUE
rb_db_get_heads (VALUE self)
{
    struct mtn_data *data;

    Data_Get_Struct (self, struct mtn_data, data);

    {
	VALUE ary;
	ary = rb_ary_new ();
	each_row (data->db, "select revisions.id from revisions left join "
		  "revision_ancestry on revisions.id = revision_ancestry.parent "
		  "where revision_ancestry.child is null", get_heads_cb, ary);
	return ary;
    }
}

static void
add_tag_cb (gpointer key,
            gpointer value,
            gpointer data)
{
    Revision *revision;
    revision = value;
    rb_hash_aset (data, rb_str_new2 (key), rb_str_new (revision->id, 40));
}

static VALUE
rb_db_get_tags (VALUE self,
                VALUE roots)
{
    struct mtn_data *data;

    Data_Get_Struct (self, struct mtn_data, data);

    if (!data->initialized)
    {
	initialize_revisions (data);
	data->initialized = true;
    }

    {
	VALUE hash;
	hash = rb_hash_new ();
        g_hash_table_foreach (tags, add_tag_cb, hash);
	return hash;
    }
}

void
Init_helper ()
{
    rb_mMtn = rb_define_module ("Mtn");
    rb_cMtn_Db = rb_define_class_under (rb_mMtn, "Db", rb_cObject);

    rb_define_alloc_func (rb_cMtn_Db, rb_db_alloc);
    rb_define_method (rb_cMtn_Db, "initialize", rb_db_initialize, 1);
    rb_define_method (rb_cMtn_Db, "finalize", rb_db_finalize, 0);
    rb_define_method (rb_cMtn_Db, "get_topology", rb_db_get_topology, 1);
    rb_define_method (rb_cMtn_Db, "get_heads", rb_db_get_heads, 0);
    rb_define_method (rb_cMtn_Db, "get_tags", rb_db_get_tags, 0);
}
