-- ----------------------------------------------------------------------------
-- variables/constants
-- ----------------------------------------------------------------------------

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- ----------------------------------------------------------------------------
-- set keymaps
--
-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"
-- ----------------------------------------------------------------------------

--Remap "-" as leader key
keymap("", " ", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable arrow movement, resize splits instead.
keymap("n", "<Up>", ":resize +2<CR>", opts)
keymap("n", "<Down>", ":resize -2<CR>", opts)
keymap("n", "<Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<Right>", ":vertical resize +2<CR>", opts)

-- map sort function to a key
keymap("n", "<Leader>s", ":sort<CR>", opts)
keymap("n", "<Leader>sr", ":sort!<CR>", opts)
keymap("v", "<Leader>s", ":sort<CR>", opts)
keymap("v", "<Leader>sr", ":sort!<CR>", opts)

-- makes indenation of code blocks easier
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- turns off search highlight
keymap("n", "<Leader><space>", ":nohlsearch<cr>", opts)
keymap("v", "<Leader><space>", ":nohlsearch<cr>", opts)

-- save file on ctrl-s
keymap("n", "<C-s>", ":w<cr>", opts)
keymap("i", "<C-s>", "<ESC>:w<cr>i", opts)
keymap("v", "<C-s>", "<ESC>:w<cr>gv", opts)

-- center things like search results, etc.
keymap("n", "G", "Gzz", opts)
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "}", "}zz", opts)
keymap("n", "{", "{zz", opts)
keymap("n", "(", "(zz", opts)
keymap("n", ")", ")zz", opts)
keymap("n", "]s", "]szz", opts)
keymap("n", "[s", "[szz", opts)

-- easier moving between tabs
keymap("n", "<C-l>", ":bn<CR>", opts)
keymap("n", "<C-h>", ":bp<CR>", opts)

-- easier moving between splits
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- quit vim or close a buffer (without closing the window (tab), that's why the
-- second binding looks a little complicated.
keymap("n", "<C-c>", ":q<CR>", opts)
keymap("n", "<C-b>", ":bn<bar>sp<bar>bp<bar>bd<CR>", opts)
keymap("n", "<C-q>", "<C-w>c", opts)

-- inserts timestamps
keymap("n", "<Leader>td", "a<C-R>=strftime('%F')<CR><Esc>", opts)
keymap("n", "<Leader>tt", "a<C-R>=strftime('%T')<CR><Esc>", opts)
keymap("n", "<Leader>tdt", "a<C-R>=strftime('%FT%T%z')<CR><Esc>", opts)

keymap("i", "<Leader>td", "<C-R>=strftime('%F')<CR>", opts)
keymap("i", "<Leader>tt", "<C-R>=strftime('%T')<CR>", opts)
keymap("i", "<Leader>tdt", "<C-R>=strftime('%FT%T%z')<CR>", opts)

-- insert empty line without going into inser mode.
keymap("n", "<Leader>jj", "o<Esc>k", opts)
keymap("n", "<Leader>kk", "O<Esc>j", opts)

-- toggle spell check enable
keymap("n", "<Leader>sd", ":set spell spelllang=de_de<CR>", opts)
keymap("n", "<Leader>se", ":set spell spelllang=en_us<CR>", opts)
keymap("n", "<Leader>s<space>", ":set spell!<CR>", opts)

-- NERDTree
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

-- telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts) -- find files within current working directory, respects .gitignore
keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", opts) -- find string in current working directory as you type
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", opts) -- find string under cursor in current working directory
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts) -- list open buffers in current neovim instance
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts) -- list available help tags


-- TODO: Check which of the below mappings are still needed?
-- TODO: Sort this file a little bit.

-- " Moving between splits (and tmux)
-- if exists('$TMUX')
--     let g:tmux_navigator_no_mappings = 1
--     nnoremap <A-h> :TmuxNavigateLeft<cr>
--     nnoremap <A-j> :TmuxNavigateDown<cr>
--     nnoremap <A-k> :TmuxNavigateUp<cr>
--     nnoremap <A-l> :TmuxNavigateRight<cr>
-- else
--     nnoremap <A-h> <C-w>h
--     nnoremap <A-j> <C-w>j
--     nnoremap <A-k> <C-w>k
--     nnoremap <A-l> <C-w>l
-- endif
-- 
-- " Go to tags (e.g. function definitions)
-- nnoremap gt <C-]>
-- 
-- " Toggles the relative line numbering
-- nnoremap <Leader>n :call ToggleRelativenumber()<cr>
-- 
-- " Shows the syntax highlight gourp
-- nnoremap <C-i> :call CheckSyntaxHighlightGroup()<cr>
-- 
-- 
-- " majutsushi/tagbar
-- nnoremap <leader>tb :TagbarToggle<CR>
-- 
-- " easymotion
-- map <Leader>m <Plug>(easymotion-prefix)
-- nnoremap <Leader>mf <Plug>(easymotion-overwin-f)
-- xnoremap <Leader>mf <Plug>(easymotion-bd-f)
-- onoremap <Leader>mf <Plug>(easymotion-bd-f)
-- nnoremap <Leader>ml <Plug>(easymotion-overwin-line)
-- xnoremap <Leader>ml <Plug>(easymotion-bd-jk)
-- onoremap <Leader>ml <Plug>(easymotion-bd-jk)
-- nnoremap <Leader>mw <Plug>(easymotion-overwin-w)
-- xnoremap <Leader>mw <Plug>(easymotion-bd-w)
-- onoremap <Leader>mw <Plug>(easymotion-bd-w)
