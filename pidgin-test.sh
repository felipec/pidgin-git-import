export MTN_DATABASE=$PWD/../mtn/pidgin.mtn
export AUTHOR_MAP=$PWD/pidgin/authors_map.txt
export RUBYLIB=$PWD

fast_import ()
{
        export GIT_DIR=$PWD/pidgin/fast.git

        ./clone-fast.rb
}

checkout_clone ()
{
        export GIT_DIR=$PWD/../new.git

        ./clone.rb
}

checkout_update ()
{
        export GIT_DIR=$PWD/../new.git

        mtn pull -d $MTN_DATABASE
        ./update.rb
}

checkout_update
