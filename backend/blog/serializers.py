from rest_framework import serializers
from .models import *

#Image Slider
class MedicalNewsImagesSerializers(serializers.ModelSerializer):
    class Meta:
        model = MedicalNewsImageSlider
        fields = "__all__"

#List of Hospitals
class HospitalSerializers(serializers.ModelSerializer):
    class Meta:
        model = Hospital
        fields = "__all__"
        # depth = 1

#List of Doctors
class DoctorSerializers(serializers.ModelSerializer):
    hospital = serializers.ReadOnlyField(source='hospital.hospital')
    hospital_id = serializers.ReadOnlyField(source='hospital.id')
    # reports = serializers.SerializerMethodField()

    class Meta:
        model = Doctor
        fields = "__all__"
        
# class DoctorDetailsSerializers(serializers.ModelSerializer):
#     class Meta:
#         model = DoctorDetail
#         fields = "__all__"

class FavouriteHospitalSerializers(serializers.ModelSerializer):
    class Meta:
        model = FavouriteHospital
        # fields = "__all__"
        fields = ('id', 'favourite', 'hospital')
        depth = 1

class FavouriteDoctorSerializers(serializers.ModelSerializer):
    class Meta:
        model = FavouriteDoctor
        # fields = "__all__"
        fields = ('id', 'favourite', 'doctor')
        depth = 1
