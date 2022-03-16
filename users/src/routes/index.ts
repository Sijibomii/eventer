import { Router } from "express";
import { User } from '../entities/user';
import argon2 from "argon2";
const router = Router();

router.post('/auth/login', async function  (req, res, next) {
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

router.post('/auth/signup', function(req, res, next){
  // handle shit here

});

router.get('/auth/me',function(req, res, next){
  // handle shit here

});