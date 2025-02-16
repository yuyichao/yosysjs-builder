#!/bin/bash

yosys_ver=$1
build_ver=$(cat BUILD_VERSION)

echo "Yosys version $yosys_ver"
echo "Build version $build_ver"

read_yosysjs_version() {
    local yosys_ver build_ver
    if [ -f yosysjs/.source_ver ]; then
        . yosysjs/.source_ver
        old_yosys_ver=$yosys_ver
        old_build_ver=$build_ver
        echo "Built yosys version $yosys_ver"
        echo "Built build version $build_ver"
    fi
}

read_yosysjs_version

if [ "$yosys_ver" = "$old_yosys_ver" ] && [ "$build_ver" = "$old_build_ver" ]; then
    echo "uptodate=1" >> $GITHUB_OUTPUT
    exit 0
fi

echo "uptodate=0" >> $GITHUB_OUTPUT
if ! [[ "$yosys_ver" =~ ^([0-9]+)\.([0-9]+)$ ]]; then
    echo "Unexpected yosys version format: ${yosys_ver}" >&2
    exit 1
fi

echo "version=${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.$build_ver" >> $GITHUB_OUTPUT
{
    echo "yosys_ver=$yosys_ver"
    echo "build_ver=$build_ver"
} > yosysjs/.source_ver
