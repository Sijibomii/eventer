import { Router } from "express";
import httpProxy from "express-http-proxy";
import { redisTestController, userServiceTestController } from '../controllers/testController'
import checkAuth  from '../middleware/checkAuth';
//import { USER_SRV_IP } from '../utils/constansts';
import { pingController,returnCurrentUser } from "../controllers";
const router = Router();


router.post('/gateway/refresh',function(req, res, next){
  // send a new access token if refresh token is valid
  console.log(req)
  console.log(res) 
  console.log(next)
});

router.get('/gateway/ping', pingController);

// find a way to remove this in prod
router.get('/gateway/test/redis', redisTestController);

router.get('/gateway/test/users', userServiceTestController)
//all user routes 

const userServiceProxy = httpProxy('users-srv.staging.svc.cluster.local:80')

router.get('/users/test/postgres/', function(req, res, next){
  userServiceProxy(req, res, next)
});

router.get('/users/test/redis/', function(req, res, next){
  userServiceProxy(req, res, next)
});

router.post('/auth/login', function(req, res, next){
  userServiceProxy(req, res, next)
});

router.post('/auth/signup',function(req, res, next){
  userServiceProxy(req, res, next)
});
//??
router.get('/auth/me/detailed', checkAuth, function(req, res, next){
  userServiceProxy(req, res, next)
});
router.get('/auth/me', checkAuth, returnCurrentUser); 
//get a more detailed 


export default router;
