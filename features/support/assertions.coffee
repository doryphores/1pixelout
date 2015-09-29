expect  = require("chai").expect
Browser = require("zombie")

Browser.Assert.prototype.hasLink = (linkText, linkUrl) ->
  link = @browser.link(linkText)
  expect(link).to.exist
  expect(link.getAttribute("href")).to.eql(linkUrl)
