import { Router } from "express";
import { User } from '../entities/user';
import { getConnection } from  "typeorm";
import argon2 from "argon2";
import generateToken  from '../utils/generateToken';
const router = Router();

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
    token: generateToken(user.id),// access and refresh
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
  res.json({
    id: user.id,
    username: user.username,
    email: user.email
  })

});


