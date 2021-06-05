# ConjureMacroexpand

Adds commands `ConjureMacroexpand`, `ConjureMacroexpand0` and
`ConjureMacroexpand1` that will macro-expand the form under the cursor, using
[Conjure](https://github.com/Olical/conjure)'s REPL connection.

This is the one bit of functionality missing from Conjure that kept
[vim-fireplace](https://github.com/tpope/vim-fireplace/) in my Neovim config.

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug):

```viml
Plug 'walterl/conjure-macroexpand'
```

## Mappings

* `<LocalLeader>cm` - Calls `clojure.walk/macroexpand-all` on the form under the cursor.
* `<LocalLeader>c0` - Calls `clojure.core/macroexpand` on the form under the cursor.
* `<LocalLeader>c1` - Calls `clojure.core/macroexpand-1` on the form under the cursor.

## Configuration

Disable mappings:

```viml
set g:conjure_macroexpand_disable_mappings = 1
```

## Unlicenced (just like Conjure)

Find the full [unlicense](http://unlicense.org/) in the `UNLICENSE` file, but here's a snippet.

> This is free and unencumbered software released into the public domain.
>
> Anyone is free to copy, modify, publish, use, compile, sell, or distribute this software, either in source code form or as a compiled binary, for any purpose, commercial or non-commercial, and by any means.
