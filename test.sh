#!/bin/sh
# Test basic functionality

set -e

proram=$0
TMPDIR=${TMPDIR:-/tmp}
BASE=tmp.$$
TMPBASE=${TMPDIR%/}/$BASE
CURDIR=.

case "$0" in
  */*)
        CURDIR=$(cd "${0%/*}" && pwd)
        ;;
esac

AtExit ()
{
    rm -rf "$TMPBASE"
}

Run ()
{
    if [ "$1" ]; then           # Empty message, just command to run
        echo "$*"
        shift
    else
        shift
        echo "$*"
    fi

    eval "$@"
}

trap AtExit 0 1 2 3 15

# #######################################################################

PATH="$CURDIR/../.build/build:$PATH"
bin=rzip
file="example.dat"

which $bin
$bin -V

mkdir "$TMPBASE"

echo "
1
2
3
4
5
6
7
8
9
10" > "$TMPBASE/$file"

cd "$TMPBASE"
ls -l $file

# -f force
# -9 maximum
Run "%% TEST compress:" $bin -f -9 $file
ls -l $file*

Run "%% TEST compress:" $bin -d $file*
ls -l $file*

# End of file
