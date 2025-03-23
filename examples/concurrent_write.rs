use either::Either;
use llvm_plugin::inkwell::values::{InstructionOpcode, BasicValueEnum};
use llvm_plugin::inkwell::module::Module;
// use llvm_plugin::inkwell::types::PointerType;
use llvm_plugin::{
    ModuleAnalysisManager, LlvmModulePass, PassBuilder,
    PipelineParsing, PreservedAnalyses,
};
// use llvm_plugin::inkwell::AddressSpace;

/// Register this file as an LLVM plugin named "concurrent-write"
#[llvm_plugin::plugin(name = "ConcurrentWrite", version = "0.1")]
fn plugin_registrar(builder: &mut PassBuilder) {
    builder.add_module_pipeline_parsing_callback(|name, pass_manager| {
        if name == "concurrent-write" {
            pass_manager.add_pass(ConcurrentWritePass::new());
            PipelineParsing::Parsed
        } else {
            PipelineParsing::NotParsed
        }
    });
}

/// Our pass struct to hold instrumentation mode ("store", "load", or "both")
struct ConcurrentWritePass {
    instr_mode: String,
}

impl ConcurrentWritePass {
    /// Initialize the pass by reading the environment variable once
    pub fn new() -> Self {
        let instr_mode = std::env::var("INSTRUMENTATION_MODE").unwrap_or("both".to_string());
        println!("[pass debug] INSTRUMENTATION_MODE = {}", instr_mode);
        Self { instr_mode }
    }
}

impl LlvmModulePass for ConcurrentWritePass {
    fn run_pass(&self, module: &mut Module, _manager: &ModuleAnalysisManager) -> PreservedAnalyses {
        let context = module.get_context();

        let i64_type = context.i64_type();
        let i8_ptr_type = context.i8_type().ptr_type(0.into()); // pointer to i8
        let void_type = context.void_type();

        // Declare or get external function: u64 get_thread_id()
        let get_tid_fn = module.get_function("get_thread_id").unwrap_or_else(|| {
            module.add_function("get_thread_id", i64_type.fn_type(&[], false), None)
        });

        // Declare or get external function: void log_store(u64 tid, void* addr)
        let log_store_fn = module.get_function("log_store").unwrap_or_else(|| {
            module.add_function("log_store", void_type.fn_type(&[i64_type.into(), i8_ptr_type.into()], false), None)
        });

        // Declare or get external function: void log_load(u64 tid, void* addr)
        let log_load_fn = module.get_function("log_load").unwrap_or_else(|| {
            module.add_function("log_load", void_type.fn_type(&[i64_type.into(), i8_ptr_type.into()], false), None)
        });

        for func in module.get_functions() {
            for bb in func.get_basic_blocks() {
                let builder = context.create_builder();
                let instructions: Vec<_> = bb.get_instructions().collect();

                for instr in instructions {
                    let opcode = instr.get_opcode();

                    // Insert log_store if mode is "store" or "both"
                    if opcode == InstructionOpcode::Store && (self.instr_mode == "store" || self.instr_mode == "both") {
                        builder.position_before(&instr);
                        let tid = builder
                            .build_call(get_tid_fn, &[], "tid")
                            .unwrap()
                            .try_as_basic_value()
                            .left()
                            .unwrap();

                        // Get destination address (operand 1 of store)
                        if let Some(Either::Left(BasicValueEnum::PointerValue(ptr_val))) = instr.get_operand(1) {
                            builder.build_call(log_store_fn, &[tid.into(), ptr_val.into()], "").ok();
                        }
                    }

                    // Insert log_load if mode is "load" or "both"
                    if opcode == InstructionOpcode::Load && (self.instr_mode == "load" || self.instr_mode == "both") {
                        builder.position_before(&instr);
                        let tid = builder
                            .build_call(get_tid_fn, &[], "tid")
                            .unwrap()
                            .try_as_basic_value()
                            .left()
                            .unwrap();

                        // Get source address (operand 0 of load)
                        if let Some(Either::Left(BasicValueEnum::PointerValue(ptr_val))) = instr.get_operand(0) {
                            builder.build_call(log_load_fn, &[tid.into(), ptr_val.into()], "").ok();
                        }
                    }
                }
            }
        }

        PreservedAnalyses::All
    }
}
