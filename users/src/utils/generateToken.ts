import jwt from 'jsonwebtoken'
import { redisClient } from '../index';
type tokenData = {
  id: string, //uuid
  email: string,
  username: string
}
//email, username, id
//generate access and refresh
const generateToken = async (data: tokenData) => {
  const sec = await redisClient?.get(data.id)
  let access_secret = null;
  let refresh_secret= null
  if (sec){
    // map containing access and refresh secrets
    const secret = JSON.parse(sec)
    access_secret = secret.access_secret
    refresh_secret = secret.refresh_secret
  }else{
    // create new random string and store in redis
    access_secret = randomString();
    refresh_secret = randomString();
    // insert into redis 
    redisClient?.set(data.id, JSON.stringify({
      access_secret, refresh_secret
    }));
  }
  return {
    access: jwt.sign({ data }, access_secret, {
      expiresIn: '15m',
    }),
    refresh: jwt.sign({ data }, refresh_secret, {
      expiresIn: '30d',
    })
  }
}

const randomString = () => {
  const len = 64;
  const allCapsAlpha = [..."ABCDEFGHIJKLMNOPQRSTUVWXYZ"]; 
  const allLowerAlpha = [..."abcdefghijklmnopqrstuvwxyz"]; 
  const allUniqueChars = [..."~!@#$%^&*?"];
  const allNumbers = [..."0123456789"];
  const base = [...allCapsAlpha, ...allNumbers, ...allLowerAlpha, ...allUniqueChars];

  return [...Array(len)]
      .map(_ => base[Math.random()*base.length|0])
      .join('');
}

export default generateToken
