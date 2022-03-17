import pika
import os

RABBITS_USERNAME = os.environ['RABBITS_USERNAME']
RABBITS_PASSWORD = os.environ['RABBITS_PASSWORD']
RABBITS_HOST = os.environ['RABBITS_HOST']
RABBITS_PORT = os.environ['RABBITS_PORT']

def startConsumer():
  queue='' #for now add queue to listen to ltr
  credentials = pika.PlainCredentials(RABBITS_USERNAME, RABBITS_PASSWORD)
  parameters = pika.ConnectionParameters(RABBITS_HOST, RABBITS_PORT, '/', credentials)
  connection = pika.BlockingConnection(parameters)
  channel = connection.channel()
  channel.queue_declare(queue=queue)
  channel.basic_consume(queue='',  on_message_callback=insert_into_elastic_search, auto_ack=True)
  channel.start_consuming()


def insert_into_elastic_search(channel, method, properties, body):
  pass


if __name__ == "__main__":
  while True:
    try:
      startConsumer()
    except:
      print('Error starting consumer')
      #TODO: throw error here