---
title: Setting up an "Electron" project with the babel compiler
excerpt: How to set up an "Electron" project with babel to use ES6/7 JavaScript syntax
tags:
  - Electron
  - ES6
---

This is an overview of how I set up a [Electron](http://electron.atom.io/) projects.

- [Babel](https://babeljs.io/) compiler so I can use ES6/7 and React JSX
- [Stylus](https://learnboost.github.io/stylus/) for compiling CSS (you can obviously use Less or Sass instead)
- [electron-rebuild](https://github.com/electronjs/electron-rebuild) to ensure native Node modules are compiled for the Electron runtime
- [electron-packager](https://github.com/electronjs/electron-rebuild) to package the app

```json
{
  "main": "index.js",
  "scripts": {
    "install-deps": "npm install && electron-rebuild",
    "start": "npm run build-css -- -m && npm run build-js -- -s && electron .",
    "package": "npm run build-css && npm run build-js && node scripts/package.js",
    "build-js": "mkdirp static/js && babel src --out-dir static/js --stage 0",
    "watch-js": "mkdirp static/js && babel src --out-dir static/js -w --stage 0 -s",
    "build-css": "mkdirp static/css && stylus stylus/app.styl -o static/css/ -c",
    "watch-css": "mkdirp static/css && stylus stylus/app.styl -o static/css/ -w -m",
    "watch": "npm run watch-css & npm run watch-js"
  },
}
```

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>My Electron app</title>
  </head>
  <body>
    <div id="app"></div>
    <script>
      require("./js/main")
    </script>
  </body>
</html>
```
