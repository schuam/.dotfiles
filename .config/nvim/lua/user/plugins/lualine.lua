local status, lualine = pcall(require, "lualine")
if not status then
  vim.notify("Plugin 'lualine' not found!")
  return
end

lualine.setup()
