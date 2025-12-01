import pandas as pd
import json

XLSL_FILE = "Aura_Full_Project.xlsx"
EXTENSIONS = ["xlmath", "xlcode", "xldata", "xlflow", "xlviz", "xlweb", "xlaudio", "xlai"]

xls = pd.ExcelFile(XLSL_FILE)
paperweb_json = {"extensions": {}}

for ext in EXTENSIONS:
    ext_sheets = [s for s in xls.sheet_names if ext in s.lower()]
    paperweb_json["extensions"][ext] = {}
    for sheet in ext_sheets:
        df = pd.read_excel(xls, sheet)
        functions = df.iloc[:,0].dropna().astype(str).tolist() if not df.empty else []
        paperweb_json["extensions"][ext][sheet] = functions

with open("paperweb_live.json", "w", encoding="utf-8") as f:
    json.dump(paperweb_json, f, indent=2)

print("✅ JSON structure created: paperweb_live.json")
