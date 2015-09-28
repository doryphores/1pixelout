Hexo = require("hexo")

module.exports = ->
  serverIsReady = false

  # Create a new silent Hexo instance
  hexo = new Hexo process.cwd(),
    silent: true

  @Before ->
    # Do nothing if the server is ready
    return Promise.resolve() if serverIsReady

    # Initialise hexo, clean generated files and start a local server
    hexo.init()
    .then -> hexo.call("clean", {})
    .then -> hexo.call("server", { port: 4040 })
    .then -> serverIsReady = true
    .catch (err) ->
      # An error occurred so exit hexo and return a rejection
      hexo.exit()
      Promise.reject(err)

  # Close the hexo local server when everything is done
  @registerHandler "AfterFeatures", (event, callback) ->
    hexo.exit().then(callback)
