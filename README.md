Dynamic-Instrumentation-Framework-for-LLVM-IR  
==============
This crate gives the ability to detect "Last Concurrent Write" by using [LLVM pass manager] written in Rust.

What this tool exactly does is instrumenting load and store instructions at LLVM IR level in multi-threaded environments. For store instructions, the tool detect the thread_id and store the id with memory address using hashmap. For load instructions, the tool retrieve the thread_id which modified the data using memory address. In summary, this crate provides a functionality that determines which thread_id last modified each memory address.

[LLVM pass manager]: https://github.com/jamesmth/llvm-plugin-rs
<!-- [Inkwell]: https://github.com/TheDan64/inkwell
[new LLVM pass manager]: https://blog.llvm.org/posts/2021-03-26-the-new-pass-manager/
[examples]: https://github.com/jamesmth/llvm-plugin-rs/tree/master/examples
[official LLVM documentation]: https://llvm.org/docs/NewPassManager.html -->

## Requirements Before Getting Started

Belows are the settings for the development. 
I have tested this tool in Intel Xeon E5-2630 v4 based on X86 ISA.
We suppose that the specific version of LLVM and Rust are already installed.
- `LLVM Version: 17`
- `LLVM Compiler: Clang-17`
- `Rust Version: 1.85.0`

After installing LLVM and Rust, we recommend to set shell configuration files(e.g., ~/.bashrc, ~/.bash_profile) like below.

```sh
#Settings for Preferred 'LLVM Version'
export LLVM_VERSION=17
export LLVM_DIR=/usr/lib/llvm-$LLVM_VERSION
export PATH=$LLVM_DIR/bin:$PATH
export LD_LIBRARY_PATH=$LLVM_DIR/lib:$LD_LIBRARY_PATH
export CMAKE_PREFIX_PATH=$LLVM_DIR:$CMAKE_PREFIX_PATH
export PATH=$HOME/.local/bin:$PATH

#Settings for Rust Path
export PATH=$HOME/.cargo/bin:$PATH

#Settings for LLVM Pass
export LLVM_COMPILER="clang-17"
export LLVM_CC_NAME="clang-17"
export LLVM_CXX_NAME="clang++-17"

#Settings for Command Line Interface
alias RUN_DI="$HOME/CS6215-Dynamic-Instrumentation-Project/target/debug/dyin"
```


## Getting Started (Already Build But In Case If You Want to Rebuild)

In the directory of this repo, you should build some basic crates to use Command Line Interface (CLI) tool. 

```bash
cd /path/to/CS6215-Dynamic-Instrumentation-Project

#Building Libraries for Dynamic Instrumentation
cargo build -p external_instrumentation --release

#Building Libraries for Inlined Instrumentation
cargo build -p external_instrumentation_inline --release

#Building CLI Tool
cargo build -p dyin

```

## Usage of This Tool
CLI tool for this tools could choose several options.
CLI tool could work like below.

```shell
 $ RUN_DI --threads <number of threads> --instr <store, load, both> --call <ccc, fastcc, preserve_allcc, preserve_mostcc> --bench <test, phoenix-kmeans, phoenix-linear_regression, phoenix-pca, phoenix-string_match> (--inline)
 ```

- `--threads    (default: 2     ): deciding the number of threads for program`
- `--instr      (default: both  ): choose what instrument to instrument`
- `--call       (default: ccc   ): deciding which calling convention to use`
- `--bench      (default: test  ): deciding which benchmark to use`
- `--inline     (default: 'none'): deciding whether exeucting the tool with or without inlined version`

Belows are some examples of CLI tool usage

```shell
 #Exectuing the Tool without "--inline" Version (Original Intention for This Tool)
 $ RUN_DI --threads 2 --instr both --call fastcc --bench phoenix-kmenas
 ```

```shell
 #Exectuing the Tool with "--inline" Version (Comparison for This Tool)
 $ RUN_DI --threads 8 --instr store --call preserve_mostcc --bench test --inline
 ```


<!-- ## Linux & MacOS Requirements

Your LLVM toolchain should dynamically link the LLVM library. Fortunately, this is the case for toolchains
distributed on `apt` and `homebrew` registeries.

<details>
 <summary><em>Install LLVM-14 with apt</em></summary>

 ```shell
 $ apt install llvm-14
 ```

 </details>

<details>
 <summary><em>Install LLVM-14 with homebrew</em></summary>

 ```shell
 $ brew install llvm@14
 ```

 </details>

If you don't use any of these package managers, you can download a compatible LLVM toolchain from
this [LLVM fork] instead. In this case, don't forget to update your `PATH` environment variable with
your LLVM toolchain path, or use the `LLVM_SYS_XXX_PREFIX` environment variable to locate your toolchain.

For instance, if your LLVM-14 toolchain is located at `~/llvm`, you should set either of the following:
- `PATH=$PATH;$HOME/llvm/bin`
- `LLVM_SYS_140_PREFIX=$HOME/llvm`

## Windows Requirements

The official LLVM toolchain for Windows was not built with plugin support. However, compatible toolchains can be found
[here](https://github.com/jamesmth/llvm-project/releases).

Don't forget to update your `PATH` environment variable with your LLVM toolchain path, or use the `LLVM_SYS_XXX_PREFIX`
environment variable to locate your toolchain.

For instance, if your LLVM-14 toolchain is located at `C:\llvm`, you should set either of the following:
- `PATH=$PATH;C:\llvm\bin`
- `LLVM_SYS_140_PREFIX=C:\llvm`

## Compiling Rust/C++ code with custom LLVM plugins

This [LLVM fork] explains how to do so, and provides LLVM toolchains that will make the process easier.

[LLVM fork]: https://github.com/jamesmth/llvm-project

## Missing Features

- Support for loop passes (`Inkwell` doesn't currently provide safe wrappers)
- Support for CGSCC passes (`Inkwell` doesn't currently provide safe wrappers)
- FFI over the full manager proxy API (only a subset is currently implemented)
- FFI over the full analysis invalidation API (only a subset is currently implemented)
- FFI over builtin LLVM analyses (e.g. dominator tree)

Contributions are very welcome, make sure to check out the [Contributing Guide] first!

[Contributing Guide]: ./.github/CONTRIBUTING.md -->
