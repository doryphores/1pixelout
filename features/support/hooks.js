var Hexo        = require("hexo")
var http        = require("http")
var serveStatic = require("serve-static")
var path        = require("path")

module.exports = function () {
  const hexo = new Hexo(process.cwd(), {
    silent: true
  })

  this.Before(function () {
    var self = this

    return hexo.init().then(function () {
      return hexo.call("clean", {})
    }).then(function () {
      return hexo.call("generate", {})
    }).then(function () {
      return hexo.call("server", {
        port: 4040,
        static: true
      })
    }).catch(function (err) {
      console.log(err);
      return hexo.exit(err)
    })
  })

  this.After(function (callback) {
    hexo.exit().then(callback)
  })
}
