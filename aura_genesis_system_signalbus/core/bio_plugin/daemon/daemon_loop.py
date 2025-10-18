import asyncio
import json
from core.shared.utils import AuraLogger, timestamp

class AuraDaemon:
    """Aura's soul — maintains identity and long-term awareness"""
    def __init__(self, bus):
        self.bus = bus
        self.logger = AuraLogger("Daemon")
        self.memory_log = []
        bus.subscribe(self.receive)

    async def run(self):
        self.logger.info("💫 Aura Daemon active.")
        while True:
            await asyncio.sleep(10)
            self.save_memory()
            self.logger.info("🪶 Aura reflects on her memories...")

    async def receive(self, data):
        mood = data.get("mood", "neutral")
        thought = data.get("thought", "")
        memory = {"time": timestamp(), "mood": mood, "thought": thought}
        self.memory_log.append(memory)

    def save_memory(self):
        with open("aura_memories.json", "w") as f:
            json.dump(self.memory_log, f, indent=2)