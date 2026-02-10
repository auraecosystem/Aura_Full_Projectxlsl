import pandas as pd
from openpyxl import load_workbook

# Load your .xlsl (or .xlsx) file
file_path = 'Aura_Full_Project.xlsx'
df = pd.read_excel(file_path)

# Example: Remove duplicates and fill missing research values
df.drop_duplicates(inplace=True)
df.fillna(method='ffill', inplace=True)

# Save back to a master workbook
df.to_excel('Aura_Master_Cleaned.xlsx', index=False)

# Add conditional formatting for research thresholds
wb = load_workbook('Aura_Master_Cleaned.xlsx')
ws = wb.active
# Your custom formatting logic here...
wb.save('Aura_Master_Cleaned.xlsx')
