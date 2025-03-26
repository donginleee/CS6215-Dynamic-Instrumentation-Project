use clap::Parser;
use std::process::Command;
use std::time::Instant;

/// CLI tool interface for dynamic instrumentation
#[derive(Parser)]
#[command(name = "dyin", version = "1.0", about = "Dynamic Instrumentation CLI for LLVM")]
struct Cli {
    /// Number of threads to run (default: 2)
    #[arg(short = 't', long, default_value_t = 2)]
    threads: u32,

    /// Instrumentation mode: store, load, or both
    #[arg(short = 'i', long, default_value = "both")]
    instr: String,

    /// Enable inline instrumentation (true = use bitcode inlining)
    #[arg(long)]
    inline: bool,
}

fn main() {
    let args = Cli::parse();

    println!("Running with {} threads", args.threads);
    println!("Instrumentation mode: {}", args.instr);
    println!("Inline instrumentation: {}", args.inline);

    let inline_env = if args.inline {
        "INSTRUMENTATION_INLINE=true"
    } else {
        "INSTRUMENTATION_INLINE=false"
    };

    println!("===========================================================================");    
    println!("===========================================================================");    
    println!("=====================CS6215 Dynamic Instrumentation Project================");
    println!("===========================================================================");
    println!("===========================================================================\n\n");
    
    //// Step 1: Compile source into LLVM IR
    // println!("---------------------------------------------------------------------------");
    // println!("--------------------------------Step 1-------------------------------------");
    // println!("---------------------------------------------------------------------------");
    // run_command("Compiling pthread.c", "clang -fPIC -O1 -S -emit-llvm pthread.c -o in_1.ll");
    // println!("Compilation of Source Code Complete!!!");
    // println!("---------------------------------------------------------------------------");
    // println!("---------------------------------------------------------------------------\n\n");

    // Step 2: Build instrumentation pass
    println!("---------------------------------------------------------------------------");
    println!("--------------------------------Step 2-------------------------------------");
    println!("---------------------------------------------------------------------------");
    let build_start2 = Instant::now();
    run_command(
        "Building LLVM Pass",
        &format!("{inline_env} INSTRUMENTATION_MODE={} cargo build --example concurrent-write --features llvm17-0", args.instr)
    );
    let build_duration2 = build_start2.elapsed();
    println!("Compilation of LLVM Pass Complete!!!");
    println!("---------------------------------------------------------------------------");
    println!("---------------------------------------------------------------------------\n\n");

    // Step 3: Link with inline bitcode version
    println!("---------------------------------------------------------------------------");
    println!("--------------------------------Step 3-------------------------------------");
    println!("---------------------------------------------------------------------------");
    let build_start3 = Instant::now();

    let pass_cmd = format!(
        "INSTRUMENTATION_MODE={} INSTRUMENTATION_INLINE={} opt --load-pass-plugin=target/debug/examples/libconcurrent_write.so \
        --passes=concurrent-write in_1.ll -S -o out_1.ll",
        args.instr, args.inline
    );
    run_command("Running instrumentation pass", &pass_cmd);

    if args.inline {
        let bc_path = "target/release/deps/external_instrumentation_inline.bc";

        let inline_link_cmd = format!("llvm-link out_1.ll {} -o linked.ll", bc_path);
        run_command("Linking .bc and IR", &inline_link_cmd);

        let inline_opt_cmd = "opt -passes=inline linked.ll -S -o out_1.ll".to_string();
        run_command("Running optimizer for inlining", &inline_opt_cmd);
    }
    let build_duration3 = build_start3.elapsed();

    println!("Optimization LLVM Pass Completed!!!");
    println!("---------------------------------------------------------------------------");
    println!("---------------------------------------------------------------------------\n\n");

    // Step 4: IR → Object
    println!("---------------------------------------------------------------------------");
    println!("--------------------------------Step 4-------------------------------------");
    println!("---------------------------------------------------------------------------");
    let build_start4 = Instant::now();
    run_command("Generating Object File", "llc -relocation-model=pic -filetype=obj out_1.ll -o out_1.o");
    let build_duration4 = build_start4.elapsed();
    println!("IR to Object File Completed!!!");
    println!("---------------------------------------------------------------------------");
    println!("---------------------------------------------------------------------------\n\n");

    // Step 5: Link final executable
    println!("---------------------------------------------------------------------------");
    println!("--------------------------------Step 5-------------------------------------");
    println!("---------------------------------------------------------------------------");
    let build_start5 = Instant::now();
    let link_cmd = if args.inline {
        "clang out_1.o -o final_exe -lpthread".to_string()
    } else {
        "clang out_1.o -o final_exe -L external_instrumentation/target/release/deps -lexternal_instrumentation -lpthread".to_string()
    };
    let build_duration5 = build_start5.elapsed();

    run_command("Linking Final Executable", &link_cmd);
    println!("External Module Instrumentation Completed!!!");
    println!("---------------------------------------------------------------------------");
    println!("---------------------------------------------------------------------------\n\n");

    // Step 6: Run the program with given thread count
    println!("---------------------------------------------------------------------------");
    println!("--------------------------------Step 6-------------------------------------");
    println!("---------------------------------------------------------------------------");
    let run_start = Instant::now();
    // let run_cmd = format!(
    //     "INSTRUMENTATION_MODE={} LD_LIBRARY_PATH=external_instrumentation/target/release/deps ./final_exe {}",
    //     args.instr, args.threads
    // );
    let run_cmd = format!(
        "INSTRUMENTATION_MODE={} LD_LIBRARY_PATH=external_instrumentation/target/release/deps \
        ./final_exe file_example_AVI_640_800kB.avi -w 640 -h 360 --threads={} -o dest.vpx",
        args.instr, args.threads
    );
    run_command("Executing Final Binary", &run_cmd);
    let run_duration = run_start.elapsed();
    println!("Binary Exeuction Finished!!!");
    println!("---------------------------------------------------------------------------");
    println!("---------------------------------------------------------------------------\n\n");

    let build_duration = build_duration2 + build_duration3 + build_duration4 + build_duration5;

    // Output timing summary
    println!("===========================================================================");
    println!("====================== Instrumentation Time Summary =======================");
    println!("Instrumentation Build Time : {:.3} secs", build_duration.as_secs_f64());
    println!("Execution Time             : {:.3} secs", run_duration.as_secs_f64());
    println!("===========================================================================");
}

/// Helper to run shell commands
fn run_command(step: &str, command: &str) {
    println!("==> {}", step);
    let output = Command::new("sh")
        .arg("-c")
        .arg(command)
        .output()
        .expect("failed to run command");

    if !output.stdout.is_empty() {
        println!("{}", String::from_utf8_lossy(&output.stdout));
    }
    if !output.stderr.is_empty() {
        eprintln!("{}", String::from_utf8_lossy(&output.stderr));
    }
}


//cargo build -p llvm-plugin-cli
//==========================================================================================

