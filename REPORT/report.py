import re
import glob
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# 1. Quels fichiers parser
report_files = glob.glob("*.rpt")  # à adapter selon ton chemin des fichiers

# 2. Catégories que l'on veut extraire
categories = ["Slice LUTs", "Slice Registers", "Block RAM Tile", "DSPs", "Bonded IOB"]

# 3. Stockage final
data = {}

# 4. Parsing de chaque fichier
for file in report_files:
    module_name = file.replace("_utilization_synth.rpt", "").replace(".rpt", "")
    data[module_name] = {}
    with open(file, 'r') as f:
        content = f.read()
        for cat in categories:
            # Regex pour matcher la ligne avec la catégorie
            match = re.search(rf"\|\s*{re.escape(cat)}\s*\|\s*(\d+)", content)
            if match:
                used_value = int(match.group(1))
                data[module_name][cat] = used_value
            else:
                data[module_name][cat] = 0  # si pas trouvé, on met 0

# 5. Création d'un DataFrame avec la somme brute des sous-modules
df = pd.DataFrame.from_dict(data, orient='index')
df = df[categories]  # pour l'ordre

# 6. Somme brute des sous-modules par catégorie
summed_df = df.sum(axis=0)  # Somme des valeurs par catégorie

# 7. Sauvegarde en CSV pour analyse
summed_df.to_csv("summed_utilization.csv")
print("CSV généré : summed_utilization.csv")

# 8. Graphique empilé comparatif (Chronoscore vs autres modules) avec somme brute

# Ajouter le module Chronoscore à un DataFrame pour le comparatif
chronoscore_data = df.loc['chronoscore']

# Calculer la somme des barres sauf "chronoscore" pour chaque catégorie
other_modules_data = df.drop('chronoscore').sum(axis=0)

# Ajouter la somme des sous-modules comme une nouvelle ligne dans le DataFrame
df.loc['Somme des sous-modules'] = other_modules_data

# Créer un DataFrame pour le graphique combiné
comparative_df = df.copy()
comparative_df = comparative_df.sort_values(by='Slice LUTs', ascending=False)  # Pour avoir une comparaison optimale

# Graphique empilé
ax_combined = comparative_df.plot(kind='bar', stacked=True, figsize=(12, 8), colormap='tab20')

# Ajouter Chronoscore sur l'empilement pour la comparaison
ax_combined.set_title("Comparaison de l'utilisation des ressources entre Chronoscore et les autres modules", fontsize=16)
ax_combined.set_xlabel("Modules")
ax_combined.set_ylabel("Nombre de ressources utilisées")
ax_combined.grid(axis='y')

# Légende ajustée
ax_combined.legend(title="Ressources", bbox_to_anchor=(1.05, 1), loc='upper left', fontsize=10)

plt.tight_layout()
plt.savefig("summed_combined_utilization_comparison.png")
plt.show()

