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

require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("user/plugins/nvim-treesitter")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        tag = "v0.0.1",
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
        "neovim/nvim-lspconfig",
        dependencies = { "cmp-nvim-lsp" },
        config = function()
            require("user/plugins/lsp/lspconfig")
        end,
    },
})

