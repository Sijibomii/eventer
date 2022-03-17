import json
import queue
import pika
from django.conf import settings

USERNAME = settings.RABBITS_USERNAME
PASSWORD = settings.RABBITS_PASSWORD
HOST = settings.RABBITS_HOST
PORT= settings.RABBITS_PORT
queue='' #for now add queue to listen to ltr
credentials = pika.PlainCredentials(USERNAME, PASSWORD)
parameters = pika.ConnectionParameters(HOST, PORT, '/', credentials)
connection = pika.BlockingConnection(parameters)
channel = connection.channel()
channel.queue_declare(queue=queue)

def callback(channel, method, properties, body):
  pass

channel.basic_consume(queue=queue, on_message_callback= callback)

channel.start_consuming()
channel.close()
