const { createProxyMiddleware } = require('http-proxy-middleware');
const fs = require('fs');

const protocol = JSON.parse(process.env.HTTPS) ? "https:" : "http:";
const host = process.env.API_HOST
const port = process.env.API_PORT

module.exports = function(app) {
  app.use(
    '/producepricetimeline',
    createProxyMiddleware({
      target: {
        protocol: protocol,
        host: host,
        port: 3000
      },
      changeOrigin: true,
    })
  );
};
