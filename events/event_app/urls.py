from django.urls import path

from .views import EventView


app_name = 'events'

urlpatterns = [
    path('', EventView.as_view({'get': 'list'}), name='trip_list'),
    path('<uuid:trip_id>/', EventView.as_view({'get': 'retrieve'}), name='trip_detail'),
]