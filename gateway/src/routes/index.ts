import { Router } from "express";
import httpProxy from "express-http-proxy";
import { checkAuth } from '../middleware/checkAuth';
const router = Router();


router.post('gateway/refresh',function(req, res, next){
  // send a new access token if refresh token is valid
});
//all user routes
//write ip for user-srv load balancer
// impl dns that returns ip
const userServiceProxy = httpProxy('usr-srv-ip')
router.post('/auth/login', function(req, res, next){
  userServiceProxy(req, res, next)
});

router.post('/auth/signup',function(req, res, next){
  userServiceProxy(req, res, next)
});

router.get('/auth/me', function(req, res, next){
  // this should be handled by gateway.. decode token and return data
});
//get a more detailed 
router.get('/auth/me/detailed', checkAuth, function(req, res, next){
  userServiceProxy(req, res, next)
});

export default router;
