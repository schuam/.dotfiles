local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  vim.notify("Plugin 'treesitter' not found!")
  return
end

-- configure treesitter
treesitter.setup({
  highlight = {
    enable = true,
    disable = { 'org' },
    additional_vim_regex_highlighting = { 'org' },
  },
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
