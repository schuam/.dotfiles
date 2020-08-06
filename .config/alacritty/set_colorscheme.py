#!/usr/bin/env python

import os
import glob


config_dir = os.path.realpath(os.path.expanduser("~/.config/alacritty/"))
config_file_name = "alacritty.yml"
config_base_file_name = "base_config.yml"

colorscheme_file_name_template = "colorscheme_*.yml"
colorscheme_path_template = os.path.join(
    config_dir, colorscheme_file_name_template)

current_colorscheme_info_file_name = "current_colorscheme.txt"
current_colorscheme_info_file_path = os.path.join(
    config_dir, current_colorscheme_info_file_name)

colorscheme_file_names = \
    sorted([os.path.basename(x) for x in glob.glob(colorscheme_path_template)])

current_colorscheme = None
if os.path.exists(current_colorscheme_info_file_path):
    with open(current_colorscheme_info_file_path, "r") as f:
        current_colorscheme = f.read().strip()

if len(colorscheme_file_names) != 0:
    next_colorscheme = colorscheme_file_names[0]
    if current_colorscheme in colorscheme_file_names:
        index = colorscheme_file_names.index(current_colorscheme)
        next_colorscheme = colorscheme_file_names[(index + 1) %
                len(colorscheme_file_names)]
    else:
        pass

    config_file_path = os.path.join(config_dir, config_file_name)
    base_file_path = os.path.join(config_dir, config_base_file_name)
    color_file_path = os.path.join(config_dir, next_colorscheme)

    print(next_colorscheme)
    with open(config_file_path, "w") as out, \
            open(base_file_path, "r") as base, \
            open(color_file_path, "r") as color, \
            open(current_colorscheme_info_file_path, "w") as cur:
        out.write(base.read())
        out.write(color.read())
        cur.write(next_colorscheme)

else:
    pass

