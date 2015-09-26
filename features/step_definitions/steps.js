const assert = require("assert")

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

  this.When(/^I click the "([^"]*)" link$/, function (linkID, callback) {
    this.browser.clickLink("Browse posts", callback)
  })

  this.Then(/^I am on the "([^"]*)" page$/, function (title, callback) {
    this.browser.assert.text("title", new RegExp(title))
    callback()
  })

  this.Then(/^I can see the latest article$/, function (callback) {
    this.browser.assert.elements("article", 1)
    this.browser.clickLink("article h1 a", function () {
      assert.strictEqual(this.browser.link("#qa-newer"), null)
      callback()
    }.bind(this))
  })
}
