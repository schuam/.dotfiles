local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth', '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local packer_status, packer = pcall(require, "packer")
if not packer_status then
  return
end

return require('packer').startup(function(use)
  use("wbthomason/packer.nvim")       -- Have packer manage itself.
  -- My plugins here
  -- lua functions that many plugins use
  use({ "nvim-lua/plenary.nvim", tag = "v0.1.0"})
  use("nvim-tree/nvim-web-devicons")

  -- some essentaial plugins
  use({ "numToStr/Comment.nvim", tag = "v0.7.0" })
  use("tpope/vim-surround")
  use("nvim-tree/nvim-tree.lua")      -- file explorer
  use({ 
    "phaazon/hop.nvim",
    tag = "v2.0.3",
    config = function()
      require'hop'.setup {}
    end
  })
  use { "alexghergh/nvim-tmux-navigation" }

  -- statusline
  use("nvim-lualine/lualine.nvim")

  -- autocompletion
  use({ "hrsh7th/nvim-cmp", tag = "v0.0.1" })    -- completion plugin
  use("hrsh7th/cmp-buffer")           -- source for text in buffer
  use("hrsh7th/cmp-path")             -- source for file system paths

  -- snippets
  use({ "L3MON4D3/LuaSnip", tag = "v1.1.0" })    -- snippet engine
  use("saadparwaiz1/cmp_luasnip")     -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets

  -- fuzzy finding w/ telescope
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

-- treesitter configuration
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- managing, installing and configuring lsp servers, linters & formatters
  use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
  use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
  use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
  use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
  use("neovim/nvim-lspconfig") -- easily configure language servers

  -- auto closing
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
