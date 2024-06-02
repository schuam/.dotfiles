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

keymap("n", "<Leader>td", "<cmd>Trouble diagnostics toggle<cr>", opts)
keymap("n", "<Leader>ts", "<cmd>Trouble symbols toggle<cr>", opts)
keymap("n", "<Leader>tl", "<cmd>Trouble loclist toggle<cr>", opts)
keymap("n", "<Leader>tq", "<cmd>Trouble quickfix toggle<cr>", opts)

