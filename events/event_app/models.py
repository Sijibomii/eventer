from email.policy import default
import uuid
from cassandra.cqlengine import columns
from django_cassandra_engine.models import DjangoCassandraModel
from datetime import datetime
class Events(DjangoCassandraModel):
  id= columns.UUID(primary_key= True, default= uuid.uuid4)
  creator_id = columns.UUID(required=True)
  promo_video_url = columns.Text(required=False)
  name= columns.Text(required= True)
  created_at = columns.DateTime(default=datetime.now())
  event_date = columns.DateTime()
  no_of_tickets_category = columns.Decimal()
  description = columns.Text(required=True)
  no_of_tickets = columns.Decimal()
  is_private = columns.Boolean(default=False)

class Photos(DjangoCassandraModel):
  id= columns.UUID(primary_key= True, default= uuid.uuid4)
  is_banner = columns.Boolean(default=False)
  photo_url = columns.Text(required=False)
  event_id = creator_id = columns.UUID(required=True)
