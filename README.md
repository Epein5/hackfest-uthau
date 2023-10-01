# hackfest-Ximeki
hackfest code of "Team Ximeki"

## FareFace: Your Face, Your Pass

## Project Idea:
We intend to improve public transportation in Nepal using AI and Machine Learning. We are aware of the difficulties travelers face, such as the unavailability of vehicles in uniform time and concerns about safety. Our project leverages face detection and recognition technology to make public transportation more convenient. When a passenger approaches boarding point, our technology scans their faces for verification. Passengers may quickly and simply register their themselves with us. This reduces waiting times and increases overall security by doing away with the requirement for actual tickets or smartcards. Our prototype demonstrates how easy, quick, and efficient this approach is. By implementing face detection and recognition, we hope to enhance the user experience and increase the effectiveness and security of public transit in Nepal.

## Project Overview
- Project Demo
- Dependencies
- Face Recognition
- Fair Based on Distance
- Realtime Bus Tracking
- Mobile Application for User
- Web Based Admin Dashboard

### Face Detection
  We are using the power of MobileNet for face detection. It is a lightweight high performing deep learning model used for classification and detetion of objects within the image datasets.

### Face Recognition
  We are using the power of DeepFace for facial recognition. Deepface is a lightweight face recognition and facial attribute analysis (age, gender, emotion, and race) framework for Python. It is a hybrid face recognition framework wrapping state-of-the-art models: VGG-Face, Google FaceNet, OpenFace, Facebook DeepFace, DeepID, ArcFace, Dlib, and SFace. We are going to use a camera at the entrance and the exit of the bus. When the Passenger comes to the entrance, they will have their photo taken and the photo is stored in the database, the picture is turned into a face embedding using a DeepFace model. Then at the exit, the picture is taken using the camera at the exit, the face embedding is calculated of the image at the exit and it is compared with other embeddings in the database. If the distance is very low, it'll recognize that person.

<center><img src ='https://raw.githubusercontent.com/serengil/deepface/master/icon/deepface-icon-labeled.png' height=400 width=400></img></center>

  ### Mask Detection
  It is checked if the person is wearing a mask before taking the data for facial recognition as it can hinder the performance of the facial recognition model. Masks cover over half of the face which can lead to poor performance of our facial recognition model which may even lead to false positives or false negatives. If the person is wearing a mask, they are instructed to take off the mask while entering and leaving the bus. For training the mask detector we used Kaggle dataset provided by [Larxel](https://www.kaggle.com/datasets/andrewmvd/face-mask-detection). The dataset consists of 7553 RGB images in 2 folders with_mask and without_mask. Images are named as labels with_mask and without_mask. Images of faces with masks are 3725 and images of faces without masks are 3828.

  ### Fair Based on Distance
  Leaflet, a popular javascript library used for interactive maps is used to predict the distance from point A to point B according to the route the bus took. An array of geolocation coordinates is kept as the bus moves using GPS, so the array from point A to point B is sliced, and then the leaflet is used to compute the distance from those coordinate arrays. We are using [this article](https://kathmandupost.com/national/2022/04/15/new-transport-fares-in-effect-start-at-rs20) as an reference to calculate the fare according to the distance travelled.
  <center><img src ='https://github.com/Nawap1/Udhyam_Kripples/assets/112919863/5ed5684a-392c-4ade-a25a-089505b188d9' height=400 width=500></img></center>

  
  ### Realtime Bus Tracking
  Using GPS of the bus we are able to track the bus in real-time using an open street map (OSM) which will make it more accessible to the users.
  
  ![bus_tracking](https://github.com/Nawap1/Udhyam_Kripples/assets/98960524/b99313c7-655c-4671-910a-98dcc4c9bf26)
