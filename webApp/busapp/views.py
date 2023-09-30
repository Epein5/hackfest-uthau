from django.shortcuts import render, HttpResponse
from django.http import JsonResponse
from django.contrib.auth.models import User
from django.contrib import messages
from django.shortcuts import redirect, render
from django.contrib.auth import authenticate,login
from Mask_detect import check_mask


# Create your views here.
def team(request):
    return render(request, 'team.html')

def map(request):
    return render(request, 'index1.html')

def first_page(request):
    return render(request, 'first_page.html')


def sign_in(request):
    if request.method == 'POST':
        Username = request.POST['Username']
        Password = request.POST['Password']

        our_user = authenticate(username = Username, password = Password)

        if our_user is not None:
            login(request, our_user)
            fname = our_user.first_name
            return redirect('first_page')
        else:
            messages.error(request, "Bad Credential")
            return redirect('first_page')


    return render(request, 'sign_in.html')

import os
from deepface import DeepFace
import cv2

def click_photo_enter(request):
    """
    Takes photo from camera using opencv after clicking enter key and save it under image.png 
    """
    cap = cv2.VideoCapture(0) # video capture source camera (Here webcam of laptop) 

    while(True):
        ret,frame = cap.read() # return a single frame in variable `frame`
        cv2.imshow('img1',frame) #display the captured image
        
        if check_mask(frame=frame):
              print("Please remove your mask and Try again")
              cap.release
              cv2.destroyAllWindows()
              return render(request, "sorry_mask.html")

        if cv2.waitKey(1) & 0xFF == ord('y'): #save on pressing 'y' 
            num = len(os.listdir('busapp/static/busapp/media/collected_data'))
            cv2.imwrite(f'busapp/static/busapp/media/collected_data/{num}.jpg',frame) #saves the image in images directory
            cv2.destroyAllWindows()
            break

    cap.release
    cv2.destroyAllWindows()

    return render(request, 'index.html')

from django.http import HttpResponse

def click_and_check(request):
    cap = cv2.VideoCapture(0) # video capture source camera (Here webcam of laptop)
    
    while True:
        ret, frame = cap.read() # return a single frame in the variable frame
        cv2.imshow('Frame', frame) # display the captured image
        
        if cv2.waitKey(1) & 0xFF == ord('y'): # save on pressing 'y'
            cv2.imwrite('test.jpg', frame)
            cv2.destroyAllWindows()
            break

    cap.release

    dirs = os.listdir('busapp/static/busapp/media/collected_data/')
    for i in ['busapp/static/busapp/media/collected_data/' + files for files in dirs]:
        print(i)
        result = DeepFace.verify('test.jpg', i, model_name="Facenet512")['verified']
        print(DeepFace.verify('test.jpg', i, model_name="Facenet512"))
        if result:
            print('Found')
            os.remove(i) # Removes the found image to save space
            response = HttpResponse("The User has been found and the Fare has been Deducted from the Wallet")
            response["X-User-Found"] = "true"
            return response

    print('Not Found')
    return render(request, 'index2.html')

def service(request):
    return render(request, 'services.html')