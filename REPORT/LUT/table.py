import re
import glob
import pandas as pd
import matplotlib.pyplot as plt

# 1. Rechercher tous les fichiers .rpt dans le dossier courant
report_files = glob.glob("*.rpt")  # adapte le chemin si besoin

# 2. Catégories à extraire
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
            match = re.search(rf"\|\s*{re.escape(cat)}\s*\|\s*(\d+)\s*\|", content)
            if match:
                data[module_name][cat] = int(match.group(1))
            else:
                print(f"[⚠️] Catégorie non trouvée : '{cat}' dans {file}")
                data[module_name][cat] = 0

# 5. Création du DataFrame
df = pd.DataFrame.from_dict(data, orient='index')
df = df[categories]

# 6. Ajout de la ligne "Somme des sous-modules"
if "chronoscore" in df.index:
    other_modules_data = df.drop("chronoscore").sum(axis=0)
    df.loc["Somme des sous-modules"] = other_modules_data
else:
    print("❌ Module 'chronoscore' non trouvé")

# 7. Génération de l'image du tableau
fig, ax = plt.subplots(figsize=(10, 0.6 * len(df)))
ax.axis('off')
table = ax.table(cellText=df.values,
                 colLabels=df.columns,
                 rowLabels=df.index,
                 loc='center',
                 cellLoc='center')

table.scale(1, 1.5)
table.auto_set_font_size(False)
table.set_fontsize(10)

plt.tight_layout()
plt.savefig("utilization_table.png")
print("✅ Image du tableau générée : utilization_table.png")

