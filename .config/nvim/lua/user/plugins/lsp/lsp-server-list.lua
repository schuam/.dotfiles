local M = {}

M.servers = {
  "ansiblels",
  "bashls",
  "clangd",
  "cmake",
  "dockerls",
  "dotls",
  "html",
  -- Try to install the haskell-language-server manually using :Mason
  -- and see the error massage. Something is missing to install it.
  -- "haskell-language-server",
  "jsonls",
  "ltex",
  "marksman",
  "pyright",
  "sqlls",
  "lemminx",
  "yamlls",
}

return M
