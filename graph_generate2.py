import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv("results/experiment2_data.csv")
sns.set(style="whitegrid", font_scale=1.2)

# Define a more vibrant color palette
vibrant_palette = {
    'ccc': '#1f77b4',              # 진한 파랑
    'fastcc': '#ff7f0e',           # 진한 주황
    'preserve_allcc': '#2ca02c',   # 선명한 녹색
    'preserve_mostcc': '#d62728'   # 진한 빨강
}

# ===== BUILD TIME =====
build_stats = df.groupby(["bench", "call"]).agg(
    mean=("build_time", "mean"),
    std=("build_time", "std")
).reset_index()

# Save build time summary to CSV
build_stats.to_csv("results/exp2_build_time_stat.csv", index=False)


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

# Bar 위치 계산
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

# 스타일
ax.set_title("Experiment 2 - Build Time by Calling Convention", fontsize=14, color='black')
ax.set_ylabel("Build Time (s)", fontsize=12, color='black')
ax.set_xlabel("Benchmark", fontsize=12, color='black')
ax.set_xticklabels(bench_list, rotation=15)
ax.tick_params(axis='x', colors='black')
ax.tick_params(axis='y', colors='black')
for spine in ax.spines.values():
    spine.set_edgecolor('black')

# 📍 Legend: top-left
plt.legend(
    title="Calling Convention",
    loc='lower left',
    # bbox_to_anchor=(0, 1),
    bbox_to_anchor=(0, 0.02),   # 중앙에서 아래로 내림
    ncol=1,                        # 4개 항목 가로로 정렬
    fontsize=11,
    title_fontsize=12
)

plt.tight_layout()
plt.savefig("results/exp2_build_time_final.png")
plt.show()

# ===== EXEC TIME ===== (동일 방식 적용)
exec_stats = df.groupby(["bench", "call"]).agg(
    mean=("exec_time", "mean"),
    std=("exec_time", "std")
).reset_index()

# Save exec time summary to CSV
exec_stats.to_csv("results/exp2_exec_time_stat.csv", index=False)

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

for i, row in exec_stats.iterrows():
    bench_idx = list(bench_list).index(row["bench"])
    call_idx = list(call_list).index(row["call"])
    x = bench_idx - width / 2 + bar_width * call_idx + bar_width / 2
    y = row["mean"]
    yerr = row["std"]
    ax.errorbar(x, y, yerr=yerr, fmt='none', c='black', capsize=4)

ax.set_title("Experiment 2 - Execution Time by Calling Convention", fontsize=14, color='black')
ax.set_ylabel("Execution Time (s)", fontsize=12, color='black')
ax.set_xlabel("Benchmark", fontsize=12, color='black')
ax.set_xticklabels(bench_list, rotation=15)
ax.tick_params(axis='x', colors='black')
ax.tick_params(axis='y', colors='black')
for spine in ax.spines.values():
    spine.set_edgecolor('black')

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

