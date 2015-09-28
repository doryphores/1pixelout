var Hexo = require("hexo")

var _inited = false;

module.exports = function () {
  var hexo = new Hexo(process.cwd(), {
    silent: true
  });

  this.Before(function (callback) {
    if (_inited) {
      callback();
      return;
    }

    hexo.init().then(function () {
      return hexo.call("clean", {})
    }).then(function () {
      return hexo.call("server", {
        port: 4040
      }).then(function () {
        _inited = true;
        callback();
      });
    }).catch(function (err) {
      hexo.exit();
      callback.fail(err);
    });
  });

  this.registerHandler("AfterFeatures", function (event, callback) {
    hexo.exit().then(callback);
  });
}
