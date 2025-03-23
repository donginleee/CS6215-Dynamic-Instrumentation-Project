#!/bin/bash

# 1) .ll → .o 변환
llc -filetype=obj out_1.ll -o out_1.o

# 2) clang으로 최종 바이너리 생성
#   -L. 등으로 외부 모듈이 있는 디렉터리를 링크 경로에 추가
#   -lexternal_instrumentation 은 cdylib의 이름에 맞게 변경 필요
clang out_1.o -o final_exe \
    -L llvm-plugin-rs/llvm-plugin/Cargo.toml \
    -lexternal \
    -lpthread