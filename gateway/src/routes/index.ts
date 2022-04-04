import { Router } from "express";
import httpProxy from "express-http-proxy";

import checkAuth  from '../middleware/checkAuth';
import { pingController,returnCurrentUser } from "../controllers";
const router = Router();


router.post('/gateway/refresh',function(req, res, next){
  // send a new access token if refresh token is valid
  console.log(req)
  console.log(res)
  console.log(next)
});

router.get('/gateway/ping', pingController);

//all user routes 
//write ip for user-srv load balancer
// impl dns that returns ip

const userServiceProxy = httpProxy('')
router.post('/auth/login', function(req, res, next){
  userServiceProxy(req, res, next)
});

router.post('/auth/signup',function(req, res, next){
  userServiceProxy(req, res, next)
});

router.get('/auth/me', checkAuth, returnCurrentUser);
//get a more detailed 
router.get('/auth/me/detailed', checkAuth, function(req, res, next){
  userServiceProxy(req, res, next)
});

export default router;
