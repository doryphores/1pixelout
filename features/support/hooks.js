var Hexo = require("hexo")

module.exports = function () {
  const hexo = new Hexo(process.cwd(), {
    silent: true
  })

  this.registerHandler("BeforeFeature", function (event, callback) {
    hexo.init().then(function () {
      return hexo.call("clean", {})
    }).then(function () {
      return hexo.call("server", {
        port: 4040
      }).then(callback)
    }).catch(function (err) {
      hexo.exit()
      callback()
    })
  })

  this.registerHandler("AfterFeature", function (event, callback) {
    hexo.exit().then(callback)
  })
}
