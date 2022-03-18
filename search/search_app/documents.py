from django_elasticsearch_dsl import Document
from django_elasticsearch_dsl.registries import registry
from .models import Event

@registry.register_document
class EventDocument(Document):
  class Index:
    name = 'events'

  settings = {
        'number_of_shards': 1,
        'number_of_replicas': 0
    }
  class Django:
    model = Event
    fields = [
             'name',
             'desc',
             'name',
            'desc',
            'id',
            'creator_id',
            'promo_video_url',
            'created_at',
            'event_date',
            'no_of_tickets_category',
            'no_of_tickets',
            'is_private'
         ]