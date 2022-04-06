import { Router } from "express";
import { User } from '../entities/user';
import { getConnection } from  "typeorm"; 
import argon2 from "argon2";
import generateToken  from '../utils/generateToken';
import { faker } from '@faker-js/faker';  
import { redisClient } from "../index";
const router = Router();

router.get('/users/test/ping/', function (_, res){
  res.send({
    "message":"pong"
  }).status(200)
});

router.get('/users/test/postgres/', async function  (_, res) {

  const rslt = await getConnection()
  .createQueryBuilder()
  .insert()
  .into(User)
  .values({
    username: faker.name.findName(),
    email: faker.internet.email(),
    password: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  })
  .returning("*")
  .execute();

  const result = rslt.raw[0];

  res.json([
    {
      id: result.id,
      username: result.username, 
      email: result.email,
    },
    {
      id: result.id,
      username: result.username, 
      email: result.email,
    }
  ])

});


router.get('/users/test/redis/', async function  (_, res) {

  if (redisClient == null){
    res.send({
      "message": "test-failed"
    }).status(500)
  }
  //insert random stuff into redis
  await redisClient?.set('test', JSON.stringify([
    {
      "id": "test-id",
      "name": "random"
    },
    {
      "id": "test-id",
      "name": "random"
    }
  ]))

  const get = await redisClient?.get('test');
  res.send(get).status(200)

});

router.post('/auth/login', async function  (req, res) {
  // handle shit here
  const { email, password } = req.body;
  const user = await User.findOne(email);
  
  if (!user) {
    res.status(401)
    throw new Error('Invalid email or password')
  }
  const valid = await argon2.verify(user.password, password);
  if (!valid) {
    res.status(401)
    throw new Error('Invalid email or password')
  }
  res.json({
    id: user.id,
    username: user.username,
    email: user.email,
    token: generateToken({
    id: user.id,
    username: user.username,
    email: user.email
    }),// access and refresh 
  })

});

router.post('/auth/signup', async function(req, res){
  // handle shit here
  const { email, password, username } = req.body;
  const user = await User.findOne(email);

  if (user){
    res.status(200)
    throw new Error('User exist sign in')
  }
  const hashedPassword = await argon2.hash(password);

  const result = await getConnection()
  .createQueryBuilder()
  .insert()
  .into(User)
  .values({
    username: username,
    email: email,
    password: hashedPassword,
  })
  .returning("*")
  .execute();

   const userRet = result.raw[0];
   res.json({
    id: userRet.id,
    username: userRet.username, 
    email: userRet.email,
    token: generateToken(userRet.id),// access and refresh
  })

});

router.get('/auth/me/detailed', async function(req: any, res){
  // req.session should have details already
  const session: any = req.session
  const user = await User.findOne(session.email);
  if (user){
    res.json({
      id: user.id,
      username: user.username,
      email: user.email
    })
  }else{
    res.json({})
  }
  

});


export default router;

