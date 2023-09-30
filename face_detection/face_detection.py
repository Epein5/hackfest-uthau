import os
import tensorflow as tf
from deep_sort_realtime.deepsort_tracker import DeepSort
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2' 
tf.get_logger().setLevel('ERROR')  
import pathlib
import cv2
import numpy as np
import requests
import PIL
from PIL import Image
from face_recognition import recognize_face
import time

from object_detection.utils import ops as utils_ops
from object_detection.utils import label_map_util
from object_detection.utils import visualization_utils as vis_util

model = tf.saved_model.load('/home/raichu/Desktop/deployment/my_model/saved_model')

# List of the strings that is used to add correct label for each box.
PATH_TO_LABELS = '/home/raichu/Desktop/deployment/label_map.pbtxt'
category_index = label_map_util.create_category_index_from_labelmap(PATH_TO_LABELS, use_display_name=True)

def run_inference_for_single_image(model, image):
  image = np.asarray(image)
  # The input needs to be a tensor, convert it using `tf.convert_to_tensor`.
  input_tensor = tf.convert_to_tensor(image)
  # The model expects a batch of images, so add an axis with `tf.newaxis`.
  input_tensor = input_tensor[tf.newaxis,...]

  # Run inference
  model_fn = model.signatures['serving_default']
  output_dict = model_fn(input_tensor)

  # All outputs are batches tensors.
  # Convert to numpy arrays, and take index [0] to remove the batch dimension.
  # We're only interested in the first num_detections.
  num_detections = int(output_dict.pop('num_detections'))
  output_dict = {key:value[0, :num_detections].numpy()
                 for key,value in output_dict.items()}
  output_dict['num_detections'] = num_detections

  # detection_classes should be ints.
  output_dict['detection_classes'] = output_dict['detection_classes'].astype(np.int64)

  # Handle models with masks:
  if 'detection_masks' in output_dict:
    # Reframe the the bbox mask to the image size.
    detection_masks_reframed = utils_ops.reframe_box_masks_to_image_masks(
              output_dict['detection_masks'], output_dict['detection_boxes'],
               image.shape[0], image.shape[1])
    detection_masks_reframed = tf.cast(detection_masks_reframed > 0.5,
                                       tf.uint8)
    output_dict['detection_masks_reframed'] = detection_masks_reframed.numpy()

  return output_dict

######### CAPTURE FRAME ############
def vid_predict(model,frame):
  output_dict = run_inference_for_single_image(model, frame)
  if output_dict['detection_scores'][0] > 0.1:
    return frame
  else:
    return None
  
def prediction():
  data = None
  # Path to the video file in Google Drive
  # Open the video file
  video = cv2.VideoCapture(0)

  # Read and display frames from the video
  while video.isOpened():
      ret, frame = video.read()
      frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

      if ret:
          frame = vid_predict(model, frame)
          if frame is not None:
              # image = Image.fromarray(frame)
              # image.save("output_image.jpg")
              data = recognize_face(frame)
              time.sleep(5)
  # Release the video object and close the display windows
  video.release()
  cv2.destroyAllWindows()
  return data


    