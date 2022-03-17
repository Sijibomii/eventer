import json
import pika
from django.conf import settings

USERNAME = settings.RABBITS_USERNAME
PASSWORD = settings.RABBITS_PASSWORD
HOST = settings.RABBITS_HOST
PORT= settings.RABBITS_PORT
# Set the connection parameters to connect to rabbit-server1 on port 5672
# on the / virtual host using the username "guest" and password "guest"
credentials = pika.PlainCredentials(USERNAME, PASSWORD)
parameters = pika.ConnectionParameters(HOST, PORT, '/', credentials)
connection = pika.BlockingConnection(parameters)
channel = connection.channel()

def publish(method, body):
  properties = pika.BasicProperties(method)
  #routing key is the name of the queue
  channel.basic_publish(exchange='', routing_key='events_queue', body=json.dumps(body), properties=properties)

