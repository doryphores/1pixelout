---
title: Writing functional tests for a Hexo generated site
excerpt: 'A quick overview of how to write functional tests for a Hexo site using cucumber.js, zombie.js and CoffeeScript'
tags:
  - hexo
  - cucumber
date: 2015-09-29 14:18:24
---

This is just a quick overview of how to write functional tests for a Hexo site.

We will use:
- [cucumber.js](https://github.com/cucumber/cucumber-js) for running the features
- [zombie.js](http://zombie.js.org/) as a headless browser
- [CoffeeScript](coffeescript.org/) to write the step definitions

_**Note**: The latest version of zombie.js only runs on iojs so if you you want to stick to node, pin it to version 3.x._

## The feature

Let's start with the following feature. It tests that the home page shows the latest article. It does this by visiting the home page, asserting that there is a single article on the page, clicking its title and checking that the article page does not have a "Newer post" link (i.e. it is the latest).

```feature
Feature: The generated site is OK to deploy
  As the owner of myblog.com
  I want to check that the generated site is OK
  So that I am confident it is OK to deploy

  Background:
    Given I am on the "myblog.com" website

  Scenario: The home page shows the latest article
    When I visit the home page
    Then I can see a single article
    When I click the article title
    Then I am on the newest article page
```

## Starting and stopping the local hexo server

To start the server, we use a before hook (in `features/support/hooks.coffee`):

```coffee
Hexo = require("hexo")

SERVER_PORT = 4040

module.exports = ->
  serverIsReady = false

  # Create a new silent Hexo instance (we don't want any output)
  hexo = new Hexo process.cwd(),
    silent: true

  @Before ->
    # We need to server port to configure zombie later on
    @serverPort = SERVER_PORT

    # Do nothing if the server is ready
    return Promise.resolve() if serverIsReady

    # Initialise hexo, clean generated files and start a local server
    hexo.init()
    .then -> hexo.call("clean", {})
    .then -> hexo.call("server", { port: SERVER_PORT })
    .then -> serverIsReady = true
    .catch (err) ->
      # An error occurred so exit hexo and return a rejection
      hexo.exit()
      Promise.reject(err)

  # Close the hexo local server when everything is done
  @registerHandler "AfterFeatures", (event, callback) ->
    hexo.exit().then(callback)
```

## The browser instance

We use a background step to setup the browser:

```feature
Background:
  Given I am on the "myblog.com" website
```

Here's the background step definition:

```coffee
Browser = require("zombie")

module.exports = ->
  @Given /I am on the "(.*?)" website/, (domain, done) ->
    Browser.localhost(domain, @serverPort)
    @browser = new Browser()
    done()
```

zombie.js has a [`localhost`](https://github.com/assaf/zombie#browserlocalhosthost-port) method to configure the browser to route requests to a local server. This is where we need `@serverPort` from the `Before` hook defined earlier.

## The step definitions

Now that we have configured the browser instance, we can write the steps. CoffeeScript is great for writing steps or spec examples as it does away with all the syntax noise and we're left with the essential information.

```coffee
Browser = require("zombie")
expect  = require("chai").expect

module.exports = ->
  @Given /^I am on the "(.*?)" website$/, (domain) ->
    Browser.localhost(domain, @serverPort)
    @browser = new Browser()

  @Given /^I visit the home page$/, ->
    @browser.visit("/")

  @Then /^I can see a single article$/, ->
    @browser.assert.elements("article", 1)

  @When /^I click the article title$/, ->
    @browser.clickLink("article h1 a")

  @Then /^I am on the newest article page$/, ->
    expect(@browser.link("Newer post")).not.to.exist
```

## The deploy script

We can now define `test` and `deploy` npm commands. In your `package.json`:

```json
{
  "scripts": {
    "start": "hexo server --draft",
    "test": "cucumberjs --compiler coffee:coffee-script/register",
    "deploy": "cucumberjs -f progress --compiler coffee:coffee-script/register && hexo deploy --generate"
  }
}
```

Now, when you run the following command, cucumberjs will run your features and deploy if they all pass:

```
> npm run deploy
```

To run the tests by themselves:

```
> npm test
```
