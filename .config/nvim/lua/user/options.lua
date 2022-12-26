local options = {
    cursorline = true,         -- Highlights line the cursor is on
    cursorcolumn = true,       -- Highlights the column tht cursor is in
    colorcolumn = "80",        -- Highlights column 80
    showcmd = true,            -- Show commmands as they are typed
    ruler = true,              -- Enables the ruler in the lower right corner
    incsearch = true,          -- Shows next match while typing a search string
    hlsearch = true,           -- Highlights all search results
    number = true,             -- Shows current line number
    relativenumber = true,     -- Shows relative numbers
    mouse = "a",               -- Enables the use of the mouse to navigate
    clipboard = "unnamedplus", -- When text is yanked, put it in the unnamed
                               -- register, this way it can be copied into
                               -- other applications.
    splitbelow = true,         -- new splits below the current one
    splitright = true,         -- new splits to the right of the current one
    encoding = "utf-8",        -- the encoding displayed
    fileencoding = "utf-8",    -- the encoding written to file

    wrap = true,               -- Enables wrapping
    linebreak = true,          -- Makes sure that there is no linebreak within
                               -- a word
    textwidth = 79,            -- Hardwrap at 79 characters (80 will be the
                               -- linebreak)
    formatoptions = "tcr",     -- use :help fo-table to see options
    expandtab = true,          -- not \t as indentation
    shiftwidth = 4,            -- 4 spaces back/forth when pressine '<<', '>>',
                               -- or '=='
    tabstop = 4,               -- Tabstop width equals 4 spaces
    softtabstop = 4,           -- 4 four spaces instead of one <tab>
    autoindent = true,         -- copy indentation of previous line
    shiftround = true,         -- moves text to the next indentation level
    listchars = {tab = ">~", nbsp = "_", trail = "."},
    list = true,               -- highlight character in listchars
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- TODO: order the options a little bit
-- TODO: check if I need any of the following options from my old configuation:
--   - wildmenu
--   - laststatus
--   - nrformats
--   - wildmode
--   - spelllang
--   - omnifunc
