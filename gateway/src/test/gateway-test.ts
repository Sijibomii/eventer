import request from 'supertest';
import { app } from '../app';

console.log(request)
console.log(app)

// test that gateway receives info currectly
//test that gateway recieves req and add session to it
// test that gateway currectly handle unauth users for unauth route
// test that gateway correctly routes req to currect server when unauth
// test that gateway handles 404 error well
//  test that gateway correctly interacts with a mocked redis for access secret
// test that gateway correctly creates and stores access secret during registration
//  test that gateway impl rate-limiting currectly