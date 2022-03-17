from elasticsearch_dsl import connections
from elasticsearch import  Elasticsearch

def connect_elasticsearch(HOST, PORT):
  connections.create_connection(hosts=[HOST], timeout=20)
  _es = None
  _es = Elasticsearch([{'host': HOST, 'port': PORT}])
  if _es.ping():
    print('Yay Connect')
  else:
    print('Awww it could not connect!')
  return _es