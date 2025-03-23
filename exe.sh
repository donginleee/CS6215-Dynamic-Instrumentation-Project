#!/bin/bash
echo "----------------------------------------"
echo "------------------Step 1------------------"
clang -fPIC -O1 -S -emit-llvm pthread.c -o in_1.ll
echo "Compilation of Source Code Complete!!!"

echo "----------------------------------------"
echo "------------------Step 2------------------"
cargo b --example concurrent-write --features llvm17-0
echo "Compilation of LLVM Pass Complete!!!"

echo "----------------------------------------"
echo "------------------Step 3------------------"
opt --load-pass-plugin=target/debug/examples/libconcurrent_write.so --passes=concurrent-write in_1.ll -S -o out_1.ll
echo "Optimization LLVM Pass Complete!!!"

echo "----------------------------------------"
echo "------------------Step 4------------------"
llc -relocation-model=pic -filetype=obj out_1.ll -o out_1.o
echo "IR to Object File Completed!!!"

echo "----------------------------------------"
echo "------------------Step 5------------------"
clang out_1.o -o final_exe \
    -L /home/dongin/external_instrumentation/target/release \
    -lexternal_instrumentation \
    -lpthread
echo "External Module Instrumentation Completed!!"

echo "----------------------------------------"
echo "------------------Step 6------------------"
LD_LIBRARY_PATH=/home/dongin/external_instrumentation/target/release ./final_exe

