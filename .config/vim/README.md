# My Vim Configuration

Instead of cramping my whole configuration into one single file (.vimrc), I use
three different files:

- settings.vim
- functions.vim
- mappings.vim

They are located in '.vim/startup' and sourced by .vimrc in that order.


# Plugins

Since Vim8 it is possible to load plugins without a plugin manager or placing
the plugins in your .vimrc file. I make use of that new feature by placing
plugins I want to use into the directory '.vim/pack/vendor/start'. The 'vendor'
sub-directory is supposed to indicate that the plugins in that folder are not
written by me. I think I'll never write my own plugins, but who know. In case I
do at some point the plan in to place them into their own directory.

Since I use git to version my dotfiles, I decided to use git submodules to add
plugins. To add a new plugin, I just add a new submodule to the
'.vim/pack/vendor/start' directory. For example:

```
cd ~/.vim/pack/vendor/start/
git submodule add https://github.com/tpope/vim-surround.git
git commit -v
```

In case the plugin comes as a vimball, I download the vimball and open the
downloaded file in vim. Than in vim I run:

```
:UseVimball ~/.vim/pack/vendor/start/[NAME_OF_VIMBALL]
```

