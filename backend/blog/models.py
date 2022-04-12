from django.db import models
from account.models import AllUser 

# Create your models here.

class MedicalNewsImageSlider(models.Model):
    pictures = models.ImageField(upload_to="medical_news",blank=True)

class Hospital(models.Model):
    user = models.ForeignKey(AllUser, on_delete=models.CASCADE, blank=True, null=True)
    hospital_name = models.CharField(max_length=100)     
    hospital_image = models.ImageField(upload_to="hospitals", blank=True)
    address = models.CharField(max_length=100,blank=True, null=True) 
    hospital_detail = models.TextField(blank=True, null=True)    
    email = models.CharField(max_length=100, blank=True, null=True)
    phone = models.CharField(max_length=100, blank=True, null=True) 
    def __str__(self):
        return f"Hospital = {self.hospital_name} || User = {self.user}" 

class Doctor(models.Model):
    hospital = models.ForeignKey(AllUser,on_delete=models.CASCADE, related_name='alluser')
    doctor_name = models.CharField(max_length=100)     
    doctor_image = models.ImageField(upload_to="doctors", blank=True)
    speciality = models.CharField(max_length=100,blank=True, null=True) 
    address = models.CharField(max_length=100,blank=True, null=True) 
    doctor_detail = models.TextField(blank=True, null=True)     
    
    def __str__(self):
        return f"Doctor = {self.doctor_name} || Hospital = {self.hospital}" 

class FavouriteHospital(models.Model):
    user = models.ForeignKey(AllUser, on_delete=models.CASCADE)
    hospital = models.ForeignKey(Hospital,on_delete=models.CASCADE)
    favourite = models.BooleanField(default=False)

    def __str__(self):
        return f"Hospital = {self.hospital.hospital_name} || User = {self.user.username} || Favourite = {self.favourite}"

class FavouriteDoctor(models.Model):
    user = models.ForeignKey(AllUser, on_delete=models.CASCADE)
    doctor = models.ForeignKey(Doctor,on_delete=models.CASCADE)
    favourite = models.BooleanField(default=False)

    def __str__(self):
        return f"Doctor = {self.doctor.doctor_name} || User = {self.user.username} || Favourite = {self.favourite}"

