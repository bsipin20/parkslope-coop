
// Constants.js
const prod = {
 url: {
  API_HOST: process.env.API_HOST; // "239482"
};
const dev = {
 url: {
  API_HOST: ‘http://localhost:3000'
 }
};
export const config = process.env.NODE_ENV === ‘development’ ? dev : prod;
