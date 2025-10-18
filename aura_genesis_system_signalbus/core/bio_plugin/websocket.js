import WebSocket, { WebSocketServer } from 'ws';

const wss = new WebSocketServer({ port: 8080 });
console.log("🌐 Aura BioPlugin WS server running on port 8080");

wss.on('connection', ws => {
  console.log("🌀 BioPlugin client connected");

  // Example: broadcast mood changes from Aura (stub data)
  setInterval(() => {
    const moodSignal = {
      mood: ["curious","focused","calm","energetic","reflective"][Math.floor(Math.random()*5)],
      timestamp: new Date().toISOString()
    };
    ws.send(JSON.stringify(moodSignal));
  }, 3000);
});