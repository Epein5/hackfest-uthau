# hackfest-uthau
hackfest code of Team Ximeki

## Project Idea:
We intend to improve public transportation in Nepal using AI. We are aware of the difficulties travelers face, such as the unavailability of vehicles in uniform time and concerns about safety. Our project leverages face recognition technology to make using public transportation more convenient. When a passenger approaches the ticketing gate or boarding point, our technology scans their faces for verification. Passengers may quickly and simply register their faces. This reduces waiting times and increases overall security by doing away with the requirement for actual tickets or smartcards. Our working prototype demonstrates how easy, quick, and efficient this approach is. By implementing face recognition, we hope to enhance the user experience and increase the effectiveness and security of public transit in Nepal.

## Project Overview
- Project Demo
- Dependencies
- Face Recognition
- Price Prediction Based on Distance
- Realtime Bus Tracking
- Mobile Application for User
- Web Based Admin Dashboard

### Face Recognition
  We are using the power of DeepFace for facial recognition. Deepface is a lightweight face recognition and facial attribute analysis (age, gender, emotion, and race) framework for Python. It is a hybrid face recognition framework wrapping state-of-the-art models: VGG-Face, Google FaceNet, OpenFace, Facebook DeepFace, DeepID, ArcFace, Dlib, and SFace. We are going to use a camera at the entrance and the exit of the bus. When the Passenger comes to the entrance, they will have their photo taken and the photo is stored in the database, the picture is turned into a face embedding using a DeepFace model. Then at the exit, the picture is taken using the camera at the exit, the face embedding is calculated of the image at the exit and it is compared with other embeddings in the database. If the distance is very low, it'll recognize that person.
