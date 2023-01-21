# My Neovim Configuration

Instead of cramping my whole configuration into one single file (init.vim), I
use four different files:

- plugins.vim
- settings.vim
- functions.vim
- mappings.vim

They are located in the startup directory and sourced by init.vim in that
order.


# Plugins

For now I decided to use vim-plug to install plugins into Neovim. In order to
do so I had to install vim-plug first. This was done using the command:

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

After that all further plugins are installed in two steps:

1. First they are added in the plugins.vim file by adding a new line for every
   new plugin, e.g.:

   ```
   Plug 'preservim/nerdcommenter'
   ```

2. Acutally install and update them in Neovim by running the following commands
   in Neovim:

   ```
   :PlugInstall
   :PlugUpdate
   ```

