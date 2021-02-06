#!/bin/bash
set +x
set -e
set -C

export CUR_DIR="$(pwd)"
project_dir="$(basename $(pwd))"
tag="$(git describe --tags --exact-match)"
if [ $? -ne 0 ]; then
   echo "No git tag set on this commit, no creating release without one"
   exit 1
fi
export FULLDIR="${project_dir}_${tag}"
git archive --verbose --prefix "$FULLDIR/" --format=tar -o "${project_dir}_${tag}.tar" ${tag}

#git submodule foreach --recursive 'echo "name=[$name] sm_path=[$sm_path] displaypath=[$displaypath] sha1=[$sha1] toplevel=[$toplevel]"'

git submodule foreach --recursive 'git archive --verbose --prefix=$FULLDIR/$sm_path/ --format tar HEAD --output $CUR_DIR/tmptar-$name-$sha1.tar'

if [[ $(ls -1 tmptar-*.tar | wc -l) != 0 ]]; then
   tar --concatenate --file "${project_dir}_${tag}.tar" tmptar-*.tar
   rm tmptar-*.tar
fi

gzip --verbose "${project_dir}_${tag}.tar"
