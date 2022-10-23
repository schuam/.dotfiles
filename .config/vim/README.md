# My Vim Configuration

Instead of cramping my whole configuration into one single file (.vimrc), I use
four different files:

- settings.vim
- plugins.vim
- functions.vim
- mappings.vim

They are located in the startup directory and sourced by .vimrc in that order.


# Plugins

A while back I started to use NeoVim and to install plugins for NeoVim I use
[vim-plug[(https://github.com/junegunn/vim-plug). Now (2022-10-23) I decided to
do the same for regular vim. Even though I don't really use vim anymore on my
main machine. I might need it on some other machines. Also I was annoyed by the
big .dotfiles repo. Well not the actual repo was the problem, but all the
submodules inside, that I used for plugins in regular vim.. Now (2022-10-23) I
decided to do the same for regular vim. Even though I don't really use vim
anymore on my main machine. I might need it on some other machines. Also I was
annoyed by the big .dotfiles repo. Well not the actual repo was the problem,
but all the submodules inside, that I used for plugins in regular vim.

In case the plugin comes as a vimball, I download the vimball and open the
downloaded file in vim. Than in vim I run:

```
:UseVimball ~/.vim/pack/vendor/start/[NAME_OF_VIMBALL]
```

