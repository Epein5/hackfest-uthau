from django.urls import path,include
from .views import *

urlpatterns = [
    path('team',team,name='team'),
    path('map',map, name='map'),
    path('first_page', first_page, name='first_page'),
    path('sign_in', sign_in, name='sign_in'),
    path('project',click_photo_enter, name='project' ),
    path('recognition',click_and_check,name='recognition'),
    path('service', service, name='service'),
]