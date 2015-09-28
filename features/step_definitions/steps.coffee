expect  = require("chai").expect

module.exports = ->
  @World = require("../support/world").World

  @Given /I am on the "(.*?)" website/, (domain, done) ->
    @setupBrowser(domain)
    done()

  @When /^I visit "(.*?)"$/, (pageUrl) ->
    @visit(pageUrl)

  @Given /^I visit the home page$/, ->
    @visit("/")

  @When /^I click the "(.*?)" link$/, (linkID) ->
    @browser.clickLink("Browse posts")

  @Then /^I am on the "(.*?)" page$/, (title, done) ->
    @browser.assert.text("title", new RegExp(title))
    done()

  @Then /^I can see a single article$/, (done) ->
    @browser.assert.elements("article", 1)
    done()

  @When /I click the latest article title/, ->
    @browser.clickLink("article h1 a")

  @When /^I click the article title$/, -> @browser.clickLink("article h1 a")

  @Then /^I am on the newest article page$/, (done) ->
    expect(@browser.link("#qa-newer")).not.to.exist
    done()

  @Then /^I am presented with the following navigation links:$/, (table, done) ->
    @browser.assert.hasLink(row.label, row.url) for row in table.hashes()
    done()

  @Given /^the "(.*?)" navigation link is highlighted$/, (activeLink, done) ->
    @browser.assert.hasClass(@browser.link(activeLink).parentNode, "c-site-nav__item--current")
    done()

  @Given /^I visit the latest article page$/, () ->
    @visit("/").then => @browser.clickLink("article h1 a")

  @Then /^no navigation links are highlighted$/, (done) ->
    expect(@browser.query(".c-site-nav__item--current")).not.to.exist
    done()
