from django.contrib.auth import get_user_model
from .models import Events, Photos
from django.db.models import Q
from rest_framework.response import Response
from .serializer import EventSerializer
from rest_framework.decorators import api_view
# list events by creator

@api_view(['GET'])
def get_events_by_creator(request, id):
  if request.method=='GET':
    events= Events.objects.all().filter(creator_id=id)
    events_data= EventSerializer(events, many=True).data
    return Response(events_data)
  
#get all events

#add new event
@api_view(['POST'])
def add_events(request):
  if request.method=='POST':
    data = request.data
    insert = Events(creator_id =request.session.id, name= data['name'], description=data['description'], is_private=data['is_private'])
    insert.save()
    insert_data= EventSerializer(insert)
    return Response(insert_data)
#delete event