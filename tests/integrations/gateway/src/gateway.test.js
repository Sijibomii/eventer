//import assert from 'assert';
//import axios from 'axios';
const axios = require('axios');
const assert = require('assert');
describe('test gateways integration with redis', function () {

  test('gateway integrates well with redis', async function () { 
    const response = await axios.get('http://34.102.248.67/gateway/test/redis/');
    const  { data } = response;
    assert.equal(data.length, 2);
    assert.deepEqual(data[0], {
      "id": "test-id",
      "name": "random"
    })
  });


  test('gateway integrates well with users', async function () {
    const response = await axios.get('http://34.102.248.67/gateway/test/users/');
    const  { data } = response;
    assert.deepEqual(data, {
      "message":"pong"
    })
  })
});