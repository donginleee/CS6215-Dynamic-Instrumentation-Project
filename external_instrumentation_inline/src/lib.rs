use std::ffi::c_void;

/// Number of entries in the last-write table.
const TABLE_SIZE: usize = 65536;

/// Global table to track the last writing thread ID for each memory slot.
#[unsafe(no_mangle)]
static mut LAST_WRITES: [u64; TABLE_SIZE] = [0; TABLE_SIZE];

/// Inline version of log_store
#[unsafe(no_mangle)]
pub extern "C" fn log_store(tid: u64, addr: *mut c_void) {
    let index = (addr as usize) % TABLE_SIZE;
    unsafe {
        LAST_WRITES[index] = tid;

        // Safe printf call
        unsafe {
            // 👇 extern block must be unsafe
            unsafe extern "C" {
                fn printf(fmt: *const u8, ...) -> i32;
            }
            let msg = b"[Instrumentation] Store at addr=%p, tid=%lu\n\0";
            printf(msg.as_ptr(), addr, tid);
        }
    }
}

/// Inline version of log_load
#[unsafe(no_mangle)]
pub extern "C" fn log_load(tid: u64, addr: *mut c_void) {
    let index = (addr as usize) % TABLE_SIZE;
    unsafe {
        let prev_tid = LAST_WRITES[index];
        // 👇 extern block must be unsafe
        unsafe extern "C" {
            fn printf(fmt: *const u8, ...) -> i32;
        }

        if prev_tid == 0 {
            let msg = b"[Instrumentation] Load at addr=%p, tid=%lu, no prior store recorded\n\0";
            printf(msg.as_ptr(), addr, tid);
        } else if prev_tid == tid {
            let msg = b"[Instrumentation] Load at addr=%p, tid=%lu, last_modified_by=the same thread\n\0";
            printf(msg.as_ptr(), addr, tid);
        } else {
            let msg = b"[Instrumentation] Load at addr=%p, tid=%lu, last_modified_by=%lu\n\0";
            printf(msg.as_ptr(), addr, tid, prev_tid);
        }
    }
}
