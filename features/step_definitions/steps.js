const Browser = require("zombie")

module.exports = function () {
  this.World = require("../support/world").World

  this.Given(/I am on the "([^"]*)" website/, function (domain, callback) {
    this.setupBrowser(domain)
    callback()
  })

  this.Given("I visit the home page", function () {
    return this.visit("/")
  })

  this.Then(/^I can see a "([^"]*)" link$/, function (linkText, callback) {
    this.browser.assert.text("a.o-pagination__link", linkText, "/archives")
    callback()
  })
}
