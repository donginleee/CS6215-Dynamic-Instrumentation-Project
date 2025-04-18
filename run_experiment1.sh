#!/bin/bash

# Create a directory to store results if it doesn't exist
mkdir -p results

# Log file to store all experiment output
OUTFILE="results/experiment1.log"

# Remove the previous log file if it exists
rm -f "$OUTFILE"

# List of benchmark names to test
BENCHES=("phoenix-string_match" "phoenix-kmeans" "phoenix-pca" "phoenix-linear_regression")

# List of thread counts for execution-time experiments
THREADS=(1 2 4 8 16)

# ========================
# Build Time Comparison
# ========================
# For each benchmark and instrumentation mode (inline vs non-inline),
# run the tool 5 times and record only the build-time summary output.
for bench in "${BENCHES[@]}"; do
  for inline in "false" "true"; do
    for i in {1..5}; do
      # Print the current experiment setting to log and terminal
      echo "[build] bench=${bench}, inline=${inline}, run=${i}" | tee -a "$OUTFILE"
      
      # Run the CLI tool with inline or non-inline option
      # Use 8 threads (though thread count does not affect build time)
      # Save only the final instrumentation summary to the result log
      $HOME/llvm-plugin-rs/target/debug/dyin --threads 8 --bench "$bench" --instr both $( [ "$inline" == "true" ] && echo "--inline" ) \
        2>&1 | tee /dev/tty | tail -n 15 | grep -A2 "Instrumentation Time Summary" >> "$OUTFILE"
      
      # Add a blank line to separate entries
      echo "" >> "$OUTFILE"
    done
  done
done

# ================================
# Execution Time vs Thread Count
# ================================
# For each benchmark, thread count, and instrumentation mode,
# run the tool 5 times and extract the execution-time summary.
for bench in "${BENCHES[@]}"; do
  for thread in "${THREADS[@]}"; do
    for inline in "false" "true"; do
      for i in {1..5}; do
        # Print the current execution configuration
        echo "[exec] bench=${bench}, thread=${thread}, inline=${inline}, run=${i}" | tee -a "$OUTFILE"
        
        # Run the CLI tool with the specified thread count and inline mode
        # Save only the instrumentation summary portion to the log
        $HOME/llvm-plugin-rs/target/debug/dyin --bench "$bench" --instr both --threads "$thread" $( [ "$inline" == "true" ] && echo "--inline" ) \
          2>&1 | tee /dev/tty | tail -n 15 | grep -A2 "Instrumentation Time Summary" >> "$OUTFILE"
        
        # Separate log entries by a blank line
        echo "" >> "$OUTFILE"
      done
    done
  done
done
