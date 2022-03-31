import { Request, Response }  from "express";

interface Req extends Request {
  session?: {
    email: string,
    username: string,
    id: string
  };
}


const pingController = (_: Request, res: Response) =>{
  res.send({
    "message": "pong"
  }).status(200);
}

const returnCurrentUser = (req: Req, res: Response) => {
  if(!req.session){
    res.send({
      "currentUser": "nill"
    }).status(200);
  }
  res.send({
    "currentUser": req.session
  }).status(200);
}

export { pingController, returnCurrentUser };