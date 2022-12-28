-- load nvim-tree plugin
local nvim_tree_status, nvimtree = pcall(require, "nvim-tree")
if not nvim_tree_status then
  return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- configure nvim-tree
nvimtree.setup({
  on_attach = on_attach,
  remove_keymaps = ({"-"}),
  -- disable window_picker for
  -- explorer to work well with
  -- window splits
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  git = {
      ignore = false,
  },
})
