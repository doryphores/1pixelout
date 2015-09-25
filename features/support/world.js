const Browser = require("zombie")

function World(callback) {
  this.setupBrowser = function (domain, port) {
    Browser.localhost(domain, 4040)
    this.browser = new Browser()
  }

  this.visit = function (url) {
    return this.browser.visit(url)
  }

  callback()
}

module.exports.World = World
