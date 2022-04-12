from django.conf import settings
from django.db import models
# from account.models import Patient, AllUser
# os.environ['DJANGO_SETTINGS_MODULE'] = 'backend.settings'

# Create your models here.

class Appointment(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, null=True)
    # username = models.CharField(max_length=100)
    doctor_name = models.CharField(max_length=100)
    doctor_image = models.ImageField(upload_to="doctors", blank=True)
    appointment_date = models.DateField()
    full_name = models.CharField(max_length=100)
    email = models.CharField(max_length=100)
    phone = models.CharField(max_length=100)
    address = models.CharField(max_length=100)

    def __str__(self):  
        return f"User = {self.user}  ||  Doctorname = {self.doctor_name}  ||  Full Name = {self.full_name}"
