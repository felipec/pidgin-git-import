require 'mkmf'

pkg_config('sqlite3')
pkg_config('glib-2.0')

create_makefile("helper")
