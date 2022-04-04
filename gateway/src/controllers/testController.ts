import { Request, Response }  from "express";
import { redisClient } from '../index';
import axios from 'axios';
//import { USER_SRV_IP } from '../utils/constansts'
const redisTestController = async (_: Request, res: Response) =>{
  if (redisClient == null){
    res.send({
      "message": "test-failed"
    }).status(500)
  }
  //insert random stuff into redis
  await redisClient?.set('test', JSON.stringify([
    {
      "id": "test-id",
      "name": "random"
    },
    {
      "id": "test-id",
      "name": "random"
    }
  ]))

  const get = await redisClient?.get('test');
  res.send(get).status(200)
}

const userServiceTestController = async (_: Request, res: Response) =>{
  const resp = await axios.get(`http://users-srv/test/ping/`)
  res.send(resp.data)
}
export { redisTestController, userServiceTestController };