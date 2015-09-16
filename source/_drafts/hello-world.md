---
title: Hello World
---

This note demonstrates some of what [Markdown][1] is capable of doing.

*Note: Feel free to play with this page. Unlike regular notes, this doesn't automatically save itself.*

## Basic formatting

Paragraphs can be written like so. A paragraph is the basic block of Markdown. A paragraph is what text will turn into when there is no reason it should become anything else.

Paragraphs must be separated by a blank line. Basic formatting of *italics* and **bold** is supported. This *can be **nested** like* so.

## Lists

### Ordered list

1. Item 1
2. A second item
3. Number 3

### Unordered list

* An item
* Another item
* Yet another item
* And there's more...

## Paragraph modifiers

### Simple code block

    $ npm install package

### Fenced code block with syntax highlighting

```javascript
export default function initWindow() {
  const win = remote.getCurrentWindow()
  const dims = LocalStorageManager.get("windowDimensions")

  const saveDims = _.debounce(() => {
    LocalStorageManager.set("windowDimensions", {
      bounds    : win.getBounds(),
      maximized : win.isMaximized()
    })
  }, 100);

  ["move", "resize"].forEach((event) => {
    win.removeAllListeners(event)
    win.on(event, saveDims)
  })

  if (dims) {
    win.setBounds(dims.bounds)
    win.show()

    // Maximizing on OSX is a bit odd
    if (process.platform != "darwin" && dims.maximized) {
      win.maximize()
    }
  } else {
    win.show()
  }
}
```

You can also make `inline code` to add code into other things.

### Quote

> Here is a quote. What this is should be self explanatory. Quotes are automatically indented when they are used.

## Headings

There are six levels of headings. They correspond with the six levels of HTML headings. You've probably noticed them already in the page. Each level down uses one more hash character.

### Headings *can* also contain **formatting**

### They can even contain `inline code`

Of course, demonstrating what headings look like messes up the structure of the page.

I don't recommend using more than three or four levels of headings here, because, when you're smallest heading isn't too small, and you're largest heading isn't too big, and you want each size up to look noticeably larger and more important, there there are only so many sizes that you can use.

## URLs

URLs can be made in a handful of ways:

* A named link to [MarkItDown][3]. The easiest way to do these is to select what you want to make a link and hit `Ctrl+L`.
* Another named link to [MarkItDown](http://www.markitdown.net/)
* Sometimes you just want a URL like <http://www.markitdown.net/>.

## Horizontal rule

A horizontal rule is a line that goes across the middle of the page.

---

It's sometimes handy for breaking things up.

## Images

Markdown can also contain images. I'll need to add something here sometime.

## Finally

There's actually a lot more to Markdown than this. See the official [introduction][4] and [syntax][5] for more information. However, be aware that this is not using the official implementation, and this might work subtly differently in some of the little things.


  [1]: http://daringfireball.net/projects/markdown/
  [2]: http://www.fileformat.info/info/unicode/char/2163/index.htm
  [3]: http://www.markitdown.net/
  [4]: http://daringfireball.net/projects/markdown/basics
  [5]: http://daringfireball.net/projects/markdown/syntax
