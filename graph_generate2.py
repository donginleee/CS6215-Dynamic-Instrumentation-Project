import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load experiment 2 results from CSV
df = pd.read_csv("results/experiment2_data.csv")
sns.set(style="whitegrid", font_scale=1.2)

# Define distinct color mapping for each calling convention
vibrant_palette = {
    'ccc': '#1f77b4',
    'fastcc': '#ff7f0e',
    'preserve_allcc': '#2ca02c',
    'preserve_mostcc': '#d62728'
}

# ========== BUILD TIME ==========

# Compute mean and standard deviation of build time
build_stats = df.groupby(["bench", "call"]).agg(
    mean=("build_time", "mean"),
    std=("build_time", "std")
).reset_index()

# Save the aggregated stats to CSV
build_stats.to_csv("results/exp2_build_time_stat.csv", index=False)

# Create bar plot for build time
plt.figure(figsize=(12, 6))
ax = sns.barplot(
    data=build_stats,
    x="bench",
    y="mean",
    hue="call",
    palette=vibrant_palette,
    ci=None,
    capsize=0.1
)

# Manually add error bars to each bar
bench_list = build_stats["bench"].unique()
call_list = build_stats["call"].unique()
n_hue = len(call_list)
width = 0.8
bar_width = width / n_hue

for i, row in build_stats.iterrows():
    bench_idx = list(bench_list).index(row["bench"])
    call_idx = list(call_list).index(row["call"])
    x = bench_idx - width / 2 + bar_width * call_idx + bar_width / 2
    y = row["mean"]
    yerr = row["std"]
    ax.errorbar(x, y, yerr=yerr, fmt='none', c='black', capsize=4)

# Set title, axis labels, and tick appearance
ax.set_title("Experiment 2 - Build Time by Calling Convention", fontsize=14, color='black')
ax.set_ylabel("Build Time (s)", fontsize=12, color='black')
ax.set_xlabel("Benchmark", fontsize=12, color='black')
ax.set_xticklabels(bench_list, rotation=15)
ax.tick_params(axis='x', colors='black')
ax.tick_params(axis='y', colors='black')
for spine in ax.spines.values():
    spine.set_edgecolor('black')

# Place the legend near the bottom-left of the plot
plt.legend(
    title="Calling Convention",
    loc='lower left',
    bbox_to_anchor=(0, 0.02),
    ncol=1,
    fontsize=11,
    title_fontsize=12
)

plt.tight_layout()
plt.savefig("results/exp2_build_time_final.png")
plt.show()

# ========== EXECUTION TIME ==========

# Compute mean and standard deviation of execution time
exec_stats = df.groupby(["bench", "call"]).agg(
    mean=("exec_time", "mean"),
    std=("exec_time", "std")
).reset_index()

# Save aggregated execution time stats
exec_stats.to_csv("results/exp2_exec_time_stat.csv", index=False)

# Create bar plot for execution time
plt.figure(figsize=(12, 6))
ax = sns.barplot(
    data=exec_stats,
    x="bench",
    y="mean",
    hue="call",
    palette=vibrant_palette,
    ci=None,
    capsize=0.1
)

# Manually add error bars to each bar
for i, row in exec_stats.iterrows():
    bench_idx = list(bench_list).index(row["bench"])
    call_idx = list(call_list).index(row["call"])
    x = bench_idx - width / 2 + bar_width * call_idx + bar_width / 2
    y = row["mean"]
    yerr = row["std"]
    ax.errorbar(x, y, yerr=yerr, fmt='none', c='black', capsize=4)

# Set title, labels, and visual styling
ax.set_title("Experiment 2 - Execution Time by Calling Convention", fontsize=14, color='black')
ax.set_ylabel("Execution Time (s)", fontsize=12, color='black')
ax.set_xlabel("Benchmark", fontsize=12, color='black')
ax.set_xticklabels(bench_list, rotation=15)
ax.tick_params(axis='x', colors='black')
ax.tick_params(axis='y', colors='black')
for spine in ax.spines.values():
    spine.set_edgecolor('black')

# Place the legend in the top-left corner
plt.legend(
    title="Calling Convention",
    loc='upper left',
    bbox_to_anchor=(0, 1),
    fontsize=11,
    title_fontsize=12
)

plt.tight_layout()
plt.savefig("results/exp2_exec_time_final.png")
plt.show()
