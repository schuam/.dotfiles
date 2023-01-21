-- load nvim_tmux_nav plugin
local nvim_tmux_nav_status, nvim_tmux_nav = pcall(require, "nvim-tmux-navigation")
if not nvim_tmux_nav_status then
  return
end

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap('n', "<A-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, opts)
keymap('n', "<A-j>", nvim_tmux_nav.NvimTmuxNavigateDown, opts)
keymap('n', "<A-k>", nvim_tmux_nav.NvimTmuxNavigateUp, opts)
keymap('n', "<A-l>", nvim_tmux_nav.NvimTmuxNavigateRight, opts)
