#!/bin/bash

mkdir -p results
SUMMARY_LOG="results/experiment2_summary.log"
rm -f "$SUMMARY_LOG"

BENCHES=("phoenix-string_match" "phoenix-kmeans" "phoenix-pca" "phoenix-linear_regression")
CALLS=("ccc" "fastcc" "preserve_mostcc" "preserve_allcc")

THREADS=1

for i in {1..5}; do
  echo "======= Run #$i =======" | tee -a "$SUMMARY_LOG"
  for bench in "${BENCHES[@]}"; do
    for call in "${CALLS[@]}"; do
      echo "[bench=${bench}, call=${call}, run=${i}]" | tee -a "$SUMMARY_LOG"

      $HOME/llvm-plugin-rs/target/debug/dyin \
        --bench "$bench" --instr both --threads "$THREADS" --call "$call" \
        2>&1 | tee /dev/tty | tail -n 15 | grep -A2 "Instrumentation Time Summary" >> "$SUMMARY_LOG"

      echo "" >> "$SUMMARY_LOG"
    done
  done
done
