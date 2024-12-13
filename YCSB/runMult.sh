#!/bin/bash

# Define variables
WORKLOADS=("workloada" "workloadb" "workloadc" "workloadd" "workloade" "workloadf")
# WORKLOADS=("workloadd")

RECORD_COUNTS=(1000 10000 100000 1000000)
# RECORD_COUNTS=(1000000)
# RECORD_COUNTS=(100)
THREAD_COUNTS=(3 6)
# THREAD_COUNTS=(6)
OUTPUT_DIR="Results"
SCRIPT="./bin/ycsb"
SLEEP_DURATION=10

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Main loop to iterate over workloads, record counts, and thread counts
for record_count in "${RECORD_COUNTS[@]}"; do
  for workload in "${WORKLOADS[@]}"; do
  
    LOAD_FILE="${OUTPUT_DIR}/${workload}-load-${record_count}-1.dat"
    echo "Load ${record_count} records for ${workload}"
    $SCRIPT load couchdb -P workloads/$workload -p hosts="127.0.0.1" -p url="http://Admin:password@127.0.0.1:5984" -p recordcount=$record_count -p threadcount=1 -s > "$LOAD_FILE" 2>&1 

    for thread_count in "${THREAD_COUNTS[@]}"; do
      # Construct file names for this configuration
      RUN_FILE="${OUTPUT_DIR}/${workload}-run-${record_count}-${thread_count}.dat"
      # LOG_FILE="${OUTPUT_DIR}/${workload}-log-${record_count}-${thread_count}.txt"

      # Run the script with the current configuration
      echo "Running workload: $workload, Record count: $record_count, Threads: $thread_count"
      $SCRIPT run couchdb -P workloads/$workload -p hosts="127.0.0.1" -p url="http://Admin:password@127.0.0.1:5984" -p recordcount=$record_count -p operationcount=$record_count -p threadcount=$thread_count  -s > "$RUN_FILE"  2>&1
      

    done
    echo "Delete DB of ${record_count} records for ${workload}"
    curl -X DELETE http://Admin:password@127.0.0.1:5984/usertable

    echo "Sleeping for $SLEEP_DURATION seconds..."
    sleep "$SLEEP_DURATION"
    echo "Done."
  done
done

echo "All runs completed. Results are saved in $OUTPUT_DIR."
