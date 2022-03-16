from email.policy import default
import uuid
from cassandra.cqlengine import columns
from django_cassandra_engine.models import DjangoCassandraModel

class Events(DjangoCassandraModel):
  id= columns.UUID(primary_key= True, default= uuid.uuid4)
  creator_id = columns.UUID(required=True)
  promo_video_url = columns.Text(required=False)
  name= columns.Text(required= True)
  created_at = columns.DateTime()
  description = columns.Text(required=True)


class Photos(DjangoCassandraModel):
  id= columns.UUID(primary_key= True, default= uuid.uuid4)
  is_banner = columns.Boolean(default=False)
  photo_url = columns.Text(required=False)
  event_id = creator_id = columns.UUID(required=True)
