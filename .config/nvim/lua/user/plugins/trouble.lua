-- load nvim trouble plugin
local nvim_trouble_status, trouble = pcall(require, "trouble")
if not nvim_trouble_status then
  return
end

trouble.setup({
    mode = "document_diagnostics",
    auto_preview = false,
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<Leader>t<Space>", "<cmd>TroubleToggle<cr>", opts)
keymap("n", "<Leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
keymap("n", "<Leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
keymap("n", "<Leader>tl", "<cmd>TroubleToggle loclist<cr>", opts)
keymap("n", "<Leader>tq", "<cmd>TroubleToggle quickfix<cr>", opts)
keymap("n", "<Leader>tR", "<cmd>TroubleToggle lsp_references<cr>", opts)
