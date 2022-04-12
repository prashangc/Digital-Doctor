from django.db import models
from django.contrib.auth.models import AbstractUser
import datetime
GENDER_CHOICES = (
    ("MALE", "Male"),
    ("FEMALE", "Female"),
)

BLOODGROUP_CHOICES = (
    ("A+", "A+"),
    ("A-", "A-"),
    ("B+", "B+"),
    ("B+", "B-"),
    ("AB+", "AB+"),
    ("AB-", "AB-"),
    ("O+", "O+"),
    ("O-", "O-"),
)

class AllUser(AbstractUser):
    is_patient = models.BooleanField(default=False)
    is_doctor = models.BooleanField(default=False) 
    is_hospital = models.BooleanField(default=False)
    username = models.CharField(max_length=100, unique=True) 
    phone = models.CharField(max_length=100)
    fullname = models.CharField(max_length=100, blank=True) 
    bloodGroup = models.CharField(max_length=10,choices=BLOODGROUP_CHOICES,default="A+")
    gender = models.CharField(max_length=10,choices=GENDER_CHOICES,default="Male")
    date_of_birth = models.DateField(("Date"), default=datetime.date.today)

    
class Patient(models.Model):
    user = models.OneToOneField(AllUser, on_delete=models.CASCADE, primary_key=True, unique=True)    
    email = models.EmailField(max_length=100, unique=True)
    username = models.CharField(max_length=100, unique=True) 
    phone = models.CharField(max_length=100)
    fullname = models.CharField(max_length=100, blank=True) 
    bloodGroup = models.CharField(max_length=10,choices=BLOODGROUP_CHOICES,default="A+")
    gender = models.CharField(max_length=10,choices=GENDER_CHOICES,default="Male")
    date_of_birth = models.DateField(("Date"), default=datetime.date.today)

    USERNAME_FIELD = ['email', 'username']
    # first_name = models.CharField(max_length=100)
    # last_name = models.CharField(max_length=100)
    # phone = models.CharField(max_length=100)

    # def __str__(self):  
    #     return self.user  

class Doctor(models.Model):
    user = models.OneToOneField(AllUser, on_delete=models.CASCADE, primary_key=True)    
    email = models.EmailField(max_length=100, unique=True)
    username = models.CharField(max_length=100, unique=True) 
    phone = models.CharField(max_length=100)
    fullname = models.CharField(max_length=100, blank=True) 
    bloodGroup = models.CharField(max_length=10,choices=BLOODGROUP_CHOICES,default="A+")
    gender = models.CharField(max_length=10,choices=GENDER_CHOICES,default="Male")
    date_of_birth = models.DateField(("Date"), default=datetime.date.today)

    USERNAME_FIELD = 'email'

    # def __str__(self):  
    #     return self.user  
    # def __str__(self):
    #   return "{}".format(self.email)


class HospitalUser(models.Model):
    user = models.OneToOneField(AllUser, on_delete=models.CASCADE, primary_key=True)    
    email = models.EmailField(max_length=100, unique=True)
    # first_name = models.CharField(max_length=100)
    # last_name = models.CharField(max_length=100)
    # phone = models.CharField(max_length=100)
    # USERNAME_FIELD = 'email'

    # def __str__(self):
    #   return "{}".format(self.email)
    