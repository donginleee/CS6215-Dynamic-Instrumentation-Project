import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load experiment 1 result CSV
df = pd.read_csv("results/experiment1_data.csv")
sns.set(style="whitegrid", font_scale=1.2)

# Define color palette for inlined vs non-inlined cases
color_palette = {False: "#1f77b4", True: "#ff7f0e"}
inline_labels = {False: "Non-Inlined", True: "Inlined"}

# ================= BUILD TIME PLOT =================

# Use only data where thread count is 8 for build time comparison
build_df = df[df["thread"] == 8]

# Aggregate build time statistics (mean and standard deviation)
build_agg = build_df.groupby(["bench", "inline"]).agg(
    mean=("build_time", "mean"),
    std=("build_time", "std")
).reset_index()

# Save summarized build statistics
build_agg.to_csv("results/exp1_build_time_stat.csv", index=False)

# Plot build time comparison
plt.figure(figsize=(8, 5))
ax1 = sns.barplot(
    data=build_agg,
    x="bench",
    y="mean",
    hue="inline",
    palette=color_palette,
    dodge=True,
    width=0.9
)

# Add error bars manually
bar_offset = 0.2
bench_labels = build_agg["bench"].unique()
for bench, inline in zip(build_agg["bench"], build_agg["inline"]):
    idx = list(bench_labels).index(bench)
    x = idx - bar_offset if not inline else idx + bar_offset
    y = build_agg[(build_agg["bench"] == bench) & (build_agg["inline"] == inline)]["mean"].values[0]
    yerr = build_agg[(build_agg["bench"] == bench) & (build_agg["inline"] == inline)]["std"].values[0]
    ax1.errorbar(x, y, yerr=yerr, fmt='none', capsize=5, color='black')

# Customize legend with readable labels
handles, labels = ax1.get_legend_handles_labels()
custom_labels = [inline_labels[eval(l)] for l in labels]
ax1.legend(
    handles, custom_labels,
    title="Instrumentation Mode",
    fontsize=11,
    title_fontsize=12,
    handlelength=2.5,
    handleheight=1.5
)

# Set plot styling and axes
ax1.set_title("Build Time Comparison", fontsize=15, color="black")
ax1.set_ylabel("Build Time (secs)", fontsize=13, color="black")
ax1.set_xlabel("", color="black")
ax1.set_xticklabels(bench_labels, rotation=30, ha="right", color="black")
ax1.tick_params(axis='x', pad=8)
for spine in ax1.spines.values():
    spine.set_edgecolor('black')

plt.tight_layout()
plt.savefig("results/build_time_comparison.png")
plt.show()

# ================= EXECUTION TIME PLOT =================

# Use non-thread-8 runs to compare execution time across threads
exec_df = df[df["thread"] != 8]

# Aggregate execution statistics (mean and standard deviation)
exec_agg = exec_df.groupby(["bench", "thread", "inline"]).agg(
    mean=("exec_time", "mean"),
    std=("exec_time", "std")
).reset_index()

# Create x-axis labels including thread info
exec_agg["x_label"] = exec_agg.apply(lambda row: f"{row['bench']}\nThreads {row['thread']}", axis=1)

# Save summarized execution time statistics
exec_agg.to_csv("results/exp1_exec_time_stat.csv", index=False)

# Plot execution time comparison
plt.figure(figsize=(24, 8))
ax2 = sns.barplot(
    data=exec_agg,
    x="x_label",
    y="mean",
    hue="inline",
    palette=color_palette,
    dodge=True,
    width=0.9
)

# Add error bars manually
x_labels = exec_agg["x_label"].unique()
for label, inline in zip(exec_agg["x_label"], exec_agg["inline"]):
    idx = list(x_labels).index(label)
    x = idx - bar_offset if not inline else idx + bar_offset
    y = exec_agg[(exec_agg["x_label"] == label) & (exec_agg["inline"] == inline)]["mean"].values[0]
    yerr = exec_agg[(exec_agg["x_label"] == label) & (exec_agg["inline"] == inline)]["std"].values[0]
    ax2.errorbar(x, y, yerr=yerr, fmt='none', capsize=5, color='black')

# Customize legend
handles, labels = ax2.get_legend_handles_labels()
custom_labels = [inline_labels[eval(l)] for l in labels]
ax2.legend(
    handles, custom_labels,
    title="Instrumentation Mode",
    fontsize=11,
    title_fontsize=15,
    handlelength=2.5,
    handleheight=1.5
)

# Set plot styling and axes
ax2.set_title("Execution Time", fontsize=20, color="black")
ax2.set_ylabel("Execution Time (secs)", fontsize=18, color="black")
ax2.set_xlabel("", color="black")
ax2.set_xticklabels(x_labels, rotation=45, ha="right", fontsize=16, color="black")
ax2.tick_params(axis='x', pad=5)
for spine in ax2.spines.values():
    spine.set_edgecolor('black')

plt.tight_layout()
plt.savefig("results/execution_time_comparison.png")
plt.show()
