# bitbake.vim

Provides bitbake file detection + syntax highlighting and completion for
[completion-nvim][] / [coc.nvim][] / [deoplete.nvim][].

[[_TOC_]]

## Completion

The completion support is only rudimentary with tasks / variables / flags from
[yocto poky][] (thud 2.6.3).

## Assets

This section describes how the assets were gathered.

- **variables** come directly from the source code:

```sh
git clone --depth=1 --single-branch --branch <branch> https://git.yoctoproject.org/git/poky
cat poky/meta/conf/bitbake.conf | rg "[-a-zA-Z\${}_]+ [?+=]+" -o | rg "[-a-zA-Z\${}_]+" -o > variable_bitbake
```

- **variable flags** are manually copied from the bitbake user manual:

```
https://www.yoctoproject.org/docs/<version>/bitbake-user-manual/bitbake-user-manual.html#variable-flags
```

- **tasks** are manually copied from the chapter TOC and filtered in neovim:

```
https://www.yoctoproject.org/docs/<version>/mega-manual/mega-manual.html#ref-tasks
neovim -> :%s/.\{-}\(do_\w*\)/\1/g
neovim -> :sort
```

## Credits

Inspiration and regexes for the syntax file where found at
[bitbake/contrib/vim][].

## License

The project is licensed under the MIT license. See [LICENSE](LICENSE) for more
information.

[coc.nvim]: https://github.com/neoclide/coc.nvim
[deoplete.nvim]: https://github.com/Shougo/deoplete.nvim
[completion-nvim]: https://github.com/nvim-lua/completion-nvim
[yocto poky]: https://git.yoctoproject.org/cgit.cgi/poky/
[bitbake/contrib/vim]: https://github.com/openembedded/bitbake/tree/master/contrib/vim
