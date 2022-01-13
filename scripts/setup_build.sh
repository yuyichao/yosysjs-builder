#!/bin/sh

builder_dir=$(realpath "$1")
source_dir=$(realpath "$2")

sudo pacman -S --noconfirm emscripten wasi-compiler-rt wasi-libc++ wasi-libc++abi
