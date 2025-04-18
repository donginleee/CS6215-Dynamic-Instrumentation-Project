Dynamic-Instrumentation-Framework-for-LLVM-IR  
==============
This crate provides a dynamic instrumentation tool to detect the Last Concurrent Write using [LLVM pass manager] written in Rust.

Specifically, it instruments load and store instructions at the LLVM IR level in multi-threaded programs.
For each store, the tool captures the calling thread's ID and associates it with the memory address using a hash map.
For each load, it retrieves the thread ID that last modified the corresponding memory address.

In short, this tool enables precise tracking of which thread most recently wrote to each memory location at runtime.

[LLVM pass manager]: https://github.com/jamesmth/llvm-plugin-rs

## Requirements

Before getting started, make sure your development environment meets the following setup.
This tool has been tested on Ubuntu 22.04.4 with Python 3.10.12, running on an Intel Xeon E5-2630 v4 (32GB RAM).

We assume that the required versions of LLVM and Rust are already installed:
- `LLVM Version: 17`
- `LLVM Compiler: Clang-17`
- `Rust Version: 1.85.0`

After installing LLVM, Clang and Rust, it is recommended to configure your shell settings (e.g., ~/.bashrc or ~/.bash_profile) as follows:

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


## Getting Started (Already Being Built But In Case If You Want to Rebuild)

If you would like to rebuild everything from scratch, follow the steps below. These commands build the required libraries and the CLI tool in this repository. 

```bash
cd /path/to/CS6215-Dynamic-Instrumentation-Project

#Building Libraries for Dynamic Instrumentation
cargo build -p external_instrumentation --release

#Building Libraries for Inlined Instrumentation
RUSTFLAGS="--emit=llvm-bc" cargo build -p external_instrumentation_inline --release

#Building CLI Tool
cargo build -p dyin

```

## Usage of This Tool
The provided CLI tool offers several configurable options to control instrumentation behavior, calling conventions, and benchmark selection. 
The general usage format is as follows:

```shell
 $ RUN_DI --threads <number_of_threads> --instr <store|load|both> --call <ccc|fastcc|preserve_allcc|preserve_mostcc> --bench <test|phoenix-kmeans|phoenix-linear_regression|phoenix-pca|phoenix-string_match> [--inline]
 ```

- `--threads    (default: 2     ): Sets the number of threads for program execution`
- `--instr      (default: both  ): Selects which operations to instrument: store, load, or both`
- `--call       (default: ccc   ): Specifies the calling convention to use for external instrumentation`
- `--bench      (default: test  ): Selects which benchmark to run`
- `--inline     (default: 'none'): Enables inlined instrumentation instead of calling external functions`

Example commands as follows:

```shell
 #Exectuing the Tool without "--inline" Version (Original Intention for This Tool)
 $ RUN_DI --threads 2 --instr both --call fastcc --bench phoenix-kmenas
 ```

```shell
 #Exectuing the Tool with "--inline" Version (Comparison for This Tool)
 $ RUN_DI --threads 8 --instr store --call preserve_mostcc --bench test --inline
 ```

## Important Components of the Project

This project consists of five key code components:

- `LLVM Pass Implementation`
    - `$ cd /path/to/CS6215-Dynamic-Instrumentation-Project/examples/concurrent_write.rs`
    - `Contains the Rust-based LLVM pass that instruments load/store instructions.`
- `External Module for Dynamic Instrumentation`
    - `$ cd /path/to/CS6215-Dynamic-Instrumentation-Project/external_instrumentation/src/lib.rs`
    - `Provides runtime logic (e.g., logging, thread tracking) via dynamic linking.`
- `External Module for Inlined Version`
    - `$ cd /path/to/CS6215-Dynamic-Instrumentation-Project/external_instrumentation_inline/src/lib.rs`
    - `Provides a bitcode version of instrumentation logic for inlining into the LLVM IR.`
- `CLI Tool Code: Related Packages Required (e.g., matplotlib, pandas)`
    - `$ cd /path/to/CS6215-Dynamic-Instrumentation-Project/llvm-plugin-cli/src/main.rs`
    - `Orchestrates the entire pipeline: building the pass, instrumenting IR, compiling, and executing.`
- `Experiment Automation and Result Generation: Related Files will be created in /path/to/CS6215-Dynamic-Instrumentation-Project/results`
    - `Running Experiment1 ($ ./run_experiment1.sh): experiments regarding different benchamrks in different number of threads`
    - `Running Experiment2 ($ ./run_experiment2.sh): experiments regarding different calling conventions`
    - `Making CSV format file for experiment1 ($ python3 generate_csv1.py)`
    - `Making CSV format file for experiment2 ($ python3 generate_csv2.py)`
    - `Making seaborn style graph for experiment1 ($ python3 graph_generate1.py)`
    - `Making seaborn style graph for experiment2 ($ python3 graph_generate2.py)`
    
    

