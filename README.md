# Usage

Creates a tar.gz of the current git project and all the submodules recursively. Only tried to
one level of submodule but it "should" work :-)

You have to tag the current topleve which will be used in the filename

    cd ~/my_git_project
    git tag v4.23.66
    release/build_src_package.sh

This should create an archive `my_git_project_v4.23.66.tar.gz`

