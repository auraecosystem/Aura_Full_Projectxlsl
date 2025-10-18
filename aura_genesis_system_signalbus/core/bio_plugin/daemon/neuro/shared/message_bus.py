import asyncio
from collections import defaultdict

class MessageBus:
    """Async pub/sub message bus with channels."""
    def __init__(self):
        self.subscribers = defaultdict(list)

    def subscribe(self, channel, callback):
        """Subscribe a callback to a channel"""
        self.subscribers[channel].append(callback)

    async def publish(self, channel, data):
        """Publish data to a channel asynchronously"""
        if channel in self.subscribers:
            await asyncio.gather(*(cb(data) for cb in self.subscribers[channel]))