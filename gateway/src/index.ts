import redis , { RedisClientType } from 'redis';
import { app } from './app';

type redisClientType = RedisClientType | null;
let redisClient: redisClientType = null;

const main = async () => {
  
  redisClient = redis.createClient({
    url: 'redis://YOUR REDIS INSTANCE URL'
  })

  await redisClient.connect()

  if (redisClient == null){
    //crash app
  }

  app.listen(3000, () => {
    console.log('Listening on port 3000!!!!!!!!');
  });

};

export { redisClient };

main().catch((err)=>{
  console.log(err)
});

