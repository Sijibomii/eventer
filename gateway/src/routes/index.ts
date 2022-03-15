import { Router } from "express";
import httpProxy from "express-http-proxy";
const router = Router();


router.post('gateway/refresh', function(req, res, next){
  // send a new access token if refresh token is valid
});
//all user routes
//write ip for user-srv load balancer
const userServiceProxy = httpProxy('usr-srv-ip')
router.post('/auth/login', function(req, res, next){
  userServiceProxy(req, res, next)
});

router.post('/auth/signup', function(req, res, next){
  userServiceProxy(req, res, next)
});

router.get('/auth/me',function(req, res, next){
  userServiceProxy(req, res, next)
});

export default router;
