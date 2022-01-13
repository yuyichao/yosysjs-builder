#!/bin/sh

builder_dir=$(realpath "$1")
source_dir=$(realpath "$2")

export CFLAGS='-g0 -Os'
export CXXFLAGS='-g0 -Os'
export LDFLAGS='-g0 -Os -s INVOKE_RUN=0 -s MODULARIZE=1'
export EM_NODE_JS="$builder_dir/scripts/node_wrapper"

cd "$source_dir"
make config-emcc
make yosys.js EMCCFLAGS='-g0 -Os -Wno-warn-absolute-paths -Wno-unused-command-line-argument --memory-init-file 0 --embed-file share -s NO_EXIT_RUNTIME=1 -s TOTAL_MEMORY=134217728 -s EXPORTED_FUNCTIONS=["_main","_run","_errmsg"] -s EXPORTED_RUNTIME_METHODS=["ccall","cwrap","callMain","FS"]'
