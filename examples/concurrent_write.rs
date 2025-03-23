// use std::collections::HashMap;

use either::Either;
use llvm_plugin::inkwell::values::InstructionOpcode;
// use llvm_plugin::inkwell::builder::Builder;
use llvm_plugin::inkwell::values::BasicValueEnum;
use llvm_plugin::inkwell::values::BasicMetadataValueEnum;
// use llvm_plugin::inkwell::basic_block::BasicBlock;
use llvm_plugin::inkwell::module::Module;
// use llvm_plugin::inkwell::values::FunctionValue;
use llvm_plugin::inkwell::types::FunctionType;
// use llvm_plugin::inkwell::AddressSpace;
use llvm_plugin::{
    ModuleAnalysisManager, LlvmModulePass, PassBuilder,
    // FunctionAnalysisManager, LlvmFunctionPass, PassBuilder,
    PipelineParsing, PreservedAnalyses,
};


#[llvm_plugin::plugin(name = "ConcurrentWrite", version = "0.1")]
fn plugin_registrar(builder: &mut PassBuilder)
{
    builder.add_module_pipeline_parsing_callback(|name, pass_manager| 
    {
        if name == "concurrent-write"
        {
            pass_manager.add_pass(ConcurrentWritePass);
            PipelineParsing::Parsed
        }
        else
        {
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
impl LlvmModulePass for ConcurrentWritePass
{
    fn run_pass(
        &self,
        module: &mut Module,
        _manager: &ModuleAnalysisManager,
    ) -> PreservedAnalyses 
    {
        // Define the type for get_thread_id(): no arguments, returns i64.
        let context = module.get_context();
        
        let i64_type = context.i64_type();
        let tid_fn_type: FunctionType = i64_type.fn_type(&[], false);
        let get_tid_fn = match module.get_function("get_thread_id") {
            Some(f) => f,
            None => module.add_function("get_thread_id", tid_fn_type, None),
        };

        // log_store: void fnType(i64, i8*)
        let i8_ptr_type = context.i8_type().ptr_type(0.into());
        let void_type = context.void_type();
        let log_store_fn_type = void_type.fn_type(&[i64_type.into(), i8_ptr_type.into()], false);
        let log_store_fn = match module.get_function("log_store") {
            Some(f) => f,
            None => module.add_function("log_store", log_store_fn_type, None),
        };

        // log_load: void fnType(i64, i8*)
        let log_load_fn_type = void_type.fn_type(&[i64_type.into(), i8_ptr_type.into()], false);
        let log_load_fn = match module.get_function("log_load") {
            Some(f) => f,
            None => module.add_function("log_load", log_load_fn_type, None),
        };

        //Iterate over every function -> basic block -> instruction in the module
        for func in module.get_functions()
        {
            for bb in func.get_basic_blocks()
            {
                let builder = context.create_builder();
                let instructions: Vec<_> = bb.get_instructions().collect();

                for instr in instructions
                {
                    let opcode = instr.get_opcode();
                    // Identify store or load
                    if opcode == InstructionOpcode::Store 
                    {
                        // 1) Position builder before the store
                        builder.position_before(&instr);

                        // 2) Call get_thread_id()
                        let tid_call = builder
                            .build_call(get_tid_fn, &[], "tid")
                            .expect("Failed to build call get_thread_id");
                        let tid_value = tid_call
                            .try_as_basic_value()
                            .left()
                            .expect("Expected tid_value");

                        // 3) The store instruction's pointer is operand(1)
                        if let Some(Either::Left(BasicValueEnum::PointerValue(ptr_val))) = instr.get_operand(1)
                        {
                            // Insert call: log_store(tid_value, ptr_val)
                            builder.build_call(
                                log_store_fn,
                                &[tid_value.into(), ptr_val.into()],
                                "",
                            );
                        } else 
                        {
                            // If it's a BasicBlock (Either::Left) or a non-pointer BasicValueEnum,
                            // we skip or print debug info
                            eprintln!("Store target is not a valid pointer operand? IR: {:?}", instr);
                        }
                    }
                    else if opcode == InstructionOpcode::Load 
                    {
                        // 1) Position builder before the load
                        builder.position_before(&instr);

                        // 2) Call get_thread_id()
                        let tid_call = builder
                            .build_call(get_tid_fn, &[], "tid")
                            .expect("Failed to build call get_thread_id");
                        let tid_value = tid_call
                            .try_as_basic_value()
                            .left()
                            .expect("Expected tid_value");

                        // load instruction: pointer is operand(0)
                        if let Some(Either::Left(BasicValueEnum::PointerValue(ptr_val))) = instr.get_operand(0)
                        {
                            builder.build_call(
                                log_load_fn,
                                &[tid_value.into(), ptr_val.into()],
                                "",
                            );
                        } else {
                            eprintln!("Load source is not a valid pointer operand? IR: {:?}", instr);
                        }
                    }
                }
            }
        }
        PreservedAnalyses::All
    } 
}


