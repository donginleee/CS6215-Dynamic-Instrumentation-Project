import pandas as pd
import matplotlib.pyplot as plt

# Load CSVs
build_df = pd.read_csv("results/instrumentation_build_time.csv")
exec_df = pd.read_csv("results/execution_time.csv")

# Normalize column names
build_df.columns = build_df.columns.str.strip().str.lower().str.replace("(s)", "", regex=False)
exec_df.columns = exec_df.columns.str.strip().str.lower().str.replace("(s)", "", regex=False)

# Convert seconds → milliseconds
build_df["buildtime"] *= 1000
exec_df["executiontime"] *= 1000

# Sort for plotting
build_df = build_df.sort_values("threads")
exec_df = exec_df.sort_values("threads")

# Split inline / external
build_inline = build_df[build_df["mode"] == "inline"]
build_external = build_df[build_df["mode"] == "external"]
exec_inline = exec_df[exec_df["mode"] == "inline"]
exec_external = exec_df[exec_df["mode"] == "external"]

# 색깔을 통일해서 inline은 파랑, external은 주황
inline_color = "#1f77b4"   # 논문에서 자주 쓰는 파랑
external_color = "#ff7f0e" # 논문에서 자주 쓰는 주황

# Set up figure with 2 subplots (side-by-side)
fig, axs = plt.subplots(1, 2, figsize=(12, 5), sharex=True)

# --- Build Time Plot ---
axs[0].plot(build_inline["threads"], build_inline["buildtime"], marker='o',
            linestyle='-', color=inline_color, label="Inline")
axs[0].plot(build_external["threads"], build_external["buildtime"], marker='o',
            linestyle='-', color=external_color, label="External")
axs[0].set_title("Instrumentation Build Time")
axs[0].set_ylabel("Time (ms)")
axs[0].set_xlabel("Number of Threads")
axs[0].legend()

# --- Execution Time Plot ---
axs[1].plot(exec_inline["threads"], exec_inline["executiontime"], marker='s',
            linestyle='--', color=inline_color, label="Inline")
axs[1].plot(exec_external["threads"], exec_external["executiontime"], marker='s',
            linestyle='--', color=external_color, label="External")
axs[1].set_title("Execution Time")
axs[1].set_ylabel("Time (ms)")
axs[1].set_xlabel("Number of Threads")
axs[1].legend()

# Layout, save
plt.tight_layout()
plt.savefig("results/final_overhead_comparison.png", dpi=300)
plt.show()
