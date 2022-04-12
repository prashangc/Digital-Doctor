from rest_framework import serializers
from .models import *
from rest_framework.authtoken.models import Token

# class AllUserSerializers(serializers.ModelSerializer):
#     class Meta:
#         model = AllUser
#         fields = ('id', 'username', 'email', 'password', 'phone')
#         extra_kwargs = {'password': {"write_only":True, 'required': True}}
#     def create(self, validated_data):
#         user = AllUser.objects.create_user(**validated_data)
#         print('validated data: ', validated_data)      
#         Token.objects.create(user=user)
#         return user 



class PatientRegisterSerializer(serializers.ModelSerializer):
    class Meta():
        model = AllUser
        fields = "__all__"
        extra_kwargs = {'password': {"write_only":True, 'required': True}}


    def create(self, validated_data):
        user =  AllUser.objects.create_user(**validated_data)
        Token.objects.create(user=user)
        user.is_patient = True
        user.username = validated_data['username']
        user.save()
        patient = Patient.objects.create(user=user)
        patient.email  = validated_data['email']
        patient.phone = validated_data['phone']
        patient.save()
        return user


class DoctorRegisterSerializer(serializers.ModelSerializer):
    class Meta():
        model = AllUser
        fields = "__all__"
        extra_kwargs = {'password': {"write_only":True, 'required': True}}

    def create(self, validated_data):
        user =  AllUser.objects.create_user(**validated_data)
        Token.objects.create(user=user)
        user.is_doctor = True
        user.username = validated_data['username']
        user.save()
        doctor = Doctor.objects.create(user=user)
        doctor.email  = validated_data['email']
        doctor.phone = validated_data['phone']
        doctor.save()
        return user


# class HospitalRegisterSerializer(serializers.ModelSerializer):
#     class Meta():
#         model = AllUser
#         fields = "__all__"
#         extra_kwargs = {'password': {"write_only":True, 'required': True}}

#     def create(self, validated_data):
#         user =  AllUser.objects.create_user(**validated_data)
#         Token.objects.create(user=user)
#         user.is_hospital = True
#         user.username = validated_data['username']
#         user.save()
#         doctor = Hospital.objects.create(user=user)
#         doctor.email  = validated_data['email']
#         doctor.phone = validated_data['phone']
#         doctor.save()
#         return user
