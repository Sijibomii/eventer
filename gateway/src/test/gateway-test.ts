import request from 'supertest';
import { app } from '../app';
import  httpMocks from 'node-mocks-http';
import { pingController, returnCurrentUser } from '../controllers/index';
import assert from 'assert';
import redis from 'redis';
import { v4 as uuidv4 } from 'uuid';
import { faker } from '@faker-js/faker';
import jwt from 'jsonwebtoken'
console.log(request)
console.log(app)

beforeAll(async () => {
  process.env.mode = 'dev';
});


// test that gateway receives request correctly
test('gateway receives request', async () => {
  const request  = httpMocks.createRequest({
    method: 'GET',
    url: 'gateway/ping',
  });
  const response = httpMocks.createResponse();
  pingController(request, response);
  const data = response._getJSONData();
  assert.equal(data, {
    "message": "ping"
  });
  assert.equal(200, response.statusCode)
})
 
describe('test to return current user', function () {
  let fakeId = null;
  let randomName = null;
  let randomEmail = null;
  let access_secret =null;
  let refresh_secret =null;
  let jwt: any = null;
  beforeEach(async () => {
    fakeId= uuidv4();
    randomName = faker.name.findName(); 
    randomEmail = faker.internet.email(); 
    //before this i have to add a fake id put access secret in redis
    access_secret = uuidv4();
    refresh_secret = uuidv4();
    const client = redis.createClient();
  
    client.set(fakeId, JSON.stringify({
      access_secret, refresh_secret
    }))
  
    //create jwt containing the info and has with secret access and refresh key
    jwt = jwt.sign({ 
      "id": fakeId,
      "email" : randomEmail,
      "username": randomName
     }, access_secret, {
      expiresIn: '15m',
    })
  });

  // test that gateway recieves req and add session to it for auth users
  test('recieves access token and appends session to req', async()=>{
    const request  = httpMocks.createRequest({
      method: 'GET',
      url: '/auth/me',
      headers: {
        authorization: `Bearer ${jwt}`
      }
    });
    const response = httpMocks.createResponse();
    returnCurrentUser(request, response);
    const data = response._getJSONData();
    assert.equal(data, {
      "message": "ping"
    });
  });
    
});

// test that gateway currectly handle unauth users for unauth route
// test that gateway correctly routes req to currect server when unauth
// test that gateway handles 404 error well
//  test that gateway correctly interacts with a mocked redis for access secret
// test that gateway correctly creates and stores access secret during registration
//  test that gateway impl rate-limiting currectly