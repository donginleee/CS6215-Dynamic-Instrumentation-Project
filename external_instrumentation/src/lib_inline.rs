// use std::ffi::c_void;
// use libc;

// const TABLE_SIZE: usize = 65536;
// static mut LAST_WRITES: [u64; TABLE_SIZE] = [0; TABLE_SIZE];

// #[no_mangle]
// pub extern "C" fn get_thread_id() -> u64 {
//     unsafe { libc::syscall(186) as u64 }
// }

// #[no_mangle]
// pub extern "C" fn log_store(tid: u64, addr: *mut c_void) {
//     let index = (addr as usize) % TABLE_SIZE;
//     unsafe {
//         LAST_WRITES[index] = tid;
//         let fmt = b"[Instrumentation] Store at addr=%p, tid=%lu\n\0";
//         // extern "C" {
//             fn printf(fmt: *const u8, ...) -> i32;
//         }
//         printf(fmt.as_ptr(), addr, tid);
//     }
// }

// #[no_mangle]
// pub extern "C" fn log_load(tid: u64, addr: *mut c_void) {
//     let index = (addr as usize) % TABLE_SIZE;
//     unsafe {
//         let prev_tid = LAST_WRITES[index];
//         extern "C" {
//             fn printf(fmt: *const u8, ...) -> i32;
//         }

//         if prev_tid == 0 {
//             let fmt = b"[Instrumentation] Load at addr=%p, tid=%lu, no prior store recorded\n\0";
//             printf(fmt.as_ptr(), addr, tid);
//         } else if prev_tid == tid {
//             let fmt = b"[Instrumentation] Load at addr=%p, tid=%lu, last_modified_by=the same thread\n\0";
//             printf(fmt.as_ptr(), addr, tid);
//         } else {
//             let fmt = b"[Instrumentation] Load at addr=%p, tid=%lu, last_modified_by=%lu\n\0";
//             printf(fmt.as_ptr(), addr, tid, prev_tid);
//         }
//     }
// }
