local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
    {
      "schuam/nvim-base16cterm",
      config = function()
        vim.cmd.colorscheme("base16-cterm")
      end,
    },
    {
      "nvim-lua/plenary.nvim",
      tag = "v0.1.0",
    },
    {
      "nvim-tree/nvim-web-devicons",
      tag = "v0.100",
    },
    {
      "nvim-orgmode/orgmode",
      commit = "4647d20",
      config = function()
        require("user/plugins/orgmode")
      end,
    },
    {
      "numToStr/Comment.nvim",
      tag = "v0.7.0",
      config = function()
        require("user/plugins/comment")
      end,
    },
    {
      "tpope/vim-surround",
      tag = "v2.2",
    },
    {
      "nvim-tree/nvim-tree.lua",
      tag = "nvim-tree-v1.3.3",
      config = function()
        require("user/plugins/nvim-tree")
      end,
    },
    {
      "phaazon/hop.nvim",
      tag = "v2.0.3",
      config = function()
        require("user/plugins/hop")
      end,
    },
    {
      "alexghergh/nvim-tmux-navigation",
      commit = "4898c98",
      config = function()
        require("user/plugins/nvim-tmux-navigation")
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      tag = "v0.9.2",
      config = function()
        require("user/plugins/nvim-treesitter")
      end,
    },
    {
      "L3MON4D3/LuaSnip",
      tag = "v1.1.0",
      config = function()
        require("user/plugins/luasnip")
      end,
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      commit = "9ef21b2",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      config = function()
        require("user/plugins/telescope")
      end,
    },
    {
      "saadparwaiz1/cmp_luasnip",
      commit = "05a9ab2",
    },
    {
      "rafamadriz/friendly-snippets",
      commit = "d061007",
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "LuaSnip" },
      tag = "v0.0.1",
      config = function()
        require("user/plugins/nvim-cmp")
      end,
    },
    {
      "hrsh7th/cmp-buffer",
      dependencies = { "nvim-cmp" },
      commit = "3022dbc",
    },
    {
      "hrsh7th/cmp-path",
      dependencies = { "nvim-cmp" },
      commit = "91ff86c",
    },
    {
      "hrsh7th/cmp-nvim-lsp",
      dependencies = { "nvim-cmp" },
      commit = "39e2eda",
    },
    {
      "windwp/nvim-autopairs",
      dependencies = { "nvim-cmp" },
      commit = "c15de7e",
      config = function()
        require("user/plugins/autopairs")
      end,
    },
    {
      "windwp/nvim-ts-autotag",
      commit = "6eb4120",
      dependencies = { "nvim-treesitter" },
    },
    {
      "neovim/nvim-lspconfig",
      tag = "v0.1.8",
      dependencies = { "cmp-nvim-lsp" },
      config = function()
        require("user/plugins/lsp/handlers").setup()
        require("user/plugins/lsp/lspconfig")
      end,
    },
    {
      "folke/trouble.nvim",
      tag = "v3.1.0",
      dependencies = { "nvim-treesitter" },
      config = function()
        require("user/plugins/trouble")
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      commit = "0a5a668",
      config = function()
        require("user/plugins/lualine")
      end,
    },
  },
  {
    ui = { border = "rounded" }
  }
)

