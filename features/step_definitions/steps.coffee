Browser = require("zombie")
expect  = require("chai").expect

module.exports = ->
  @Given /^I am on the "(.*?)" website^/, (domain) ->
    Browser.localhost(domain, @serverPort)
    @browser = new Browser()

  @When /^I visit "(.*?)"$/, (pageUrl) ->
    @browser.visit(pageUrl)

  @Given /^I visit the home page$/, ->
    @browser.visit("/")

  @When /^I click the "(.*?)" link$/, (linkText) ->
    @browser.clickLink(linkText)

  @Then /^I am on the "(.*?)" page$/, (title) ->
    expect(@browser.text("title")).to.contain(title)

  @Then /^I can see a single article$/, ->
    @browser.assert.elements("article", 1)

  @When /^I click the article title$/, ->
    @browser.clickLink("article h1 a")

  @Then /^I am on the newest article page$/, ->
    expect(@browser.link("#qa-newer")).not.to.exist

  @Then /^I am presented with the following navigation links:$/, (table) ->
    @browser.assert.hasLink(row.label, row.url) for row in table.hashes()

  @Given /^the "(.*?)" navigation link is highlighted$/, (activeLink) ->
    @browser.assert.hasClass(@browser.link(activeLink).parentNode, "c-site-nav__item--current")

  @Given /^I visit the latest article page$/, ->
    @browser.visit("/").then => @browser.clickLink("article h1 a")

  @Then /^no navigation links are highlighted$/, ->
    expect(@browser.query(".c-site-nav__item--current")).not.to.exist
