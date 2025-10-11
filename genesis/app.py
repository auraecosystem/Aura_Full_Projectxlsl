import asyncio
from core.shared.message_bus import MessageBus
from core.neuro.neural_core import NeuroCore
from core.daemon.daemon_loop import AuraDaemon
from core.shared.utils import AuraLogger
from core.shared.ws_bridge import WSBridge

logger = AuraLogger("Aura")

async def main():
    logger.info("🌌 Initializing Aura Genesis System...")

    bus = MessageBus()

    neuro = NeuroCore(bus)
    daemon = AuraDaemon(bus)
    ws_bridge = WSBridge(bus)

    await asyncio.gather(
        neuro.run(),
        daemon.run(),
        ws_bridge.start()
    )

if __name__ == "__main__":
    asyncio.run(main())
