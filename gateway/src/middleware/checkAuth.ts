/* AUTHENTICATION MIDDLEWARE
 * This can be added to any route to check for an authenticated user
 */
import {Request, Response, NextFunction} from 'express';
const checkAuth = (req: Request, res: Response, next: NextFunction) =>{
  //get token

  //validate token using redis stuff

  //401 not auth if not auth
  next();
}

export default checkAuth;