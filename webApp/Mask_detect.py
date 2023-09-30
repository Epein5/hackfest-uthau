import os
from deepface import DeepFace
import cv2
from keras.applications.mobilenet_v2 import preprocess_input
from keras.preprocessing.image import img_to_array
from keras.models import load_model
import numpy as np
import cv2

def detect_and_predict_mask(frame, face_net, mask_net):
    """
    Takes an image, does all the preprocessing and returns the prediction of the facemask model
    """
    (height, width) = frame.shape[:2]
    blob = cv2.dnn.blobFromImage(frame, 1.0, (300, 300),
        (104.0, 177.0, 123.0))

    # pass the blob through the network and obtain the face detections
    face_net.setInput(blob)
    detections = face_net.forward()

    faces = []
    locs = []
    preds = []

    # loop over the detections
    for i in range(0, detections.shape[2]):
        # extract the confidence associated with the detection
        confidence = detections[0, 0, i, 2]

        # greater than the minimum confidence
        if confidence > 0.5:
            # compute the (x, y)-coordinates of the bounding box for
            box = detections[0, 0, i, 3:7] * np.array([width, height, width, height])
            (start_x, start_y, end_x, end_y) = box.astype("int")

            # ensure the bounding boxes fall within the dimensions of frame
            (start_x, start_y) = (max(0, start_x), max(0, start_y))
            (end_x, end_y) = (min(width - 1, end_x), min(height - 1, end_y))

            # extract the face ROI
            face = frame[start_y:end_y, start_x:end_x]
            face = cv2.cvtColor(face, cv2.COLOR_BGR2RGB)
            face = cv2.resize(face, (224, 224))
            face = img_to_array(face)
            face = preprocess_input(face)

            # add the face and bounding boxes to their respective
            faces.append(face)
            locs.append((start_x, start_y, end_x, end_y))

    if len(faces) > 0:
        # for faster inference, we'll make batch predictions on *all*
        faces = np.array(faces, dtype="float32")
        preds = mask_net.predict(faces, batch_size=32)

    return preds


def check_mask(frame):
    """
    Returns True if there is a mask in the image and False if there isn't
    """
    prototext_path = 'face_detector/deploy.prototxt'
    detector_weights_path = './face_detector/res10_300x300_ssd_iter_140000.caffemodel'
    detector = cv2.dnn.readNet(prototext_path, detector_weights_path)
    mask_net = load_model('./face_detector/mask_detector.model')
    pred = detect_and_predict_mask(frame, detector, mask_net)
    (mask, without_mask) = pred[0]
    label = True if mask > without_mask else False
    return label  # True == Mask, False == No Mask
