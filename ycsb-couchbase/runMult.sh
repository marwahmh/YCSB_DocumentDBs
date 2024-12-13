#!/bin/bash

# Define variables
WORKLOADS=("workloada" "workloadb" "workloadc" "workloadd" "workloade" "workloadf")
# WORKLOADS=("workloade")

RECORD_COUNTS=(1000 10000 100000 1000000)
# RECORD_COUNTS=(500000 1000000)
THREAD_COUNTS=(3 6)
OUTPUT_DIR="output"
SCRIPT="bin/run.sh"

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Main loop to iterate over workloads, record counts, and thread counts
for workload in "${WORKLOADS[@]}"; do
  for record_count in "${RECORD_COUNTS[@]}"; do
    for thread_count in "${THREAD_COUNTS[@]}"; do
      # Construct file names for this configuration
      LOAD_FILE="${OUTPUT_DIR}/${workload}-load-${record_count}-${thread_count}.dat"
      RUN_FILE="${OUTPUT_DIR}/${workload}-run-${record_count}-${thread_count}.dat"
      LOG_FILE="${OUTPUT_DIR}/${workload}-log-${record_count}-${thread_count}.txt"

      # Run the script with the current configuration
      echo "Running workload: $workload, Record count: $record_count, Threads: $thread_count"
      $SCRIPT -w workloads/$workload -R $record_count -O $record_count -G $thread_count > "$LOG_FILE" 2>&1

      # Move the generated result files to uniquely named files
      mv "${OUTPUT_DIR}/${workload}-load.dat" "$LOAD_FILE"
      mv "${OUTPUT_DIR}/${workload}-run.dat" "$RUN_FILE"
    done
  done
done

echo "All runs completed. Results are saved in $OUTPUT_DIR."
