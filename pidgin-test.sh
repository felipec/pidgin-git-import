export MTN_DATABASE=$PWD/../mtn/pidgin.mtn
export AUTHOR_MAP=$PWD/pidgin/authors_map.txt
export RUBYLIB=$PWD

fast_import ()
{
        export GIT_DIR=$PWD/pidgin/fast.git

        ./app.rb "clone-fast"
}

fast_import_mtn ()
{
        export GIT_DIR=$PWD/pidgin/fast.git
        git_marks="pidgin/marks-git.txt"
        mtn_marks="pidgin/marks-mtn.txt"

        git init
        test -f $git_marks && git_extra="--import-marks=$git_marks"
        test -f $mtn_marks && mtn_extra="--import-marks=$mtn_marks"
        mtn git_export -d $MTN_DATABASE --authors-file=$AUTHOR_MAP --refs=revs $mtn_extra --export-marks=$mtn_marks |
        git fast-import $git_extra --export-marks=$git_marks
}

checkout_clone ()
{
        export GIT_DIR=$PWD/pidgin/simple.git

        ./app.rb "clone"
}

checkout_update ()
{
        export GIT_DIR=$PWD/pidgin/simple.git

        mtn pull -d $MTN_DATABASE
        ./app.rb "update"
}

fast_import_mtn
