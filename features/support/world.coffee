Browser = require("zombie")
expect  = require("chai").expect

module.exports.World = (callback) ->
  @setupBrowser = (domain, port) ->
    Browser.localhost(domain, 4040)
    @browser = new Browser()

  @visit = (url) -> @browser.visit(url)

  callback()

# Custom assertions

Browser.Assert.prototype.hasLink = (linkText, linkUrl) ->
  link = @browser.link(linkText)
  expect(link).to.exist
  expect(link.getAttribute("href")).to.eql(linkUrl)
