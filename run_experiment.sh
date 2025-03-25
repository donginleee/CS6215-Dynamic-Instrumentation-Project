#!/bin/bash

TOOL="$HOME/llvm-plugin-rs/target/debug/dyin"
RESULT_DIR="results"
THREADS=(1 2 4 8 16 32 64)
MODES=("inline" "external")

mkdir -p "$RESULT_DIR"

for MODE in "${MODES[@]}"; do
    for THREAD in "${THREADS[@]}"; do
        echo "========================================"
        echo "Running mode=$MODE, threads=$THREAD"
        echo "========================================"

        LOG_FILE="$RESULT_DIR/result_${MODE}_${THREAD}.log"

        if [ "$MODE" == "inline" ]; then
            $TOOL --threads $THREAD --instr both --inline > "$LOG_FILE"
        else
            $TOOL --threads $THREAD --instr both > "$LOG_FILE"
        fi
    done
done

echo "All experiments completed. Logs are in $RESULT_DIR"
