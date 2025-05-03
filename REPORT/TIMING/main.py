import re
import glob
import pandas as pd
import matplotlib.pyplot as plt

# 1. Rechercher tous les fichiers .rpt dans le dossier courant
report_files = glob.glob("*.rpt")  # Modifie le chemin si nécessaire

# 2. Dictionnaire pour stocker les données de timing
timing_data = {}

# 3. Parsing de chaque fichier
for file in report_files:
    module_name = file.replace(".rpt", "")
    timing_data[module_name] = {}

    with open(file, 'r') as f:
        content = f.read()

        # Slack (peut être "inf" ou une valeur numérique)
        match_slack = re.search(r"Slack:\s+([^\s]+)", content)
        if match_slack:
            slack_value = match_slack.group(1)
            try:
                slack = float(slack_value)
            except ValueError:
                slack = None  # ex: si 'inf'
            timing_data[module_name]["Slack"] = slack
        else:
            print(f"[⚠️] Slack non trouvé dans {file}")
            timing_data[module_name]["Slack"] = None

        # Data Path Delay
        match_delay = re.search(r"Data Path Delay:\s+([\d.]+)ns", content)
        if match_delay:
            timing_data[module_name]["Max path delay"] = float(match_delay.group(1))
        else:
            print(f"[⚠️] Data Path Delay non trouvé dans {file}")
            timing_data[module_name]["Max path delay"] = None

        # Worst Negative Slack (si présent)
        match_wns = re.search(r"Worst Negative Slack.*?:\s*([-\d.]+)", content)
        if match_wns:
            timing_data[module_name]["Worst negative slack"] = float(match_wns.group(1))
        else:
            timing_data[module_name]["Worst negative slack"] = None

# 4. Créer un DataFrame
df_timing = pd.DataFrame.from_dict(timing_data, orient='index')

# 5. Sauvegarde CSV
df_timing.to_csv("timing_report.csv")
print("✅ CSV généré : timing_report.csv")

# 6. Tracer un graphique
if "Max path delay" in df_timing.columns:
    df_sorted = df_timing.sort_values(by="Max path delay", ascending=False)

    ax = df_sorted["Max path delay"].plot(
        kind='bar',
        figsize=(12, 8),
        colormap='viridis',
        title="Comparaison des délais de propagation maximum par module"
    )
    ax.set_xlabel("Module")
    ax.set_ylabel("Délai de propagation (ns)")
    ax.grid(axis='y')
    plt.tight_layout()
    plt.savefig("timing_comparison.png")
    plt.show()
else:
    print("❌ La catégorie 'Max path delay' est manquante.")

