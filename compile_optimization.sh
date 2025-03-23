#!/bin/bash

#Compiling Rust Plugin Pass
cargo b --example concurrent-write --features llvm17-0

# echo "-------------------O0 Optimization-------------------"
# opt --load-pass-plugin=target/debug/examples/libconcurrent_write.so --passes=concurrent-write in_0.ll -S -o out_0.ll

echo "-------------------O1 Optimization-------------------"
opt --load-pass-plugin=target/debug/examples/libconcurrent_write.so --passes=concurrent-write in_0.ll -S -o out_1.ll

# echo "-------------------O2 Optimization-------------------"
# opt --load-pass-plugin=target/debug/examples/libconcurrent_write.so --passes=concurrent-write in_2.ll -S -o out_2.ll