import * as redis  from 'redis';
import  { RedisClientType } from 'redis';
import createError  from "http-errors";
import express, {Request, Response, NextFunction, Errback}  from "express";
import  indexRouter  from './routes';


type redisClientType = RedisClientType | null;
let redisClient: redisClientType = null;

const main = async () => {
  if (process.env.NODE_ENV == 'production'){
    redisClient = redis.createClient({
      url: process.env.REDIS_URL
    })
    await redisClient.connect()
  }
  
  if (redisClient == null && process.env.NODE_ENV  === 'production'){
    //crash app
    throw new Error('REDIS CLIENT must be defined');
  }
  const app = express();

  app.use('/', indexRouter);

    // catch 404 and forward to error handler
  app.use(function(__, _, next) {
    next(createError(404));
  });

    // error handler
  app.use(function(err: Errback , req: Request, res:Response, next: NextFunction) {
      //handle errors here
    //for now so it'll let me compile
    console.log(err)
    console.log(req)
    console.log(res)
    console.log(next)
});

  app.listen(3000, () => {
    console.log('Listening on port 3000!!!!!!!!');
  });
};
 
export { redisClient };

main().catch((err)=>{
  console.log(err)
});

 