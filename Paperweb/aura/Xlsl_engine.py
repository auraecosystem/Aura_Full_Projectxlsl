import pandas as pd
from io import StringIO

def process_xlsl(data):
    """Simulate spreadsheet-like computation using Pandas"""
    try:
        df = pd.DataFrame(data.get("values", []))
        result = df.describe().to_dict()
        return {"status": "ok", "summary": result}
    except Exception as e:
        return {"status": "error", "detail": str(e)}
