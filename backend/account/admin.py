from django.contrib import admin
from .models import *
from django.contrib.auth.admin import UserAdmin

# to show the extra fields in the admin panel
class AllUserAdmin(UserAdmin):
    model = AllUser
    list_display = ('id', 'username', 'email', 'phone', 'is_staff', 'is_superuser')

    # list_display = ('id', 'username', 'email', 'phone', 'is_staff', 'is_superuser', 'fullname', 'mobile_number', 'gender', 'date_of_birth', 'bloodGroup', )
    fieldsets = (
        (None, {'fields': ()}),
        ('Permissions', {'fields': ('is_staff', 'is_active', 'is_superuser'
        )}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'email', 'phone','password1', 'password2',)}
        ),  
    )
    # search_fields = ('username', 'email',)
    ordering = ('username', 'email',)


admin.site.register(AllUser, AllUserAdmin)

# Register your models here.
admin.site.register([Patient, Doctor, HospitalUser])
