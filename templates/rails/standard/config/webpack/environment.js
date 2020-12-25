const { environment } = require('@rails/webpacker')
const path = require('path');

environment.config.merge({
  resolve: {
    alias: {
      "frontend": path.join(__dirname, "..", "..",  "/app/frontend"),
      "channels": path.join(__dirname, "..", "..",  "/app/frontend/channels"),
    }
  }
})

module.exports = environment
