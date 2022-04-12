from django.urls import path, include
from .views import *


urlpatterns = [
    path('appointments/', AppointmentViewsList.as_view()),
]