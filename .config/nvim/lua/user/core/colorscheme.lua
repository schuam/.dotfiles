-- set the colorscheme
local colorscheme = "schuam"
local colorscheme_status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not colorscheme_status then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

