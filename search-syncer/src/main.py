import pika
import os
from .connect import connect_elasticsearch
from .document import Event

RABBITS_USERNAME = os.environ['RABBITS_USERNAME']
RABBITS_PASSWORD = os.environ['RABBITS_PASSWORD']
RABBITS_HOST = os.environ['RABBITS_HOST']
RABBITS_PORT = os.environ['RABBITS_PORT']
ELASTIC_SEARCH_HOST= os.environ['ELASTIC_SEARCH_HOST']
ELASTIC_SEARCH_PORT= os.environ['ELASTIC_SEARCH_PORT']

def startConsumer():
  queue='' #for now add queue to listen to ltr
  credentials = pika.PlainCredentials(RABBITS_USERNAME, RABBITS_PASSWORD)
  parameters = pika.ConnectionParameters(RABBITS_HOST, RABBITS_PORT, '/', credentials)
  connection = pika.BlockingConnection(parameters)
  channel = connection.channel()
  channel.queue_declare(queue=queue)
  channel.basic_consume(queue='',  on_message_callback=insert_into_elastic_search, auto_ack=False)
  channel.start_consuming() 

index_name= 'events_search' #would be created by the search django app
def insert_into_elastic_search(ch, method, properties, body):
  try:
    _= connect_elasticsearch(ELASTIC_SEARCH_HOST, ELASTIC_SEARCH_PORT)
    #has body been passed?
    #doc type is synonymous to schema index is synonymous to table
    ev=Event()
    ev.id= body.id
    ev.creator_id = body.creator_id
    ev.promo_video_url = body.promo_video_url
    ev.name= body.name
    ev.created_at = body.created_at
    ev.event_date = body.event_date
    ev.no_of_tickets_category = body.no_of_tickets_category
    ev.description = body.description
    ev.no_of_tickets = body.no_of_tickets
    ev.is_private = body.is_private
    ev.save()
    ch.basic_ack(delivery_tag = method.delivery_tag)
  except:
    pass

def credientials():
  if RABBITS_USERNAME is None or RABBITS_PASSWORD is None or RABBITS_HOST is None or RABBITS_PORT is None or ELASTIC_SEARCH_HOST is None or ELASTIC_SEARCH_PORT is None:
    return False
  else:
    return True

if __name__ == "__main__":
  if not credientials():
    raise Exception("Needed credientials missing!")
  while True:
    try:
      startConsumer()
    except:
      print('Error starting consumer')
      #TODO: throw error here