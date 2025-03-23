use clap::{Parser};
use std::process::Command;

#[derive(Parser)]
#[command(name = "dyin", version = "1.0", about = "Dynamic Instrumentation CLI for LLVM")]
struct Cli {
    /// Number of threads for pthread execution (default: 2)
    #[arg(short = 't', long, default_value_t = 2)]
    threads: u32,

    /// Instrumentation mode: store, load, or both (default: both)
    #[arg(short = 'i', long, default_value = "both")]
    instr: String,
}

fn main() {
    let args = Cli::parse();

    println!("Running with {} threads", args.threads);
    println!("Instrumentation mode: {}", args.instr);

    // Step 1: Compile pthread.c with the given thread count
    let clang_cmd = format!(
        "clang -DNUM_THREADS={} -fPIC -O1 -S -emit-llvm pthread.c -o in_1.ll",
        args.threads
    );
    run_command("Compiling pthread.c", &clang_cmd);

    // // Step 2: Compile LLVM Pass
    // run_command("Building LLVM Pass", "cargo b --example concurrent-write --features llvm17-0");

    // // Step 3: Apply LLVM Pass with selected instrumentation
    // let pass_cmd = format!(
    //     "opt --load-pass-plugin=target/debug/examples/libconcurrent_write.so --passes=concurrent-write in_1.ll -S -o out_1.ll --instr={}",
    //     args.instr
    // );
    // run_command("Applying LLVM Pass", &pass_cmd);

    // // Step 4: Convert LLVM IR to Object file
    // run_command("Generating Object File", "llc -relocation-model=pic -filetype=obj out_1.ll -o out_1.o");

    // // Step 5: Link with External Instrumentation
    // run_command(
    //     "Linking Final Executable",
    //     "clang out_1.o -o final_exe -L /home/dongin/external_instrumentation/target/release -lexternal_instrumentation -lpthread"
    // );

    // // Step 6: Execute the final binary
    // run_command("Executing Final Binary", "LD_LIBRARY_PATH=/home/dongin/external_instrumentation/target/release ./final_exe");
}

/// Helper function to run shell commands
fn run_command(step: &str, command: &str) {
    println!("----------------------------------------");
    println!("{}", step);
    
    let output = Command::new("sh")
        .arg("-c")
        .arg(command)
        .output()
        .expect("Failed to execute command");

    if !output.stdout.is_empty() {
        println!("{}", String::from_utf8_lossy(&output.stdout));
    }
    if !output.stderr.is_empty() {
        eprintln!("{}", String::from_utf8_lossy(&output.stderr));
    }
}



// use clap::{Parser};

// #[derive(Parser)]
// #[command(name = "LLVM Plugin CLI", version = "1.0", about = "A CLI for LLVM Plugin Management")]
// struct Cli {
//     /// Input LLVM IR file
//     #[arg(short, long)]
//     input: String,

//     /// Output file name
//     #[arg(short, long, default_value = "out.ll")]
//     output: String,
// }

// fn main() {
//     let args = Cli::parse();
//     println!("Processing LLVM IR: {}", args.input);
//     println!("Saving output to: {}", args.output);
// }
