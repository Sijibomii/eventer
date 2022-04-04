/* AUTHENTICATION MIDDLEWARE
 * This can be added to any route to check for an authenticated user
 */
import { redisClient } from '../index';
import jwt from 'jsonwebtoken';
import {Request, Response, NextFunction} from 'express';

interface Req extends Request {
  session?: {
    email: string,
    username: string,
    id: string
  };
}

type session = {
  email: string,
  username: string,
  id: string
};

const checkAuth = async (req: Req, res: Response, next: NextFunction) => {
  let token;

  if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')
  && req.headers.id
  ){
    try {
      token = req.headers.authorization.split(' ')[1]
      const id: string = req.headers.id as string;

      const sec = await redisClient?.get(id)
      if (sec){
        // map containing access and refresh secrets
        const secret = JSON.parse(sec)
        //validate token using redis stuff
        const decoded = jwt.verify(token, secret.access_secret)
        // map containing email, username, id
        req.session = decoded as session
      }else{
        throw new Error('Not authorized, token failed')
      }
      next()
    } catch (error) {
      console.error(error)
      res.status(401)
      throw new Error('Not authorized, token failed')
    }
  } 
  else{
    res.status(401);
    throw new Error('Not authorized, no token')
  }
}

export default checkAuth;