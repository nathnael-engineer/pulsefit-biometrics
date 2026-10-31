from fastapi import FastAPI, WebSocket, WebSocketDisconnect
import json

app = FastAPI(title="PulseFit Telemetry Streamer")

@app.websocket("/ws/telemetry")
async def telemetry_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        while True:
            data = await websocket.receive_text()
            await websocket.send_text(json.dumps({"status": "ACK"}))
    except WebSocketDisconnect:
        pass