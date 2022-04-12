from rest_framework.views import APIView
from django.views.generic.edit import UpdateView
from rest_framework.response import Response
from .serializers import *
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication 
from .models import *
from rest_framework import viewsets, mixins
from django.shortcuts import render, redirect
from django.contrib.auth.forms import UserCreationForm 
from .forms import CreateUserForm
from django.http import HttpResponse
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token
from django.shortcuts import get_object_or_404
from django.contrib.auth.decorators import login_required

from blog.models import Doctor, Hospital
from blog.serializers import HospitalSerializers, DoctorSerializers


# Create your views here.
class RegisterPatientUser(APIView):
    def post(self,request):
        serializers = PatientRegisterSerializer(data=request.data)
        if serializers.is_valid():
            serializers.save()
            return Response({'error': False}) 
        return Response({'error': True}) 
 

class RegisterDoctorUser(APIView):
    def post(self,request):
        serializers = DoctorRegisterSerializer(data=request.data)
        if serializers.is_valid():
            serializers.save()
            return Response({'error': False}) 
        return Response({'error': True}) 

# class RegisterHospitalUser(APIView):
    
#     def post(self,request):
#         serializers = CreateUserForm(data=request.data)
#         if serializers.is_valid():
#             serializers.save()
#             return render(request, 'accounts/register.html', context)
#         return Response({'error': True}) 


def registerPage(request):
    if request.user.is_authenticated:
        return redirect('home')
    else:    
        form = CreateUserForm()
        if request.method == "POST":
            form = CreateUserForm(request.POST)
            if form.is_valid():
                form.save() 
                username = form.cleaned_data.get('username')
                
                data = Hospital(hospital_name=username) 
                data.save()
                # username = form.cleaned_data.get('image')
                # username = form.cleaned_data.get('address')
                # username = form.cleaned_data.get('detail')
                messages.success(request, 'Account was created for ' + username) 
                return redirect('login')

        context = {'form': form}
        return render(request, 'accounts/register.html', context)

def loginPage(request):
    if request.user.is_authenticated:
        return redirect('home')
    else:        
        if request.method == 'POST':
            username=request.POST.get('username')
            password=request.POST.get('password')

            user = authenticate(request, username=username, password=password)
            if user is not None:    
                login(request, user)
                print("asdasd")
                return redirect('home')
            else:
                messages.info(request, 'Username OR Password is incorrect.')

        context = {}
        return render(request, 'accounts/login.html', context)

def updateUserProfile(request, pk):
    updateProfile = AllUser.objects.get(id=pk)
    


def logoutUser(request):
    logout(request)
    return redirect('login')

@login_required(login_url='login')
def home(request):
    return render(request, 'accounts/home.html') 


@login_required(login_url='login')
def addDoctors(request):

    if request.method == "POST" and request.FILES["img"]:
            
        name = request.POST["name"]
        img = request.FILES["img"]
        speciality = request.POST["speciality"]
        address = request.POST["address"]
        detail = request.POST["detail"]
        # return HttpResponse("<h1>",name,speciality, "</h1>")

    
        data = Doctor(hospital=request.user, doctor_name=name, doctor_image=img, speciality=speciality, address=address, doctor_detail=detail) 
        print('data: ', data)
        print('data name: ', data.hospital)
        data.save()
        
        # return HttpResponse("<h1> Doctors Saved !!!</h1>") 

    return render(request, 'accounts/addDoctor.html') 

# def setupProfile(request, *args, **kwargs):
def setupProfile(request):
    username = request.user
    if request.method == "POST" and request.FILES["img"]:
            
        # hospital = get_object_or_404(Hospital, hospital_name = username)
        hospital = Hospital.objects.get(hospital_name = username)

        hospital.delete()   

        hospital_fullname = request.POST["fname"]
        hospital_img = request.FILES["img"]
        email = request.POST["email"]
        phone = request.POST["phone"]
        address = request.POST["address"]
        detail = request.POST["detail"]

            
        data = Hospital(user=username, hospital_name=hospital_fullname, hospital_image=hospital_img, address=address, hospital_detail=detail, email=email, phone=phone) 
        data.save()

    return render(request, 'accounts/profile.html')     
        

