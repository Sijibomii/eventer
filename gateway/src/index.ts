import * as redis  from 'redis';
import  { RedisClientType } from 'redis';
import { app } from './app';

type redisClientType = RedisClientType | null;
let redisClient: redisClientType = null;

const main = async () => {

  redisClient = redis.createClient({
    url: process.env.REDIS_URL
  })
  await redisClient.connect()
  if (redisClient == null && process.env.mode  === 'prod'){
    //crash app
    throw new Error('REDIS CLIENT must be defined');
  }
  app.listen(3000, () => {
    console.log('Listening on port 3000!!!!!!!!');
  });
};
 
export { redisClient };

main().catch((err)=>{
  console.log(err)
});

 