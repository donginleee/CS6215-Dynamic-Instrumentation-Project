use std::collections::HashMap;
use std::sync::Mutex;
use lazy_static::lazy_static;
use std::ffi::c_void;
use libc::malloc_usable_size;

// Shared global map to track the last thread ID that performed a store to a given address
lazy_static! {
    static ref LAST_WRITE_MAP: Mutex<HashMap<usize, u64>> = Mutex::new(HashMap::new());

    // Global environment variable to control instrumentation mode: "store", "load", or "both"
    static ref INSTR_MODE: String = {
        let mode = std::env::var("INSTRUMENTATION_MODE").unwrap_or("both".to_string());
        println!("[debug] INSTRUMENTATION_MODE = {}", mode); 
        mode
    };
}

/// External instrumentation function to get the current thread ID
/// This function will be called from LLVM-instrumented code
#[unsafe(no_mangle)]
pub unsafe extern "C" fn get_thread_id() -> u64 {
    let tid = libc::pthread_self() as u64;
    println!("[debug] get_thread_id() called, tid = {}", tid);
    tid
}

/// External instrumentation function to log a memory store
/// - Filters out null or invalid addresses
/// - Logs the store if instrumentation mode includes "store"
/// - Records the thread ID that performed the store
#[unsafe(no_mangle)]
pub unsafe extern "C" fn log_store(tid: u64, addr: *mut c_void) {
    if addr.is_null() {
        println!("[debug] log_store: NULL address, skipping");
        return;
    }

    let addr_val = addr as usize;

    // Filter out extremely low addresses, which are likely invalid
    if addr_val < 0x1000 {
        println!("[debug] log_store: suspicious address {:#x}, skipping", addr_val);
        return;
    }

    // Verify that memory has not been freed before accessing it
    if malloc_usable_size(addr) == 0 {
        println!("[debug] log_store: freed or invalid memory at {:#x}, skipping", addr_val);
        return;
    }

    // Perform logging only if instrumentation mode includes store
    if INSTR_MODE.as_str() == "store" || INSTR_MODE.as_str() == "both" {
        let mut map = LAST_WRITE_MAP.lock().unwrap();
        map.insert(addr_val, tid);
        println!("[Instrumentation] Store at addr={:#x}, tid={}", addr_val, tid);
    }
}

/// External instrumentation function to log a memory load
/// - Filters out null or invalid addresses
/// - Logs the load if instrumentation mode includes "load"
/// - Reports the thread that last modified the address, if known
#[unsafe(no_mangle)]
pub unsafe extern "C" fn log_load(tid: u64, addr: *mut c_void) {
    if addr.is_null() {
        println!("[debug] log_load: NULL address, skipping");
        return;
    }

    let addr_val = addr as usize;

    // Filter out extremely low addresses, which are likely invalid
    if addr_val < 0x1000 {
        println!("[debug] log_load: suspicious address {:#x}, skipping", addr_val);
        return;
    }

    // Verify that memory has not been freed before accessing it
    if malloc_usable_size(addr) == 0 {
        println!("[debug] log_load: freed or invalid memory at {:#x}, skipping", addr_val);
        return;
    }

    // Perform logging only if instrumentation mode includes load
    if INSTR_MODE.as_str() == "load" || INSTR_MODE.as_str() == "both" {
        let map = LAST_WRITE_MAP.lock().unwrap();
        if let Some(&last_tid) = map.get(&addr_val) {
            if last_tid != tid {
                println!(
                    "[Instrumentation] Load at addr={:#x}, tid={}, last_modified_by={}",
                    addr_val, tid, last_tid
                );
            } else {
                println!(
                    "[Instrumentation] Load at addr={:#x}, tid={}, last_modified_by=the same thread",
                    addr_val, tid
                );
            }
        } else {
            println!(
                "[Instrumentation] Load at addr={:#x}, tid={}, no prior store recorded",
                addr_val, tid
            );
        }
    }
}

// Build this library using: cargo build -p external_instrumentation --release