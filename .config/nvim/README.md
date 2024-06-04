# My Neovim Configuration

As it seems that configuring Neovim entirely with Lua becomes more and more
pupulare, I decided to give it a try myself. Now, everyting is configured in
Lua except the definition of my own colorscheme. I was to lazy to port that to
Lua was well.

In order to configure Neovim, I set up the following directory structure:

```
$XDG_CONFIG_HOME/nvim/
├── colors
│   └── schuam.vim
├── ftplugin
│   ├── bash.lua
│   ├── c.lua
│   ├── html.lua
│   ├── json.lua
│   ├── lua.lua
│   ├── mail.lua
│   ├── python.lua
│   ├── sh.lua
│   ├── tex.lua
│   └── yaml.lua
├── lua
│   └── user
│       ├── core
│       │   ├── colorscheme.lua
│       │   ├── keymaps.lua
│       │   └── options.lua
│       └── plugins
│           ├── lsp
│           │   ├── ls-settings
│           │   │   ├── ltex.lua
│           │   │   └── yamlls.lua
│           │   ├── schemas
│           │   │   ├── ansible.json
│           │   │   └── README.md
│           │   ├── handlers.lua
│           │   ├── lspconfig.lua
│           │   └── lsp-server-list.lua
│           ├── <plugin_1>.lua
│           ├── <plugin_2>.lua
│           ├── ...
│           ├── plugins.lua
│           └── ...
├── init.lua
└── README.md
```

The `init.lua` file serves as the **entry point** for my configuration. It
doesn't really do anything itself, it just loads (`require`) all the necessary
configuration files.

The `colors` directory contains just one file - my own colorscheme.

The `lua` directory contains the actual configuration files. To prevent any
clashes that might happen due to name conflicts with internal Neovim files,
there is a sub-directory called `user` within the `lua` directory.

The `core` directory contains some configuration files to configure Neovim
itself, the `plugins` directory contains files to configure my plugins.

# Plugins

To load and configure my plugins, I use `lazy`. The entry point for `lazy` is
the file `lua/user/plugins/plugins.lua`. All plugins that I want to use are
listed in the `setup()` function of `lazy`. `lazy` also loads ("requires")
configuration files for plugins where it is necessary. I realized that, by
requiring the necessary file in the config function.


# Language Servers

Earlier I used `Mason` to install/configure language servers. But since
language servers might be useful for other applications as well, I decided to
install language servers on my system and let the plugin `lspconfig` configure
them.

