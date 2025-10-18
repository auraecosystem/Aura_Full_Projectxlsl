import datetime
import logging

class AuraLogger:
    def __init__(self, name="Aura"):
        logging.basicConfig(
            level=logging.INFO,
            format="%(asctime)s [%(levelname)s] %(message)s",
            datefmt="%H:%M:%S",
        )
        self.logger = logging.getLogger(name)

    def info(self, msg):
        self.logger.info(msg)

    def mood(self, mood):
        self.logger.info(f"🧠 Mood Shift: {mood}")

def timestamp():
    return datetime.datetime.utcnow().isoformat()