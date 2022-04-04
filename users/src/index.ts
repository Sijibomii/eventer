import express from "express";
import { createConnection } from "typeorm";
import "reflect-metadata"
//mport { DataSource } from "typeorm"
import path from "path";
import redis , { RedisClientType } from 'redis';
import { json } from 'body-parser';
import { errorHandler } from './middleware/errorHandler';
import { NotFoundError } from './middleware/NotfoundError';
import indexRouter from './routes/index'
import { User } from './entities/user'
// const __dirname = path.resolve();
type redisClientType = RedisClientType | null;
let redisClient: redisClientType = null;

const main = async() => {
  const app = express();
  app.set('trust proxy', true);
  app.use(json());
  const conn = await createConnection({
    type: 'postgres',
    host: 'users-db-srv',
    database: process.env.POSTGRES_DB,
    username: process.env.POSTGRES_USER,
    password: process.env.POSTGRES_PASSWORD,
    logging: true,
    synchronize: true,
    migrations: [path.join(__dirname, "./migrations/*")],
    entities: [User] // add entitites here
  });

  //await conn.runMigrations();
  console.log(conn)

  redisClient = redis.createClient({
    url: process.env.REDIS_URL
  })
  if (redisClient == null){
    //crash app
    throw new Error('REDIS MUST BE DEFINED');
  }

  await redisClient.connect()

  app.use('/', indexRouter);
  app.all('*', async (_,__) => {
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

export { redisClient };