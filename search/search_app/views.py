from django.shortcuts import render
from rest_framework.response import Response
from .serializer import SearchSerializer
from rest_framework.decorators import api_view
from .documents import EventDocument
# Create your views here.

@api_view(['GET'])
def search_fun(request):
  search_str = request.GET.get('search','')
  s = EventDocument.search().filter("term", name=search_str)
  s= s + EventDocument.search().filter("term", description=search_str)
  qs = s.to_queryset()
  search_data= SearchSerializer(qs, many=True).data
  return Response(search_data)
