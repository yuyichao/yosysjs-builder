#!/bin/sh

builder_dir=$(realpath "$1")
source_dir=$(realpath "$2")

export CFLAGS='-g0 -Os -s USE_ZLIB=1'
export CXXFLAGS='-g0 -Os -s USE_ZLIB=1'
export LDFLAGS='-g0 -Os -s USE_ZLIB=1 -s INVOKE_RUN=0 -s MODULARIZE=1'
export EM_NODE_JS="$builder_dir/scripts/node_wrapper"

# _ZN5Yosys11yosys_setupEv is the mangled name for `Yosys::yosys_setup()`
# We need to call this if we don't run main.

cd "$source_dir"
make config-emcc
make yosys.js ENABLE_ZLIB=1 EMCCFLAGS='-g0 -Os -Wno-warn-absolute-paths -Wno-unused-command-line-argument --memory-init-file 0 --embed-file share -s NO_EXIT_RUNTIME=1 -s TOTAL_MEMORY=134217728 -s EXPORTED_FUNCTIONS=["_run","_errmsg","__ZN5Yosys11yosys_setupEv"] -s EXPORTED_RUNTIME_METHODS=["ccall","cwrap","FS"]'
