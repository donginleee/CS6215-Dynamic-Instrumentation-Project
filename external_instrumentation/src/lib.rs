
use std::collections::HashMap;
use std::sync::Mutex;
use lazy_static::lazy_static;
use std::ffi::c_void;
// use std::ffi::{c_void, CStr};
// use std::os::raw::{c_char, c_ulonglong};

// Shared map to track the last thread that wrote to each memory address
// lazy_static! {
//     static ref LAST_WRITE_MAP: Mutex<HashMap<usize, u64>> = Mutex::new(HashMap::new());
//     static ref INSTR_MODE: String = std::env::var("INSTRUMENTATION_MODE").unwrap_or("both".to_string());
// }
lazy_static! {
    static ref LAST_WRITE_MAP: Mutex<HashMap<usize, u64>> = Mutex::new(HashMap::new());
    static ref INSTR_MODE: String = {
        let mode = std::env::var("INSTRUMENTATION_MODE").unwrap_or("both".to_string());
        println!("[debug] INSTRUMENTATION_MODE = {}", mode); 
        mode
    };
}


/// Returns the calling thread's unique ID
#[unsafe(no_mangle)]
pub extern "C" fn get_thread_id() -> u64 {
    // Use pthread_self() from libc to get the current thread ID.
    // Casting pthread_t to u64 (platform-dependent conversion)
    unsafe { libc::pthread_self() as u64 }
}

// Logs a store operation if instrumentation mode includes "store"
#[unsafe(no_mangle)]
pub extern "C" fn log_store(tid: u64, addr: *mut c_void) {
    if INSTR_MODE.as_str() == "store" || INSTR_MODE.as_str() == "both" {
        let mut map = LAST_WRITE_MAP.lock().unwrap();
        map.insert(addr as usize, tid);
        println!("[Instrumentation] Store at addr={:#x}, tid={}", addr as usize, tid);
    }
}
// pub extern "C" fn log_store(tid: u64, addr: *mut c_void) {
//     let mode = std::env::var("INSTRUMENTATION_MODE").unwrap_or("both".to_string());
//     if mode == "load" {
//         let mut map = LAST_WRITE_MAP.lock().unwrap();
//         map.insert(addr as usize, tid);
//         println!("[Instrumentation] Store at addr={:#x}, tid={}", addr as usize, tid);
//     }
// }

/// Logs a load operation if instrumentation mode includes "load"
#[unsafe(no_mangle)]
pub extern "C" fn log_load(tid: u64, addr: *mut c_void) {
    if INSTR_MODE.as_str() == "load" || INSTR_MODE.as_str() == "both" {
        let map = LAST_WRITE_MAP.lock().unwrap();
        if let Some(&last_tid) = map.get(&(addr as usize)) {
            if last_tid != tid {
                println!(
                    "[Instrumentation] Load at addr={:#x}, tid={}, last_modified_by={}",
                    addr as usize, tid, last_tid
                );
            } else {
                println!(
                    "[Instrumentation] Load at addr={:#x}, tid={}, last_modified_by=the same thread",
                    addr as usize, tid
                );
            }
        } else {
            println!(
                "[Instrumentation] Load at addr={:#x}, tid={}, no prior store recorded",
                addr as usize, tid
            );
        }
    }
}

// pub extern "C" fn log_load(tid: u64, addr: *mut c_void) {
//     let mode = std::env::var("INSTRUMENTATION_MODE").unwrap_or("both".to_string());
//     if mode == "store" {
//         let map = LAST_WRITE_MAP.lock().unwrap();
//         if let Some(&last_tid) = map.get(&(addr as usize)) {
//             if last_tid != tid {
//                 println!(
//                     "[Instrumentation] Load at addr={:#x}, tid={}, last_modified_by={}",
//                     addr as usize, tid, last_tid
//                 );
//             }
//         }
//     }
// }

// #cargo build -p external_instrumentation --release