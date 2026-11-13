#!/usr/bin/env bash
# Builds: native CLI (bin/dot) and the WebAssembly module (build/dot.wasm)
set -e
cd "$(dirname "$0")"
mkdir -p bin build
python3 tools/embed.py src/rt.c src/rt_src.h
gcc -std=gnu11 -O2 -DDOT_CLI -Wall -Wno-unused-function -Wno-misleading-indentation -o bin/dot src/dot.c -lm
clang --target=wasm32 -O2 -std=gnu11 -nostdlib -ffreestanding -Wno-unused-function \
  -Wl,--no-entry -Wl,--export-dynamic -Wl,-z,stack-size=33554432 -Wl,--initial-memory=67108864 \
  -Wl,--allow-undefined -o build/dot.wasm src/dot.c
echo "built bin/dot and build/dot.wasm ($(wc -c < build/dot.wasm) bytes)"
python3 tools/mkweb.py
