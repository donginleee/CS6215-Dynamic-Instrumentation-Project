import re
import csv
import os

# Create the output directory if it doesn't exist
os.makedirs("results", exist_ok=True)

# Input log file (raw output from shell script)
log_file = "results/experiment1.log"

# Output CSV file path
csv_file = "results/experiment1_data.csv"

# Read all lines from the log file
with open(log_file, "r") as f:
    lines = f.readlines()

# List to hold all parsed records
results = []
current = {}

# Parse each line from the log
for line in lines:
    # Start of a new experiment result block
    if line.startswith("[build]") or line.startswith("[exec]"):
        # Reset current record
        current = {}

        # Extract metadata fields like bench=..., thread=..., inline=..., run=...
        parts = re.findall(r'(\w+)=([-\w\d]+)', line)
        for k, v in parts:
            current[k] = v

    # Parse the build time from instrumentation summary
    elif "Build Time" in line:
        current["build_time"] = float(re.search(r"([\d.]+)", line).group(1))

    # Parse the execution time and store the full result
    elif "Execution Time" in line:
        current["exec_time"] = float(re.search(r"([\d.]+)", line).group(1))
        results.append(current)

# Write parsed results into CSV file
with open(csv_file, "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["bench", "thread", "inline", "run", "build_time", "exec_time"])
    writer.writeheader()
    for r in results:
        writer.writerow(r)
