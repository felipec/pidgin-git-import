export MTN_DATABASE=$PWD/../mtn/pidgin.mtn
export AUTHOR_MAP=$PWD/pidgin/authors_map.txt
export RUBYLIB=$PWD
export GIT=git

fast_import ()
{
        ./clone-fast.rb | $GIT fast-import --date-format=rfc2822 --tolerant
}

checkout_clone ()
{
        export MTN_WORKINGDIR=$PWD/pidgin/wd
        export MTN_BRANCH=im.pidgin.pidgin

        mtn checkout -d $MTN_DATABASE -b $MTN_BRANCH $MTN_WORKINGDIR
        ./clone.rb $PWD/../new.git
}

checkout_update ()
{
        export MTN_WORKINGDIR=$PWD/pidgin/wd

        mtn pull -d $MTN_DATABASE
        ./update.rb $PWD/../new.git
}

checkout_update
