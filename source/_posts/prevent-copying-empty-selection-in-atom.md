---
title: Prevent copying empty selections in Atom
date: 2015-09-14 21:29:06
excerpt: How to prevent copying an empty selection in Atom
tags: atom
---

I really can't do with an editor that clears my clipboard when I accidently copy an empty line.

This is an easy mistake to make:

- cut something with `Cmd+X`
- move the cursor to an empty line where I want to paste
- accidently hit `Cmd+C` instead of `Cmd+V`
- Boom! I have now lost my clipboard contents

Sublime Text had an option to disable copying empty selections but Atom doesn't. Fortunately, it's super easy to hack Atom and someone has figured out how to prevent this. I'm pasting it here so I can easily find it.

This is [the original post](https://discuss.atom.io/t/resolved-avoid-copying-when-selection-is-empty/16397/4) on the Atom forum and here's the snippet to paste in your Atom init script.

```coffeescript
# prevent core:copy if and only if there's one selection in
# the active editor (mini or not) and its length equals 0
atom.commands.add 'atom-text-editor', 'core:copy', (e) ->
  editor = e.currentTarget.getModel()

  # do nothing if there's more than 1 selection
  return if editor.getSelectedBufferRanges().length > 1

  # get the starting and ending points of the selection
  {start, end} = editor.getSelectedBufferRange()

  # stop the command from immediate propagation (i.e.
  # executing the same command on the same element or
  # an element higher up the DOM tree). This works
  # because atom executes commands in the reverse order
  # they were registered with atom.commands.add, and this
  # one's added after the core commands are already
  # registered.
  if start.column is end.column and start.row is end.row
    e.stopImmediatePropagation()
```
