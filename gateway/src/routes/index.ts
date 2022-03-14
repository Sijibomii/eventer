import { Router } from "express";
import httpProxy from "express-http-proxy";
const router = Router();

//all user routes
//write ip for user-srv load balancer
const userServiceProxy = httpProxy('usr-srv-ip')
router.post('/auth/login', function(req, res, next){
  userServiceProxy(req, res, next)
});

router.post('/auth/signup', function(req, res, next){
  userServiceProxy(req, res, next)
});