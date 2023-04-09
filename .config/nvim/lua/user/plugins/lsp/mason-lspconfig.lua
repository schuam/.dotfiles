-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

mason_lspconfig.setup({
  -- list of servers for mason to install
  ensure_installed = require("user.plugins.lsp.lsp-server-list").servers
  -- auto-install configured servers (with lspconfig)
  --automatic_installation = true, -- not the same as ensure_installed
})

    -- "ansiblels",
    -- "bashls",
    -- "clangd",
    -- "cmake",
    -- "dockerls",
    -- "dotls",
    -- "html",
    -- -- Try to install the haskell-language-server manually using :Mason
    -- -- and see the error massage. Something is missing to install it.
    -- -- "haskell-language-server",
    -- "jsonls",
    -- "ltex",
    -- "marksman",
    -- "pyright",
    -- "sqlls",
    -- "lemminx",
    -- "yamlls",
