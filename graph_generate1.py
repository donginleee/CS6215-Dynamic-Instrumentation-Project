import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load data
df = pd.read_csv("results/experiment1_data.csv")

# Clean and map columns
df["inline"] = df["inline"].map({"true": "Inline", "false": "No Inline"})
df["thread"] = df["thread"].fillna("NA").astype(str)

# ==== Build Time Plot ====
df_build = df[df["thread"] == "NA"]
build_avg = df_build.groupby(["bench", "inline"])["build_time"].mean().reset_index()

# Normalize to 'No Inline'
norm = build_avg[build_avg["inline"] == "No Inline"][["bench", "build_time"]].rename(columns={"build_time": "base"})
build_avg = pd.merge(build_avg, norm, on="bench")
build_avg["norm_time"] = build_avg["build_time"] / build_avg["base"]

# Barplot
plt.figure(figsize=(10, 6))
sns.barplot(data=build_avg, x="bench", y="norm_time", hue="inline")
plt.title("Build Time Comparison")
plt.ylabel("Normalized Build Time")
plt.xlabel("Benchmark")
plt.tight_layout()
plt.savefig("results/exp1_build_bar_noerror.png")
plt.close()

# ==== Execution Time Plot ====
df_exec = df[df["thread"] != "NA"].copy()
df_exec["thread"] = df_exec["thread"].astype(int)

exec_avg = df_exec.groupby(["bench", "thread", "inline"])["exec_time"].mean().reset_index()

# Normalize
norm_exec = exec_avg[exec_avg["inline"] == "No Inline"][["bench", "thread", "exec_time"]].rename(columns={"exec_time": "base"})
exec_avg = pd.merge(exec_avg, norm_exec, on=["bench", "thread"])
exec_avg["norm_time"] = exec_avg["exec_time"] / exec_avg["base"]

# Make label: benchmark + thread
exec_avg["label"] = exec_avg["bench"] + "\nThreads " + exec_avg["thread"].astype(str)

# Barplot
plt.figure(figsize=(18, 6))
sns.barplot(data=exec_avg, x="label", y="norm_time", hue="inline")
plt.title("Execution Time")
plt.ylabel("Normalized Execution Time")
plt.xlabel("")
plt.tight_layout()
plt.savefig("results/exp1_exec_bar_noerror.png")
plt.close()
