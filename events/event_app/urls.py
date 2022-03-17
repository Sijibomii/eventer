from django.urls import path

from .views import get_events_by_creator, add_events


app_name = 'events'

urlpatterns = [
  path('<uuid:creator_id>/', get_events_by_creator , name='event_creator'),
  path('', add_events, name='events_add')
]