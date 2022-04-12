from django.contrib import admin
from .models import *

# Register your models here.
admin.site.register([Hospital, FavouriteHospital, FavouriteDoctor, MedicalNewsImageSlider, Doctor])

class HospitalSubAdminArea(admin.AdminSite):
    site_header = 'Hospital Sub-Admin Area'

sub_admin_site = HospitalSubAdminArea(name='HospitalSubAdmin')
sub_admin_site.register([Hospital, Doctor])
