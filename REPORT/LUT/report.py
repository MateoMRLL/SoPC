import re
import glob
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# 1. Rechercher tous les fichiers .rpt dans le dossier courant
report_files = glob.glob("*.rpt")  # adapte ce chemin si nécessaire

# 2. Catégories à extraire exactement comme dans les rapports Vivado
categories = ["Slice LUTs", "Slice Registers", "Bonded IOB"]

# 3. Dictionnaire pour stocker les données
data = {}

# 4. Parsing de chaque fichier
for file in report_files:
    module_name = file.replace("_utilization_synth.rpt", "").replace(".rpt", "")
    data[module_name] = {}
    with open(file, 'r') as f:
        content = f.read()
        for cat in categories:
            # Match la valeur numérique dans la 1ère colonne après le nom de la catégorie
            match = re.search(rf"\|\s*{re.escape(cat)}\s*\|\s*(\d+)\s*\|", content)
            if match:
                used_value = int(match.group(1))
                data[module_name][cat] = used_value
            else:
                print(f"[⚠️] Catégorie non trouvée : '{cat}' dans {file}")
                data[module_name][cat] = 0  # Valeur par défaut si introuvable

# 5. Créer un DataFrame à partir du dictionnaire
df = pd.DataFrame.from_dict(data, orient='index')
df = df[categories]  # ordre explicite des colonnes

# 6. Somme globale des catégories
summed_df = df.sum(axis=0)

# 7. Sauvegarde en CSV pour analyse ultérieure
summed_df.to_csv("summed_utilization.csv")
print("✅ CSV généré : summed_utilization.csv")

# 8. Ajout de la ligne "Somme des sous-modules"
if "chronoscore" in df.index:
    chronoscore_data = df.loc["chronoscore"]
    other_modules_data = df.drop("chronoscore").sum(axis=0)
    df.loc["Somme des sous-modules"] = other_modules_data
else:
    print("❌ Module 'chronoscore' non trouvé dans les fichiers .rpt")

# 9. Graphique empilé comparatif
comparative_df = df.copy()
comparative_df = comparative_df.sort_values(by='Slice LUTs', ascending=False)

# Tracé du graphique
ax_combined = comparative_df.plot(
    kind='bar',
    stacked=True,
    figsize=(12, 8),
    colormap='tab20'
)

ax_combined.set_title("Comparaison de l'utilisation des ressources entre chronoscore et les autres modules", fontsize=16)
ax_combined.set_xlabel("Modules")
ax_combined.set_ylabel("Nombre de ressources utilisées")
ax_combined.grid(axis='y')
ax_combined.legend(title="Ressources", bbox_to_anchor=(1.05, 1), loc='upper left', fontsize=10)

plt.tight_layout()
plt.savefig("summed_combined_utilization_comparison.png")
plt.show()

