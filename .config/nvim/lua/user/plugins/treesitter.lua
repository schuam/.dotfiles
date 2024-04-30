-- load nvim treesitter plugin
local nvim_treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not nvim_treesitter_status then
  return
end

-- configure treesitter
treesitter.setup({
  highlight = {
    enable = true,
    disable = { 'org', 'gitcommit' },
    additional_vim_regex_highlighting = { 'org', 'markdown' },
  },
  -- enable indentation
  indent = {
    enable = true,
    disable = { 'yaml', 'markdown' }
  },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  ensure_installed = {
    'bash',
    'bibtex',
    'c',
    'cmake',
    'cpp',
    'css',
    'dot',
    'go',
    'html',
    'http',
    'json',
    'latex',
    'lua',
    'python',
    'regex',
    'vim',
    'yaml',
  },
  auto_install = true,
})
