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

    /// Calling convention to use (only effective if --inline is false)
    #[arg(long, default_value = "ccc")]
    call: String,

    /// Benchmark to run (e.g., test, phoenix-string_match, etc.)
    #[arg(long, default_value = "test")]
    bench: String,
}

fn main() {
    let args = Cli::parse();

    println!("Running with {} threads", args.threads);
    println!("Instrumentation mode: {}", args.instr);
    println!("Inline instrumentation: {}", args.inline);
    println!("Calling convention: {}", args.call);
    println!("Selected benchmark: {}", args.bench);

    let inline_env = if args.inline {
        "INSTRUMENTATION_INLINE=true"
    } else {
        "INSTRUMENTATION_INLINE=false"
    };

    let call_env = format!("INSTRUMENTATION_CALL={}", args.call);

    // Determine input .ll file path based on benchmark
    let input_ll = match args.bench.as_str() {
        "test" => "in_1.ll",
        "phoenix-string_match" => "/home/dongin/llvm-plugin-rs/phoenix/phoenix-2.0/tests/string_match/string_match-pthread.ll",
        "phoenix-kmeans" => "/home/dongin/llvm-plugin-rs/phoenix/phoenix-2.0/tests/kmeans/kmeans_pthread.ll",
        "phoenix-matrix_multiply" => "/home/dongin/llvm-plugin-rs/phoenix/phoenix-2.0/tests/matrix_multiply/matrix_multiply_pthread.ll",
        "phoenix-pca" => "/home/dongin/llvm-plugin-rs/phoenix/phoenix-2.0/tests/pca/pca_pthread.ll",
        "phoenix-linear_regression" => "/home/dongin/llvm-plugin-rs/phoenix/phoenix-2.0/tests/linear_regression/linear_regression-pthread.ll",
        _ => {
            eprintln!("Unsupported benchmark: {}", args.bench);
            std::process::exit(1);
        }
    };

    println!("===========================================================================");
    println!("=====================CS6215 Dynamic Instrumentation Project================");
    println!("===========================================================================");
    println!("===========================================================================\n\n");

    // Step 1: Compile source into LLVM IR
    println!("---------------------------------------------------------------------------");
    println!("--------------------------------Step 1-------------------------------------");
    println!("---------------------------------------------------------------------------");
    run_command("Compiling pthread.c", "clang -fPIC -O1 -S -emit-llvm pthread.c -o in_1.ll");
    println!("Compilation of Source Code Complete!!!");
    println!("---------------------------------------------------------------------------");
    println!("---------------------------------------------------------------------------\n\n");

    // Step 2: Build instrumentation pass
    println!("---------------------------------------------------------------------------");
    println!("--------------------------------Step 2-------------------------------------");
    println!("---------------------------------------------------------------------------");
    let build_start2 = Instant::now();
    run_command(
        "Building LLVM Pass",
        &format!("{inline_env} {call_env} INSTRUMENTATION_MODE={} cargo build --example concurrent-write --features llvm17-0", args.instr),
    );
    let build_duration2 = build_start2.elapsed();
    println!("Compilation of LLVM Pass Complete!!!\n\n");
    println!("---------------------------------------------------------------------------");

    // Step 3: Instrument the LLVM IR
    println!("---------------------------------------------------------------------------");
    println!("--------------------------------Step 3-------------------------------------");
    println!("---------------------------------------------------------------------------");
    let build_start3 = Instant::now();

    let pass_cmd = format!(
        "INSTRUMENTATION_MODE={} INSTRUMENTATION_INLINE={} INSTRUMENTATION_CALL={} opt --load-pass-plugin=target/debug/examples/libconcurrent_write.so \
        --passes=concurrent-write {} -S -o out_1.ll",
        args.instr, args.inline, args.call, input_ll
    );
    run_command("Running instrumentation pass", &pass_cmd);

    if args.inline {
        let bc_path = "target/release/deps/external_instrumentation_inline.bc";
        run_command("Linking .bc and IR", &format!("llvm-link out_1.ll {} -o linked.ll", bc_path));
        run_command("Running optimizer for inlining", "opt -passes=inline linked.ll -S -o out_1.ll");
    }
    let build_duration3 = build_start3.elapsed();
    println!("Instrumentation Pass Completed!!!\n\n");
    println!("---------------------------------------------------------------------------");

    // Step 4: IR → Object
    println!("---------------------------------------------------------------------------");
    println!("--------------------------------Step 4-------------------------------------");
    println!("---------------------------------------------------------------------------");
    let build_start4 = Instant::now();
    run_command("Generating Object File", "llc -relocation-model=pic -filetype=obj out_1.ll -o out_1.o");
    let build_duration4 = build_start4.elapsed();
    println!("IR to Object File Completed!!!\n\n");
    println!("---------------------------------------------------------------------------");

    // Step 5: Link final executable
    println!("---------------------------------------------------------------------------");
    println!("--------------------------------Step 5-------------------------------------");
    println!("---------------------------------------------------------------------------");
    let build_start5 = Instant::now();
    let link_cmd = if args.inline {
        "clang out_1.o -o final_exe -lpthread".to_string()
    } else {
        "clang out_1.o -o final_exe external_instrumentation/target/release/deps/libexternal_instrumentation.so -lpthread".to_string()
    };
    run_command("Linking Final Executable", &link_cmd);
    let build_duration5 = build_start5.elapsed();
    println!("Linking Completed!!!\n\n");
    println!("---------------------------------------------------------------------------");

    // Step 6: Run the program with given thread count
    println!("---------------------------------------------------------------------------");
    println!("--------------------------------Step 6-------------------------------------");
    println!("---------------------------------------------------------------------------");
    let run_start = Instant::now();
    let run_cmd = match args.bench.as_str() {
        "test" => format!(
            "INSTRUMENTATION_MODE={} LD_LIBRARY_PATH=external_instrumentation/target/release/deps ./final_exe {}",
            args.instr, args.threads
        ),
        "phoenix-string_match" => format!(
            "INSTRUMENTATION_MODE={} LD_LIBRARY_PATH=external_instrumentation/target/release/deps ./final_exe /home/dongin/llvm-plugin-rs/phoenix/phoenix-2.0/tests/string_match/input_large.txt {}",
            args.instr, args.threads
        ),
        "phoenix-kmeans" => format!(
            "INSTRUMENTATION_MODE={} LD_LIBRARY_PATH=external_instrumentation/target/release/deps ./final_exe -d 5 -c 7 -p 2000 -s 100 {}",
            args.instr, args.threads
        ),
        "phoenix-matrix_multiply" => format!(
            "INSTRUMENTATION_MODE={} LD_LIBRARY_PATH=external_instrumentation/target/release/deps ./final_exe 128 1 {}",
            args.instr, args.threads
        ),
        "phoenix-pca" => format!(
            "INSTRUMENTATION_MODE={} LD_LIBRARY_PATH=external_instrumentation/target/release/deps ./final_exe -r 200 -c 200 -s 100 {}",
            args.instr, args.threads
        ),
        "phoenix-linear_regression" => format!(
            "INSTRUMENTATION_MODE={} LD_LIBRARY_PATH=external_instrumentation/target/release/deps ./final_exe /home/dongin/llvm-plugin-rs/phoenix/phoenix-2.0/tests/linear_regression/splitted.txt {}",
            args.instr, args.threads
        ),
        _ => {
            eprintln!("Unsupported benchmark: {}", args.bench);
            std::process::exit(1);
        }
    };
    run_command("Executing Final Binary", &run_cmd);
    let run_duration = run_start.elapsed();

    // Final summary
    let build_duration = build_duration2 + build_duration3 + build_duration4 + build_duration5;
    println!("====================== Instrumentation Time Summary =======================");
    println!("Instrumentation Build Time : {:.3} secs", build_duration.as_secs_f64());
    println!("Execution Time             : {:.3} secs", run_duration.as_secs_f64());
    println!("===========================================================================");
}

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


//cargo build -p dyin
//==========================================================================================