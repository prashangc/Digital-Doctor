from django.urls import path, include
from .views import *
from . import views  
from blog.views import *  
from rest_framework.authtoken.views import obtain_auth_token



urlpatterns = [
    path('login/patient/', obtain_auth_token),
    path('register/patient/', RegisterPatientUser.as_view()),
    path('login/doctor/', obtain_auth_token),
    path('register/doctor/', RegisterDoctorUser.as_view()),  
    path('home/ ', views.home, name='home'),
    path('login/hospital/', views.loginPage, name='login'),
    path('logout/hospital/', views.logoutUser, name='logout'),
    path('register/hospital/', views.registerPage, name='register'),    
    path('hospital/profile/', views.setupProfile, name='profile'),
    # path('hospital/profile/', UpdateHospital.as_view(), name='profile'),
    path('hospital/addDoctors/', views.addDoctors, name='addDoctors'),  
    # path('hospital/updateProfile/int:pk', views.HospitalUpdateView.as_view(), name='hospitalUpdate'),  

]