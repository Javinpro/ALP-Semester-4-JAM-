import asyncio
import base64
import json
from channels.generic.websocket import AsyncWebsocketConsumer
import cv2


class VideoFrames(AsyncWebsocketConsumer):
    async def connect(self):
        # WebSocket connection is established, accept the connection
        await self.accept()

    async def disconnect(self, reason):
        """
        Called when the WebSocket connection is closed.
        
        Args:
            reason (str): The reason for the disconnection.
        """
        print("Disconnect from video channel")
        pass

    async def receive(self, text_data):
        """
        Receives data from the WebSocket connection.

        Parameters:
            text_data (str): The data received from the WebSocket connection.

        Returns:
            None
        """
        # Receive data from the WebSocket connection
        videoSrc_json = json.loads(text_data)
        videoSrc = videoSrc_json.get('videoSrc')

        # Initiate video playback on the server and send frames to the client
        if videoSrc is not None:
            await self.send_video_frames(videoSrc)
        else:
            print("Invalid data format received.")

    async def send_video_frames(self, videoSrc):
        """
        Sends video frames to the WebSocket client.

        Parameters:
        - videoSrc (str): The path or URL of the video source.

        Returns:
        None
        """
        # Simulate sending video frames to the client
        cap = cv2.VideoCapture(videoSrc)

        while cap.isOpened():
            ret, frame = cap.read()
            if not ret:
                break
            
            # process_frame(frame)
            
            # Encode the frame in base64 before sending
            _, buffer = cv2.imencode('.jpg', frame)
            frame_bytes = buffer.tobytes()
            frame_base64 = base64.b64encode(frame_bytes).decode('utf-8')

            # Send the frame as JSON to the WebSocket client
            await self.send(text_data=json.dumps({
                'frame': frame_base64,
            }))
            
            await asyncio.sleep(0.005)

        cap.release()  # Release the video capture object when done
