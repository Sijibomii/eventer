from django.urls import path

from .views import search_fun


app_name = 'search'

urlpatterns = [
  path('', search_fun , name='search_route'),
]