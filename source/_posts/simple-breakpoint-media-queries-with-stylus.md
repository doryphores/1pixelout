---
title: Simple breakpoint media queries with Stylus
excerpt: Responsive CSS made easy with Stylus. How to define breakpoint media queries and use a block mixin to target specific breakpoints in your CSS.
tags:
  - Stylus
  - CSS
date: 2015-10-02 14:11:41
---

One of the first things I do when I start a new CSS project, is define a helper for simplifying media queries. For example, with SASS, I like to be able to do something like this:

```scss
.site-wrapper {
  max-width: 800px;
  margin: 0 auto;

  @include for_breakpoint(tablet mobile) {
    margin: 0 10px;
  }
}
```

The `for_breakpoint` mixin would wrap its contents in a media query built from previously defined breakpoints.

I needed to do this in Stylus for this site. Here's how I went about it:

First, I define the breakpoint media queries as a [hash](https://learnboost.github.io/stylus/docs/hashes.html):

```stylus
media_queries = {
  mobile  : "only screen and (max-width: 600px)",
  tablet  : "only screen and (min-width: 601px) and (max-width: 800px)",
  desktop : "only screen and (min-width: 801px)"
}
```

Now, I define a [mixin](https://learnboost.github.io/stylus/docs/mixins.html) that takes a list of breakpoints and wraps its contents in a targeted media query:

```stylus
for_breakpoint(breakpoints)
  conditions = ()
  for breakpoint in breakpoints
    push(conditions, media_queries[breakpoint])
  conditions = join(", ", conditions)
  @media conditions
    {block}
```

**Important note**: commas between media query conditions act as an `or`. I always forget this.

Now we can do this for example:

```stylus
+for_breakpoint(mobile)
  .hide-for-mobile
    display none
```

**Note**: the `+` is necessary when calling [block mixins](https://learnboost.github.io/stylus/docs/mixins.html#block-mixins).

When compiled, the CSS will look like this:

```css
@media only screen and (max-width: 600px) {
  .hide-for-mobile {
    display: none;
  }
}
```

But we can also specify multiple breakpoints:

```stylus
.sidebar
  width 200px

  +for_breakpoint(mobile tablet)
    display none
```

The above would compile to:

```css
.sidebar {
  width: 200px;
}

@media only screen and (max-width: 600px), only screen and (min-width: 601px) and (max-width: 800px) {
  .sidebar {
    display: none;
  }
}
```
