# Color Theme

I work quite a bit in the terminal and therefore like the color scheme to be
easy on the eyes. My preferred color scheme is my own variation of the famous
solarized color scheme (the dark version). While this works great a lot of the
time, when the sun shines outside it's sometimes difficult to read the terminal
with this color scheme (especially because I don't like shutting the window
shades until it's dark in my room. Therefore I needed an easy way to quickly
change the color scheme of Alacritty. Opening and editing the config file
seemed to be to difficult. Having a key binding to do that would be nice. So I
figured out a way to do it. The next section briefly describe my solution.


## Color Theme Files

First of all I created a directory $XDG_CONFIG_HOME/alacritty/themes/. Within
that directory I placed a sub-directory `schuam_themes` that contains my own
color themes. In case I will use other color themes in the futur (e.g. from
https://github.com/alacritty/alacritty-theme), I would put them into separate
sub-directories.

I color theme file looks like the following (the example is my schuam_dark
theme):

```toml
# Colors (my dark color scheme)

# Default colors
[colors.primary]
background = "#000000"
foreground = "#aaaaaa"

# Normal colors
[colors.normal]
black   = "#262626"
blue    = "#006cd8"
cyan    = "#00a1a1"
green   = "#00a100"
magenta = "#ff00ff"
red     = "#cc0000"
white   = "#aaaaaa"
yellow  = "#a6a600"

# Bright colors
[colors.bright]
black   = "#626262"
blue    = "#0080ff"
cyan    = "#00eaea"
green   = "#00ff00"
magenta = "#ff55ff"
red     = "#ff4400"
white   = "#dedede"
yellow  = "#ffff00"
```

Once all theme files were in place, I created symbolic links to the once I want
to be able to cicly through in $XDG_CONFIG_HOME/alacritty/themes/. So the
content of the $XDG_CONFIG_HOME/alacritty/themes directory looks like this:

```bash
themes/
├── schuam_dark.toml -> schuam_themes/schuam_dark.toml
├── schuam_solarized_dark.toml -> schuam_themes/schuam_solarized_dark.toml
├── schuam_solarized_light.toml -> schuam_themes/schuam_solarized_light.toml
└── schuam_themes
    ├── schuam_dark.toml
    ├── schuam_solarized_dark.toml
    └── schuam_solarized_light.toml
```

The final step of the setup, was to add the following to my alacritty.toml
file:

```toml
import = [
    "/home/andreas/.config/alacritty/themes/schuam_solarized_dark.toml",    # COLOR_THEME
]
```

The comment `# COLOR_THEME` is important, as it is used by the script that
cycles through the color themes. The script is descrbed in the next section.


## Color Theme Script

I wrote a script called `set_color_theme.sh` that does the following:

- It gets a sorted list of files and links that are in
  $XDG_CONFIG_HOME/alacritty/themes/.
- It looks for the line containing `# COLOR_THEME` in
  $XDG_CONFIG_HOME/alacritty/alacritty.toml.
- It checks if the currently configured color theme is in the list from the
  first bullet point.
  - If so, it replaces the path of the currently configured color theme with
    the path of the next color theme in the list.
  - If not, it places the path of the first color theme from the list into the
    configuration line.

Afterwards I made the script executable and placed it in a directory that is
part of my $PATH.


## Key Binding

Finally I put the following lines into the
$XDG_CONFIG_HOME/alacritty/alacritty.toml configuration file:

```toml
[[keyboard.bindings]]
key = "F"
mods = "Control|Shift"

[keyboard.bindings.command]
program = "set_color_theme"
```

Well actully `alacritty migrate` did that, when I switched from the
configuration file alacritty.yml to alacritty.toml.

Now I'm able to circle through my color schemes by pressing \<Ctrl-Shift-F\>.

