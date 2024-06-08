-- load lualine plugin
local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
    return
end

local colors = {
    light_bg         = 008,
    dark_red         = 001,
    dark_green       = 002,
    dark_yellow      = 003,
    dark_blue        = 004,
    dark_magenta     = 005,
    dark_cyan        = 006,
    fg               = 007,
    intense_light_bg = 019,
    light_red        = 009,
    light_green      = 010,
    light_yellow     = 011,
    light_blue       = 012,
    light_magenta    = 013,
    light_cyan       = 014,
    intense_fg       = 015
}

schuam_theme = {
    normal = {
        a = {bg = colors.fg, fg = colors.intense_light_bg, gui = 'bold'},
        b = {bg = colors.intense_light_bg, fg = colors.fg},
        c = {bg = colors.light_bg, fg = colors.fg}
    },
    insert = {
        a = {bg = colors.dark_cyan, fg = colors.intense_light_bg, gui = 'bold'},
        b = {bg = colors.intense_light_bg, fg = colors.fg},
        c = {bg = colors.light_bg, fg = colors.fg}
    },
    visual = {
        a = {bg = colors.dark_yellow, fg = colors.intense_light_bg, gui = 'bold'},
        b = {bg = colors.intense_light_bg, fg = colors.fg},
        c = {bg = colors.light_bg, fg = colors.fg}
    },
    replace = {
        a = {bg = colors.dark_magenta, fg = colors.intense_light_bg, gui = 'bold'},
        b = {bg = colors.intense_light_bg, fg = colors.fg},
        c = {bg = colors.light_bg, fg = colors.fg}
    },
    command = {
        a = {bg = colors.dark_green, fg = colors.intense_light_bg, gui = 'bold'},
        b = {bg = colors.intense_light_bg, fg = colors.fg},
        c = {bg = colors.light_bg, fg = colors.fg}
    },
    inactive = {
        a = {bg = colors.light_bg, fg = colors.fg, gui = 'bold'},
        b = {bg = colors.light_bg, fg = colors.fg},
        c = {bg = colors.light_bg, fg = colors.fg}
    }
}
-- setup lualine plugin
lualine.setup({
    options = {
        theme = schuam_theme
    },
    winbar = {
        lualine_a = {'buffers'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    inactive_winbar = {
        lualine_a = {'buffers'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
})

