import os
from deepface import DeepFace
from Mask_detect import check_mask

def recognize_face(frame):
    if check_mask(frame=frame):
        return "Mask Detected, Please remove your mask"
    
    else:

        dirs = os.listdir('images/')
        for i in ['images/' + files for files in dirs]:
            result = DeepFace.verify(frame, i, model_name="Facenet512")['verified']

            if result == True:
                return "Your face has been recognized"
            else:
                return "Sorry, Your face has not been recognized"
                
            