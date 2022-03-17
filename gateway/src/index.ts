import createError  from "http-errors";
import express, {Request, Response, NextFunction, Errback}  from "express";
import  indexRouter  from './routes';
import redis , { RedisClientType } from 'redis';

type redisClientType = RedisClientType | null;
let redisClient: redisClientType = null;

const main = async () => {
  const app = express();

  redisClient = redis.createClient({
    url: 'redis://YOUR REDIS INSTANCE URL'
  })

  await redisClient.connect()

  if (redisClient == null){
    //crash app
  }

  app.use('/', indexRouter);

  // catch 404 and forward to error handler
  app.use(function(req, res, next) {
    next(createError(404));
  });

  // error handler
  app.use(function(err: Errback , req: Request, res:Response, next: NextFunction) {
    //handle errors here
  });

};

export { redisClient };

main().catch((err)=>{
  console.log(err)
});

