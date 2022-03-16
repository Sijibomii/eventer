from rest_framework import serializers
from .models import Events,Photos


class PhotosSerializer(serializers.ModelSerializer):
  class Meta:
    model = Photo
    fields = '__all__'
    read_only_fields = ('id',)

class EventSerializer(serializers.ModelSerializer):
  class Meta:
    model = Events
    fields = '__all__'
    read_only_fields = ('id',)
