use std::process::Command;

fn main() {
    let status = Command::new("rustc")
        .args(&[
            "--crate-type=lib",
            "--emit=llvm-bc",
            "-C", "opt-level=3",
            "src/lib_inline.rs",
            "-o", "libinline.bc"
        ])
        .status()
        .expect("failed to run rustc");

    if !status.success() {
        panic!("rustc failed with status: {:?}", status);
    }
}
