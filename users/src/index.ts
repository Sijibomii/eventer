import express, { Request, Response } from "express";
import { createConnection } from "typeorm";
import path from "path";
import redis , { RedisClientType } from 'redis';
import { json } from 'body-parser';
import { errorHandler } from './middleware/errorHandler';
import { NotFoundError } from './middleware/NotfoundError';

const __dirname = path.resolve();
const main = async() => {
  const app = express();
  app.set('trust proxy', true);
  app.use(json());
  const conn= await createConnection({
    type: 'postgres',
    database: process.env.POSTGRES_DB,//new db
    username: process.env.POSTGRES_USER,
    password: process.env.POSTGRES_PASSWORD,
    logging: true,
    synchronize: true,
    migrations: [path.join(__dirname, "./migrations/*")],
    entities: [] // add entitites here
  });

  await conn.runMigrations();
  console.log('ran')

  const redisClient = redis.createClient({
    url: 'redis://YOUR REDIS INSTANCE URL'
  })

  await redisClient.connect()

  if (redisClient == null){
    //crash app
    throw new Error('REDIS MUST BE DEFINED');
  }

  app.all('*', async (req: Request, res: Response ) => {
    throw new NotFoundError();
  });
  
  app.use(errorHandler);

  app.listen(4000, ()=>{
    console.log('server is running on localhost 4000')
  });
}

main().catch((err)=>{
  console.log(err)
});