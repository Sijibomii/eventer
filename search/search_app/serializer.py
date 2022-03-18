from rest_framework import serializers
from .models import Events

class SearchSerializer(serializers.ModelSerializer):
  class Meta:
    model = Events
    fields = '__all__'
    read_only_fields = ('id',)
