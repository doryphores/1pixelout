---
title: Writing hexo template helpers
excerpt: How to define and include helpers with your Hexo theme
tags: hexo
date: 2015-09-18 14:31:32
---

Instead of including JavaScript in your hexo layout templates, it's better to move it to a collection of helpers that you can define in your theme's scripts.

A good example is the logic for setting the page title included in hexo's default **landscape** theme.

The following code is present at the top of the theme's `head.ejs` partial:

```javascript
var title = page.title;

if (is_archive()){
  title = 'Archives';

  if (is_month()){
    title += ': ' + page.year + '/' + page.month;
  } else if (is_year()){
    title += ': ' + page.year;
  }
} else if (is_category()){
  title = 'Category: ' + page.category;
} else if (is_tag()){
  title = 'Tag: ' + page.tag;
}
```

It feels wrong to me to include this in a template. A better solution is to register a `page_title` helper for the theme. For this, create a new file in the theme's `scripts` folder (the docs only mention the site top-level `scripts` folder but you can also place scripts in the theme's folder).

Here's how you register a new helper called `page_title`:

```javascript
hexo.extend.helper.register("page_title", function () {
  var title = this.page.title;

  if (this.is_archive()) {
    title = "Archives";

    if (this.is_month()) {
    title += ': ' + this.page.year + '/' + this.page.month;
    } else if (this.is_year()) {
      title += ": " + this.page.year;
    }
  } else if (this.is_category()) {
    title = "Category: " + this.page.category;
  } else if (this.is_tag()) {
    title = "Tag: " + this.page.tag;
  }

  return title;
});
```

As you can see, the `page` object as well as all the other standard hexo objects such as `config` and `site` are available through the `this` scope of the helper.

## Using the helper in a template

Now you can use the helper in your template:

```html
<head>
  <title><%= page_title() %></title>
</head>
```
