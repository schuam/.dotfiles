-- load plugin
local hop_status, hop = pcall(require, "hop")
if not hop_status then
  return
end

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local directions = require('hop.hint').HintDirection

keymap(
  '',
  '<Leader>ml',
  function()
    hop.hint_lines({ multi_windows = true })
  end,
  opts
)
keymap(
  '',
  '<Leader>mw',
  function()
    hop.hint_words({ multi_windows = true })
  end,
  opts
)
