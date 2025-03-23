use llvm_plugin::inkwell::{
    module::Module,
    values::{BasicValueEnum, InstructionOpcode},
    types::FunctionType,
};
use llvm_plugin::{
    LlvmModulePass, ModuleAnalysisManager, PassBuilder,
    PipelineParsing, PreservedAnalyses,
};
// Note: In inkwell 0.5, get_operand returns Option<Either<BasicValueEnum<'ctx>, BasicBlock<'ctx>>>
use either::Either;

#[llvm_plugin::plugin(name = "ConcurrentWrite", version = "0.1")]
fn plugin_registrar(builder: &mut PassBuilder) {
    builder.add_module_pipeline_parsing_callback(|name, pass_manager| {
        if name == "concurrent-write" {
            pass_manager.add_pass(ConcurrentWritePass);
            PipelineParsing::Parsed
        } else {
            PipelineParsing::NotParsed
        }
    });
}

extern "C" {
    fn get_thread_id() -> u64;
    fn log_store(tid: u64, addr: *mut core::ffi::c_void);
    fn log_load(tid: u64, addr: *mut core::ffi::c_void);
}

struct ConcurrentWritePass;

impl LlvmModulePass for ConcurrentWritePass {
    fn run_pass(
        &self,
        module: &mut Module,
        _manager: &ModuleAnalysisManager,
    ) -> PreservedAnalyses {
        let context = module.get_context();

        // get_thread_id()
        let i64_type = context.i64_type();
        let tid_fn_type: FunctionType = i64_type.fn_type(&[], false);
        let get_tid_fn = match module.get_function("get_thread_id") {
            Some(f) => f,
            None => module.add_function("get_thread_id", tid_fn_type, None),
        };

        // log_store(tid, i8*)
        let void_type = context.void_type();
        let i8_ptr_type = context.i8_type().ptr_type(0);
        let log_store_fn_type = void_type.fn_type(&[i64_type.into(), i8_ptr_type.into()], false);
        let log_store_fn = match module.get_function("log_store") {
            Some(f) => f,
            None => module.add_function("log_store", log_store_fn_type, None),
        };

        // log_load(tid, i8*)
        let log_load_fn_type = void_type.fn_type(&[i64_type.into(), i8_ptr_type.into()], false);
        let log_load_fn = match module.get_function("log_load") {
            Some(f) => f,
            None => module.add_function("log_load", log_load_fn_type, None),
        };

        for func in module.get_functions() {
            for bb in func.get_basic_blocks() {
                let builder = context.create_builder();
                let instructions: Vec<_> = bb.get_instructions().collect();

                for instr in instructions {
                    let opcode = instr.get_opcode();

                    // Store: pointer is operand(1)
                    if opcode == InstructionOpcode::Store {
                        builder.position_before(&instr);

                        // get_thread_id()
                        let tid_call = builder
                            .build_call(get_tid_fn, &[], "tid")
                            .expect("Failed to call get_thread_id");
                        let tid_value = tid_call
                            .try_as_basic_value()
                            .left()
                            .expect("Expected tid_value from get_thread_id");

                        // Check operand(1) -> Option<Either<BasicValueEnum, BasicBlock>>
                        if let Some(Either::Left(BasicValueEnum::PointerValue(ptr_val))) =
                            instr.get_operand(1)
                        {
                            // Insert call log_store(tid, ptr_val)
                            builder.build_call(
                                log_store_fn,
                                &[tid_value.into(), ptr_val.into()],
                                "",
                            );
                        } else {
                            eprintln!("Store operand(1) is not a pointer or is BasicBlock. Skipped.");
                        }
                    }
                    // Load: pointer is operand(0)
                    else if opcode == InstructionOpcode::Load {
                        builder.position_before(&instr);

                        let tid_call = builder
                            .build_call(get_tid_fn, &[], "tid")
                            .expect("Failed to call get_thread_id");
                        let tid_value = tid_call
                            .try_as_basic_value()
                            .left()
                            .expect("Expected tid_value from get_thread_id");

                        // Check operand(0) -> Option<Either<BasicValueEnum, BasicBlock>>
                        if let Some(Either::Left(BasicValueEnum::PointerValue(ptr_val))) =
                            instr.get_operand(0)
                        {
                            // Insert call log_load(tid, ptr_val)
                            builder.build_call(
                                log_load_fn,
                                &[tid_value.into(), ptr_val.into()],
                                "",
                            );
                        } else {
                            eprintln!("Load operand(0) is not a pointer or is BasicBlock. Skipped.");
                        }
                    }
                }
            }
        }

        PreservedAnalyses::All
    }
}
