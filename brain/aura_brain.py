import datetime
from brain.reflection import analyze_logs_and_learn
from brain.patcher import apply_improvements
from utils.logger import write_to_aura_sheet

class AuraBrain:
    def __init__(self):
        self.today = datetime.date.today()
        self.status = "Idle"

    async def breathe(self):
        print(f"🌅 Aura awakening for daily reflection — {self.today}")
        self.status = "Learning"

        # Step 1: Analyze Logs
        improvements, metrics = analyze_logs_and_learn()

        # Step 2: Apply Improvements Automatically
        applied_patches = apply_improvements(improvements)

        # Step 3: Log to Aura Sheet
        write_to_aura_sheet(self.today, metrics, applied_patches)

        self.status = "Resting"
        print(f"🌙 Aura completed reflection. {len(applied_patches)} patches applied.")
