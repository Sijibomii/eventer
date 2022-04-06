// test integration with postgres

//test integrations with redis

const axios = require('axios');
const assert = require('assert');
describe('test gateways integration with redis and postgres', function () {

  test('gateway integrates well with redis', async function () { 
    const response = await axios.get('http://34.102.248.67/users/test/redis/');
    const  { data } = response;
    assert.equal(data.length, 2);
    assert.deepEqual(data[0], { 
      "id": "test-id",
      "name": "random" 
    })
  });


  test('gateway integrates well with posgtres', async function () {
    const response = await axios.get('http://34.102.248.67/users/test/postgres/'); 
    const  { data } = response;
    assert.equal(data.length, 2);
  })
});