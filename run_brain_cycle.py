import asyncio
from brain.aura_brain import AuraBrain
from apscheduler.schedulers.background import BackgroundScheduler

def schedule_aura_brain():
    scheduler = BackgroundScheduler()
    aura = AuraBrain()

    # Run every day at 3 AM
    scheduler.add_job(lambda: asyncio.run(aura.breathe()), 'cron', hour=3, minute=0)
    scheduler.start()
    print("💤 Aura Brain scheduled to reflect daily at 3:00 AM.")

if __name__ == "__main__":
    schedule_aura_brain()
    while True:
        pass
