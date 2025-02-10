#!/bin/sh

builder_dir=$(realpath "$1")
source_dir=$(realpath "$2")

sudo pacman -S --noconfirm emscripten wasi-compiler-rt wasi-libc++ wasi-libc++abi

cd "$source_dir"

patch -Np1 < "$builder_dir/patches/0001-Do-not-load-host-file-system.patch"
patch -Np1 < "$builder_dir/patches/0002-Include-prefix-in-the-logged-error.patch"
