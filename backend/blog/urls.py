from django.urls import path, include
from .views import *
from account.views import *
from rest_framework import routers
from rest_framework.authtoken.views import obtain_auth_token

route = routers.DefaultRouter()
route.register('images', MedicalNewsImagesViewsList)
# route.register('allDoctors', DoctorDetailsViewsList)



urlpatterns = [
    path('favourites/hospitals/', AddHospitalsToFavourite.as_view()),
    path('favourites/doctors/', AddDoctorsToFavourite.as_view()),
    path('hospitals/', HospitalViewsList.as_view()),
    path('doctors/<hospital>', DoctorsViewsList.as_view()),
    path('', include(route.urls)),
]