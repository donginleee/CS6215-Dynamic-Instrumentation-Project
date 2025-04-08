#!/bin/bash

mkdir -p results
OUTFILE="results/experiment1.log"
rm -f $OUTFILE

BENCHES=("phoenix-string_match" "phoenix-kmeans" "phoenix-pca" "phoenix-linear_regression")
THREADS=(1 2 4 8 16)

# Build Time Comparison (No Inline vs Inline)
for bench in "${BENCHES[@]}"; do
  for inline in "false" "true"; do
    for i in {1..5}; do
      echo "[build] bench=${bench}, inline=${inline}, run=${i}" >> $OUTFILE
      $HOME/llvm-plugin-rs/target/debug/dyin --threads 8 --bench $bench --instr both $( [ "$inline" == "true" ] && echo "--inline" ) \
      | grep -A2 "Instrumentation Time Summary" >> $OUTFILE
    done
  done
done

# Execution Time vs Thread Count (No Inline vs Inline)
for bench in "${BENCHES[@]}"; do
  for thread in "${THREADS[@]}"; do
    for inline in "false" "true"; do
      for i in {1..5}; do
        echo "[exec] bench=${bench}, thread=${thread}, inline=${inline}, run=${i}" >> $OUTFILE
        $HOME/llvm-plugin-rs/target/debug/dyin --bench $bench --instr both --threads $thread $( [ "$inline" == "true" ] && echo "--inline" ) \
        | grep -A2 "Instrumentation Time Summary" >> $OUTFILE
      done
    done
  done
done


# alias RUN_DI="$HOME/llvm-plugin-rs/target/debug/dyin"
# echo $RUN_DI
#!/bin/bash

