-- load lualine plugin
local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
  return
end

-- setup lualine plugin
lualine.setup()
