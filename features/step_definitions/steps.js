var expect  = require("chai").expect;
var Browser = require("zombie");

Browser.Assert.prototype.navLinkExists = function (text, url) {
  var link = this.browser.link(text);
  expect(link).to.exist;
  expect(link.getAttribute("href")).to.eql(url);
}

module.exports = function () {
  this.World = require("../support/world").World;

  this.Given(/I am on the "(.*?)" website/, function (domain, done) {
    this.setupBrowser(domain);
    done();
  });

  this.Given("I visit the home page", function () {
    return this.visit("/");
  });

  this.When(/^I click the "(.*?)" link$/, function (linkID, done) {
    this.browser.clickLink("Browse posts", done);
  });

  this.Then(/^I am on the "(.*?)" page$/, function (title, done) {
    this.browser.assert.text("title", new RegExp(title));
    done();
  });

  this.Then(/^I can see a single article$/, function (done) {
    this.browser.assert.elements("article", 1);
    done();
  });

  this.When(/I click the latest article title/, function (done) {
    this.browser.clickLink("article h1 a", done);
  });

  this.When(/^I click the article title$/, function (done) {
    this.browser.clickLink("article h1 a", done);
  });

  this.Then(/^I am on the newest article page$/, function (done) {
    expect(this.browser.link("#qa-newer")).not.to.exist;
    done();
  });

  this.When(/^I visit "(.*?)"$/, function (pageUrl) {
    return this.visit(pageUrl);
  });

  this.Then(/^I am presented with the following navigation links:$/, function (table, done) {
    var rows = table.hashes();
    for (var i = 0; i < rows.length; i++) {
      this.browser.assert.navLinkExists(rows[i].label, rows[i].url);
    }
    done();
  });

  this.Given(/^the "(.*?)" navigation link is highlighted$/, function (activeLink, done) {
    this.browser.assert.hasClass(this.browser.link(activeLink).parentNode, "c-site-nav__item--current");
    done();
  });

  this.Given(/^I visit the latest article page$/, function (done) {
    this.visit("/").then(function () {
      this.browser.clickLink("article h1 a", done);
    }.bind(this));
  });

  this.Then(/^no navigation links are highlighted$/, function (done) {
    expect(this.browser.query(".c-site-nav__item--current")).not.to.exist;
    done();
  });
};
