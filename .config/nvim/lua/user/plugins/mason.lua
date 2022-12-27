local mason_status, mason = pcall(require, "mason")
if not mason_status then
  vim.notify("Plugin 'mason' not found!")
  return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  vim.notify("Plugin 'mason-lspconfig' not found!")
  return
end

mason.setup()

mason_lspconfig.setup({
  -- list of servers for mason to install
  ensure_installed = {
    "ansiblels",
    "bashls",
    "clangd",
    "cmake",
-- Something is missing to install the neocmake language server. Run :Mason to
-- see the output when trying to install it manually.
--    "neocmake",
    "dockerls",
    "dotls",
    "golangci_lint_ls",
    "gopls",
    "html",
-- Something is missing to install the haskell language server. Run :Mason to
-- see the output when trying to install it manually.
--    "hls",
    "jsonls",
    "ltex",
    "sumneko_lua",
    "marksman",
    "pyright",
    "sqlls",
    "lemminx",
    "yamlls",
  },
  -- auto-install configured servers (with lspconfig)
  --automatic_installation = true, -- not the same as ensure_installed
})

