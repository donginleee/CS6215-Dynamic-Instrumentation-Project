import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import os

df = pd.read_csv("results/experiment2_data.csv")

# === Build Time Plot ===
build_stats = df.groupby(["bench", "call"])["build_time"].agg(["mean", "std"]).reset_index()

plt.figure(figsize=(12, 6))
ax = sns.barplot(data=build_stats, x="bench", y="mean", hue="call", ci=None)
# 바 좌표에 맞게 에러바 그리기
for bar, (_, row) in zip(ax.patches, build_stats.iterrows()):
    x = bar.get_x() + bar.get_width() / 2
    y = row["mean"]
    err = row["std"]
    plt.errorbar(x, y, yerr=err, fmt='none', c='black', capsize=4)
plt.title("Experiment 2 - Build Time by Calling Convention")
plt.ylabel("Build Time (s)")
plt.xlabel("Benchmark")
plt.legend(title="Calling Convention")
plt.xticks(rotation=15)
plt.tight_layout()
plt.savefig("results/exp2_build_time_fixed.png")
plt.close()

# === Execution Time Plot ===
exec_stats = df.groupby(["bench", "call"])["exec_time"].agg(["mean", "std"]).reset_index()

plt.figure(figsize=(12, 6))
ax = sns.barplot(data=exec_stats, x="bench", y="mean", hue="call", ci=None)
for bar, (_, row) in zip(ax.patches, exec_stats.iterrows()):
    x = bar.get_x() + bar.get_width() / 2
    y = row["mean"]
    err = row["std"]
    plt.errorbar(x, y, yerr=err, fmt='none', c='black', capsize=4)
plt.title("Experiment 2 - Execution Time by Calling Convention")
plt.ylabel("Execution Time (s)")
plt.xlabel("Benchmark")
plt.legend(title="Calling Convention")
plt.xticks(rotation=15)
plt.tight_layout()
plt.savefig("results/exp2_exec_time_fixed.png")
plt.close()
