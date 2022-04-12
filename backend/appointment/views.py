from .serializers import AppointmentSerializer
from .models import Appointment
from django.http import JsonResponse
from rest_framework.parsers import JSONParser
from rest_framework import generics, permissions
from rest_framework.authentication import TokenAuthentication 


# Create your views here.
class AppointmentViewsList(generics.GenericAPIView):
    queryset = Appointment.objects.all()
    serializer_class = AppointmentSerializer
    permission_classes = [permissions.IsAuthenticated] 
    authentication_classes = [TokenAuthentication, ]    
    def post(self, request, *args, **kwargs):
        data = JSONParser().parse(request)
        serializer = AppointmentSerializer(data = data)
        print("user: ",request.user)
        if serializer.is_valid():
            serializer.save(user=request.user)
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)
    
    def get(self, request, *args, **kwargs):
        posts = Appointment.objects.filter(user=request.user)
        serializer = AppointmentSerializer(posts, many=True, context={'request': request})
        return JsonResponse(serializer.data, safe=False)