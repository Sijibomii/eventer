// import request from 'supertest';
// import { app } from '../app';
import  httpMocks from 'node-mocks-http';
import { pingController, returnCurrentUser } from '../controllers/index';
import assert from 'assert';
import redis from 'redis';
import { v4 as uuidv4 } from 'uuid';
import { faker } from '@faker-js/faker';
import jwt from 'jsonwebtoken';
// console.log(request)
// console.log(app)

beforeAll(async () => {
  process.env.mode = 'dev';
});


// test that gateway receives request correctly
 
describe('test to return current user', function () {
  let fakeId:any = null;
  let randomName:any = null;
  let randomEmail:any = null;
  let access_secret =null;
  let refresh_secret =null;
  let jwtt:any = null

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
     jwtt = jwt.sign({ 
      "id": fakeId,
      "email" : randomEmail,
      "username": randomName
     }, access_secret, {
      expiresIn: '15m',
    })
  });


  test('gateway receives request', async () => {
    const request  = httpMocks.createRequest({
      method: 'GET',
      url: 'gateway/ping',
    });
    const response = httpMocks.createResponse();
    pingController(request, response);
    const data = response._getData();
    assert.deepEqual(data, { "message": "pong"});
    assert.equal(200, response.statusCode)
  })

  //TODO: TEST MIDDLEWARE!!
  // test that gateway recieves req and add session to it for auth users
  test('recieves access token and appends session to req', async()=>{
    const request  = httpMocks.createRequest({
      method: 'GET',
      url: '/auth/me',
      headers: {
        authorization: `Bearer ${jwtt}`
      },
      session:{
        "id": fakeId,
        "email" : randomEmail,
        "username": randomName
      }
    });
    const response = httpMocks.createResponse();
    returnCurrentUser(request, response);
    const data = response._getData();
    assert.deepEqual(data, {
      "currentUser": {
        "id": fakeId,
        "email" : randomEmail,
        "username": randomName
      }
    });
  });

  // test that gateway correctly returns currentUser when unauth
  test('recieves access token and appends session to req', async()=>{
    const request  = httpMocks.createRequest({
      method: 'GET',
      url: '/auth/me',
    });
    const response = httpMocks.createResponse();
    returnCurrentUser(request, response);
    const data = response._getData();
    assert.deepEqual(data, {
      "currentUser": "nill"
    });
  });

  // test that gateway handles 404 error well
  

  //  test that gateway impl rate-limiting currectly
});

// test that gateway currectly handle unauth users for unauth route
// test that gateway correctly routes req to currect server when unauth

//  test that gateway correctly interacts with a mocked redis for access secret
// test that gateway correctly creates and stores access secret during registration
