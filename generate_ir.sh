#!/bin/bash

# Compile pthread.c with different optimization levels
# clang -O0 -S -emit-llvm pthread.c -o in_0.ll
clang -O1 -S -emit-llvm pthread.c -o in_1.ll
# clang -O2 -S -emit-llvm pthread.c -o in_2.ll

echo "Compilation completed."
