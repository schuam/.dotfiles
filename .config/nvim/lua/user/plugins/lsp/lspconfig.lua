-- load lspconfig plugin
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

-- load cmp_nvim_lsp plugin
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local server_list = require("user.plugins.lsp.lsp-server-list").servers

-- enable keybinds only for when lsp server available
local keymap = vim.keymap
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

for _, server in ipairs(server_list) do
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach,
  }

  local require_ok, conf_opts = pcall(require, "user.plugins.lsp.ls-settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end

-- -- configure ansiblels server
-- lspconfig["ansiblels"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure bashls server
-- lspconfig["bashls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure clangd server
-- lspconfig["clangd"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure dockerls server
-- lspconfig["dockerls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure dotls server
-- lspconfig["dotls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure gopls server
-- lspconfig["gopls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure html server
-- lspconfig["html"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure jsonls server
-- lspconfig["jsonls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure ltex server
-- lspconfig["ltex"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { 'tex', 'bib' },
-- })
--
-- -- configure marksman server
-- lspconfig["marksman"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure pyright server
-- lspconfig["pyright"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure sqlls server
-- lspconfig["sqlls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure lemminx server
-- lspconfig["lemminx"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure yamlls server
-- lspconfig["yamlls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
