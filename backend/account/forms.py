from django.forms import ModelForm
from django.contrib.auth.forms import UserCreationForm
from django import forms
# from django.contrib.auth.models import User
from .models import *


class CreateUserForm(UserCreationForm):
    # email = forms.cleaned_data.get('email')
    class Meta:
        model = AllUser
        fields = ['username', 'email', 'password1', 'password2']
        extra_kwargs = {'password': {"write_only":True, 'required': True}}

    def create(self, validated_data):
        user =  AllUser.objects.create_user(**validated_data)
        # Token.objects.create(user=user)
        user.is_hospital = True
        user.username = self.cleaned_data.get('username')
        user.save()
        hospital = Hospital.objects.create(user=user)
        hospital.email  = self.cleaned_data.get('email')
        # hospital.phone = self.cleaned_data.get('phone')
        hospital.save()
        return user        