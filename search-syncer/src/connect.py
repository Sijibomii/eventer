import Elasticsearch

def connect_elasticsearch(HOST, PORT):
  _es = None
  _es = Elasticsearch([{'host': 'localhost', 'port': 9200}])
  if _es.ping():
    print('Yay Connect')
  else:
    print('Awww it could not connect!')
  return _es