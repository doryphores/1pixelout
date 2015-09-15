---
title: Git WIP aliases
date: 2015-09-15 13:39:56
tags: git
---

Just so I can stop looking up how to set these, here are my git command aliases:

```ini
[alias]
co = checkout
br = branch
ci = commit
st = status
unstage = reset HEAD --
fp = "!git fetch -p; git pull"
wip = "!git add --all; git ci -m WIP"
unwip = "!git reset --soft HEAD~1; git unstage"
```

`git wip` stages all current changes and commits them. Not sure why I prefer it to `git stash`.

`git unwip` obviously undoes a `git wip`.