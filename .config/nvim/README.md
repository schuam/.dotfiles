# My Neovim Configuration

As it seems that configuring Neovim entirely with Lua becomes more and more
pupulare, I decided to give it a try myself. Now, everyting is configured in
Lua except the definition of my own colorscheme. I was to lazy to port that to
Lua was well.

In order to configure Neovim, I set up the following directory structure:

```
$XDG_CONFIG_HOME/nvim/
├── init.lua
├── README.md
├── colors
│   └── schuam.vim
└── lua
    └── user
        ├── plugins-setup.lua
        ├── core
        │   ├── colorscheme.lua
        │   ├── keymaps.lua
        │   └── options.lua
        └── plugins
            ├── <PLUGIN-1>.lua
            ├── <PLUGIN-2>.lua
            └── ...
```

The `init.lua` file serves as the **entry point** for my configuration. I
doesn't really do anything itself, it just loads (`require`) all the necessary
configuration files.

The `colors` directory contains just one file - my own colorscheme.

The `lua` directory contains the actual configuration files. To prevent any
clashes that might happen due to name confilicts with internal Neovim files,
there is a sub-directory called `user` wihtin the `lua` directory. The `user`
directory contains one file `plugins-setup.lua` that sets up all plugins (with
the plugin manager `packer`), and two further sub-directories (`core` and
`plugins`).

The `core` directory contains some configuration files to configure Neovim
itself, the `plugins` directory contains files to configure my plugins.


# Plugins

To load and configure my plugins, I use `packer`. The entry point for packer is
the file `lua/user/plugin-setup.lua`. All plugins that I want to use are lised
in the `setup()` function of `packer` at the end of the mentioned configuration
file.

For some plugins it is enough to just list them in the
`lua/user/plugins-setup.lua` file to use them. Otehr need some configuration.
For every plugin that I needed/wanted to configure, I put an extra
configuration file into the `lua/user/plugins/` directory. These files are
named after the coresponding plugin and the files are loaded from `init.lua`.

