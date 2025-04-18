use either::Either;
use llvm_plugin::inkwell::values::{BasicValueEnum, InstructionOpcode};
use llvm_plugin::inkwell::{module::Module, module::Linkage, types::BasicType};
use llvm_plugin::{
    LlvmModulePass, ModuleAnalysisManager, PassBuilder, PipelineParsing, PreservedAnalyses,
};

// Registers the plugin with LLVM's pass builder pipeline.
// If the pass name is "concurrent-write", we attach our custom pass.
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

// Struct to hold configuration for the pass from environment variables.
struct ConcurrentWritePass {
    instr_mode: String,   // Instrumentation mode: "store", "load", or "both"
    inline_mode: bool,    // Whether to use inline instrumentation
    call_conv: String,    // Calling convention to use
}

impl ConcurrentWritePass {
    // Initializes the pass configuration from environment variables.
    pub fn new() -> Self {
        let instr_mode = std::env::var("INSTRUMENTATION_MODE").unwrap_or_else(|_| "both".into());
        let inline_mode = std::env::var("INSTRUMENTATION_INLINE")
            .map(|v| v == "true")
            .unwrap_or(false);
        let call_conv = std::env::var("INSTRUMENTATION_CALL").unwrap_or_else(|_| "ccc".into());

        println!("[pass debug] INSTRUMENTATION_MODE = {}", instr_mode);
        println!("[pass debug] INSTRUMENTATION_INLINE = {}", inline_mode);
        println!("[pass debug] INSTRUMENTATION_CALL = {}", call_conv);

        Self {
            instr_mode,
            inline_mode,
            call_conv,
        }
    }

    // Maps calling convention names to LLVM numeric identifiers.
    fn get_calling_convention(&self) -> u32 {
        match self.call_conv.as_str() {
            "fastcc" => 8,
            "coldcc" => 9,
            "preserve_mostcc" => 14,
            "preserve_allcc" => 15,
            _ => 0, // Default is ccc
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
        let void_type = context.void_type();
        let call_conv_id = self.get_calling_convention();

        // Declare or reuse external function symbols (depending on inline mode).
        let get_thread_id_fn = if self.inline_mode {
            // Inline mode: directly call pthread_self.
            module.get_function("pthread_self").unwrap_or_else(|| {
                module.add_function("pthread_self", i64_type.fn_type(&[], false), None)
            })
        } else {
            // Non-inline mode: use wrapper from external library.
            let func = module.get_function("get_thread_id").unwrap_or_else(|| {
                module.add_function("get_thread_id", i64_type.fn_type(&[], false), None)
            });
            func.set_call_conventions(call_conv_id);
            func
        };

        let log_store_fn = {
            let func = module.get_function("log_store").unwrap_or_else(|| {
                module.add_function(
                    "log_store",
                    void_type.fn_type(&[i64_type.into(), i8_ptr_type.into()], false),
                    None,
                )
            });
            if !self.inline_mode {
                func.set_call_conventions(call_conv_id);
            }
            func
        };

        let log_load_fn = {
            let func = module.get_function("log_load").unwrap_or_else(|| {
                module.add_function(
                    "log_load",
                    void_type.fn_type(&[i64_type.into(), i8_ptr_type.into()], false),
                    None,
                )
            });
            if !self.inline_mode {
                func.set_call_conventions(call_conv_id);
            }
            func
        };

        // Iterate over all functions and basic blocks to insert instrumentation.
        for func in module.get_functions() {
            for bb in func.get_basic_blocks() {
                let builder = context.create_builder();
                let instrs: Vec<_> = bb.get_instructions().collect();

                for instr in instrs {
                    let opcode = instr.get_opcode();

                    // Store instrumentation
                    if opcode == InstructionOpcode::Store
                        && (self.instr_mode == "store" || self.instr_mode == "both")
                    {
                        builder.position_before(&instr);

                        let tid = builder
                            .build_call(get_thread_id_fn, &[], "tid")
                            .unwrap()
                            .try_as_basic_value()
                            .left()
                            .unwrap();

                        // Operand 1 is the pointer being stored into
                        if let Some(Either::Left(BasicValueEnum::PointerValue(ptr))) =
                            instr.get_operand(1)
                        {
                            builder.build_call(log_store_fn, &[tid.into(), ptr.into()], "").ok();
                        }
                    }

                    // Load instrumentation
                    if opcode == InstructionOpcode::Load
                        && (self.instr_mode == "load" || self.instr_mode == "both")
                    {
                        builder.position_before(&instr);

                        let tid = builder
                            .build_call(get_thread_id_fn, &[], "tid")
                            .unwrap()
                            .try_as_basic_value()
                            .left()
                            .unwrap();

                        // Operand 0 is the pointer being loaded from
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
