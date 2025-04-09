import re
import csv
import os

os.makedirs("results", exist_ok=True)
log_file = "results/experiment2_summary.log"
csv_file = "results/experiment2_data.csv"

with open(log_file, "r") as f:
    lines = f.readlines()

results = []
current = {}

for line in lines:
    if line.startswith("[bench="):
        # Parse metadata
        current = {}
        parts = re.findall(r'(\w+)=([-\w\d]+)', line)
        for k, v in parts:
            current[k] = v
    elif "Build Time" in line:
        current["build_time"] = float(re.search(r"([\d.]+)", line).group(1))
    elif "Execution Time" in line:
        current["exec_time"] = float(re.search(r"([\d.]+)", line).group(1))
        results.append(current)

with open(csv_file, "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["bench", "call", "run", "build_time", "exec_time"])
    writer.writeheader()
    for r in results:
        writer.writerow(r)
