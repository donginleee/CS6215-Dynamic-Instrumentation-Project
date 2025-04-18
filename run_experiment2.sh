#!/bin/bash

# Create the results directory if it doesn't exist
mkdir -p results

# Output file to save the extracted summary results
SUMMARY_LOG="results/experiment2_summary.log"

# Remove the old summary log file if it exists
rm -f "$SUMMARY_LOG"

# List of benchmarks to test
BENCHES=("phoenix-string_match" "phoenix-kmeans" "phoenix-pca" "phoenix-linear_regression")

# List of calling conventions to compare
CALLS=("ccc" "fastcc" "preserve_mostcc" "preserve_allcc")

# Fixed thread count for all runs in this experiment
THREADS=16

# ==============================
# Run each configuration 5 times
# ==============================
for i in {1..5}; do
  # Print the current run number to terminal and log
  echo "======= Run #$i =======" | tee -a "$SUMMARY_LOG"

  # Loop over each benchmark
  for bench in "${BENCHES[@]}"; do
    # Loop over each calling convention
    for call in "${CALLS[@]}"; do
      # Print current config to log
      echo "[bench=${bench}, call=${call}, run=${i}]" | tee -a "$SUMMARY_LOG"

      # Run the instrumentation tool with specified call convention
      # Use 16 threads and extract summary output only
      $HOME/llvm-plugin-rs/target/debug/dyin \
        --bench "$bench" --instr both --threads "$THREADS" --call "$call" \
        2>&1 | tee /dev/tty | tail -n 15 | grep -A2 "Instrumentation Time Summary" >> "$SUMMARY_LOG"

      # Separate entries in the log
      echo "" >> "$SUMMARY_LOG"
    done
  done
done
