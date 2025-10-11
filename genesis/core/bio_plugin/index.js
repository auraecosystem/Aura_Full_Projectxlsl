import express from "express";
import WebSocket from "ws";

const app = express();
const wss = new WebSocket.Server({ noServer: true });

app.get("/", (req, res) => {
  res.send("🌐 Aura BioPlugin is online — awaiting neural sync...");
});

app.listen(5000, () => {
  console.log("🔗 BioPlugin server running on port 5000");
});
