use either::Either;
use llvm_plugin::inkwell::values::{BasicValueEnum, InstructionOpcode};
use llvm_plugin::inkwell::module::Module;
use llvm_plugin::{
    LlvmModulePass, ModuleAnalysisManager, PassBuilder, PipelineParsing, PreservedAnalyses,
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

/// Struct representing our instrumentation pass
struct ConcurrentWritePass {
    instr_mode: String,
    inline_mode: bool,
}

impl ConcurrentWritePass {
    pub fn new() -> Self {
        let instr_mode = std::env::var("INSTRUMENTATION_MODE").unwrap_or_else(|_| "both".into());
        let inline_mode = std::env::var("INSTRUMENTATION_INLINE")
            .map(|v| v == "true")
            .unwrap_or(false);
        println!("[pass debug] INSTRUMENTATION_MODE = {}", instr_mode);
        println!("[pass debug] INSTRUMENTATION_INLINE = {}", inline_mode);
        Self {
            instr_mode,
            inline_mode,
        }
    }
}

impl LlvmModulePass for ConcurrentWritePass {
    fn run_pass(
        &self,
        module: &mut Module,
        _manager: &ModuleAnalysisManager,
    ) -> PreservedAnalyses {
        let context = module.get_context();
        let i64_type = context.i64_type();
        let i8_ptr_type = context.i8_type().ptr_type(0.into());
        // let i8_ptr_type = context.ptr_type(context.i8_type(), 0);
        let void_type = context.void_type();

        // External function declarations
        let pthread_self_fn = module.get_function("pthread_self").unwrap_or_else(|| {
            module.add_function("pthread_self", i64_type.fn_type(&[], false), None)
        });

        let log_store_fn = module.get_function("log_store").unwrap_or_else(|| {
            module.add_function(
                "log_store",
                void_type.fn_type(&[i64_type.into(), i8_ptr_type.into()], false),
                None,
            )
        });

        let log_load_fn = module.get_function("log_load").unwrap_or_else(|| {
            module.add_function(
                "log_load",
                void_type.fn_type(&[i64_type.into(), i8_ptr_type.into()], false),
                None,
            )
        });

        // Instrumentation logic
        for func in module.get_functions() {
            for bb in func.get_basic_blocks() {
                let builder = context.create_builder();
                let instrs: Vec<_> = bb.get_instructions().collect();

                for instr in instrs {
                    let opcode = instr.get_opcode();

                    // Instrument store
                    if opcode == InstructionOpcode::Store
                        && (self.instr_mode == "store" || self.instr_mode == "both")
                    {
                        builder.position_before(&instr);

                        let tid = builder
                            .build_call(pthread_self_fn, &[], "tid")
                            .unwrap()
                            .try_as_basic_value()
                            .left()
                            .unwrap();

                        if let Some(Either::Left(BasicValueEnum::PointerValue(ptr))) =
                            instr.get_operand(1)
                        {
                            builder.build_call(log_store_fn, &[tid.into(), ptr.into()], "").ok();
                        }
                    }

                    // Instrument load
                    if opcode == InstructionOpcode::Load
                        && (self.instr_mode == "load" || self.instr_mode == "both")
                    {
                        builder.position_before(&instr);

                        let tid = builder
                            .build_call(pthread_self_fn, &[], "tid")
                            .unwrap()
                            .try_as_basic_value()
                            .left()
                            .unwrap();

                        if let Some(Either::Left(BasicValueEnum::PointerValue(ptr))) =
                            instr.get_operand(0)
                        {
                            builder.build_call(log_load_fn, &[tid.into(), ptr.into()], "").ok();
                        }
                    }
                }
            }
        }

        PreservedAnalyses::All
    }
}
