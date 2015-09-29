Browser = require("zombie")
expect  = require("chai").expect

module.exports.World = (callback) ->
  @setupBrowser = (domain) ->
    Browser.localhost(domain, @serverPort)
    @browser = new Browser()

  callback()

# Custom assertions

Browser.Assert.prototype.hasLink = (linkText, linkUrl) ->
  link = @browser.link(linkText)
  expect(link).to.exist
  expect(link.getAttribute("href")).to.eql(linkUrl)
