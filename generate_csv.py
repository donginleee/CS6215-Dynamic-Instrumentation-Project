import os
import re
import csv

log_dir = "results"
output_dir = "results"
thread_counts = [1, 2, 4, 8, 16, 32, 64]
modes = ["inline", "external"]

# 수정된 정규표현식 (공백 허용, secs 도 허용)
build_time_pattern = re.compile(r"Instrumentation Build Time\s*:\s*([\d.]+)\s*secs?")
exec_time_pattern = re.compile(r"Execution Time\s*:\s*([\d.]+)\s*secs?")

build_data = []
exec_data = []

for mode in modes:
    for thread in thread_counts:
        filename = f"result_{mode}_{thread}.log"
        path = os.path.join(log_dir, filename)
        try:
            with open(path) as f:
                content = f.read()
                build_match = build_time_pattern.search(content)
                exec_match = exec_time_pattern.search(content)
                if build_match and exec_match:
                    build_time = float(build_match.group(1))
                    exec_time = float(exec_match.group(1))
                    build_data.append([thread, mode, build_time])
                    exec_data.append([thread, mode, exec_time])
                else:
                    print(f"[!] Missing data in {filename}")
        except FileNotFoundError:
            print(f"[!] File not found: {path}")

with open(os.path.join(output_dir, "instrumentation_build_time.csv"), "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["Threads", "Mode", "BuildTime(s)"])
    writer.writerows(build_data)

with open(os.path.join(output_dir, "execution_time.csv"), "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["Threads", "Mode", "ExecutionTime(s)"])
    writer.writerows(exec_data)

print("CSV files created in ./results/")
