from rest_framework.views import APIView
from rest_framework.response import Response

from account.models import HospitalUser
from .serializers import *
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication 
from .models import Hospital, FavouriteDoctor, FavouriteHospital, Doctor    

from rest_framework import viewsets, mixins

class MedicalNewsImagesViewsList(viewsets.ModelViewSet):    
    queryset = MedicalNewsImageSlider.objects.all() 
    serializer_class = MedicalNewsImagesSerializers    


class DoctorsViewsList(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]    
    queryset = Doctor.objects.all() 
    serializer_class = DoctorSerializers
    
    def get(self,request, hospital):
        query = Doctor.objects.filter(hospital=hospital)
        serializer = DoctorSerializers(query,many=True, context={'request': request})
        data = []
        for doctor in serializer.data:
            liked = FavouriteDoctor.objects.filter(doctor=doctor['id']).filter(favourite=True).count() # to count the total number of likes
            favourites = FavouriteDoctor.objects.filter(doctor=doctor['id']).filter(user=request.user.id).first()
            if favourites:
                doctor['favourite'] = favourites.favourite
            else:
                doctor['favourite'] = False
            doctor['totalFavourite']=liked # to display the total number of likes
            # hospital['doctors']=doctor                
            data.append(doctor) 
        return Response(serializer.data)

class HospitalViewsList(APIView):    
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]
    queryset = Hospital.objects.all() 
    serializer_class = HospitalSerializers
    def get(self,request):
        query = Hospital.objects.all() 
        serializer = HospitalSerializers(query,many=True, context={'request': request})
        data = []
        print(serializer.data)

        for hospital in serializer.data:
            # doctor = Doctor.objects.filter(hospital=hospital['id'])
            liked = FavouriteHospital.objects.filter(hospital=hospital['id']).filter(favourite=True).count() # to count the total number of likes
            favourites = FavouriteHospital.objects.filter(hospital=hospital['id']).filter(user=request.user.id).first()
            totalDoctor = Doctor.objects.filter(hospital=hospital['id']).count()
            print("totalDoctor: ", totalDoctor)
            print("hospitalid: ", hospital['id'])
            if favourites:
                hospital['favourite'] = favourites.favourite
            else:
                hospital['favourite'] = False
            hospital['totalFavourite']=liked # to display the total number of likes
            # hospital['doctors']=doctor
            hospital['totalDoctors']=totalDoctor                
            data.append(hospital) 
        return Response(serializer.data)

    # def get(self,request):
    #     query = HospitalUser.objects.all() 
    #     serializer = HospitalSerializers(query,many=True, context={'request': request})    

class AddDoctorsToFavourite(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]
    def post(self,request):
        try:
            data=request.data  
            c_user = request.user
            doctor_id = data['id']
            doctor_obj = Doctor.objects.get(id=doctor_id)
            fav_obj = FavouriteDoctor.objects.filter(doctor=doctor_obj).filter(user=c_user).first()
            if fav_obj:
                old_fav = fav_obj.favourite
                fav_obj.favourite = not old_fav
                fav_obj.save()
            else:
                FavouriteDoctor.objects.create(
                    doctor = doctor_obj,
                    user = c_user,
                    favourite = True    
                )     
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}  
        return Response(response_msg) 


class AddHospitalsToFavourite(APIView):
    # queryset = Favourite.objects.all() 
    # serializer_class = FavouriteSerializers
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]
    def post(self,request):
        try:
            # query = Favourite.objects.all() 
            # serializer = FavouriteSerializers(query,many=True)
            data=request.data  
            # data = request.data
            # print(data)
            c_user = request.user
            hospital_id = data['id']
            hospital_obj = Hospital.objects.get(id=hospital_id)
            fav_obj = FavouriteHospital.objects.filter(hospital=hospital_obj).filter(user=c_user).first()
            if fav_obj:
                old_fav = fav_obj.favourite
                fav_obj.favourite = not old_fav
                fav_obj.save()
            else:
                FavouriteHospital.objects.create(
                    hospital = hospital_obj,
                    user = c_user,
                    favourite = True    
                )     
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}  
        return Response(response_msg) 
    
