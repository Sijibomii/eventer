from elasticsearch_dsl import Document,Text,Integer,Date, Boolean

class Event(Document):
  id = Text()
  creator_id = Text()
  promo_video_url = Text()
  name= Text()
  created_at = Date()
  event_date = Date()
  no_of_tickets_category = Integer()
  description = Text()
  no_of_tickets = Integer()
  is_private = Boolean()

  class Index:
    name='events'
