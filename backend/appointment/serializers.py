from rest_framework import serializers
from .models import Appointment

class AppointmentSerializer(serializers.ModelSerializer):   
    user = serializers.ReadOnlyField(source='AllUser.user')

    class Meta:
        model = Appointment
        # fields = ("user", "username", "of_type", "weight", "size", "price")
        fields = "__all__"
