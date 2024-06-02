-- load nvim treesitter plugin
local nvim_treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not nvim_treesitter_status then
    return
end

-- configure treesitter
treesitter.setup({
    highlight = {
        enable = true,
    },
    -- enable indentation
    indent = {
        enable = true,
        disable = { "yaml", "markdown" }
    },
    ensure_installed = {
        "bash",
        "bibtex",
        "c",
        "cmake",
        "cpp",
        "css",
        "dot",
        "go",
        "html",
        "http",
        "json",
        "lua",
        "python",
        "query",
        "regex",
        "vim",
        "vimdoc",
        "yaml",
    },
    auto_install = true,
})
