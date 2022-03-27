import request from 'supertest';
import { app } from '../app';

console.log(request)
console.log(app)

test('always padd', () => {
  expect(true).toBeTruthy();
});