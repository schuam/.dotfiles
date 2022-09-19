# Color Scheme

I work quite a bit in the terminal and therefore like the color scheme to be
easy on the eyes. My preferred color scheme is my own variation of the famous
solarized color scheme (the dark version). While this works great a lot of the
time, when the sun shines outside it's sometimes difficult to read the terminal
with this color scheme (especially because I don't like shutting the window
shades until it's dark in my room. Therefore I needed an easy way to quickly
change the color scheme of Alacritty. Opening and editing the config file
seemed to be to difficult. Having a key binding to do that would be nice. So I
figured out a way to do it. The next section briefly describe my solution.


## alacritty.yml

First of all I put all the color schemes I want to be able to switch between
into Alacritty's config file (alacritty.yml). All color schemes have to be
within the **schemes** section of the config file and look something like this
(by the way, in case you're wondering, the example below is not my version of
the solarized color scheme):

```yaml
schemes:
  schuam_dark: &schuam_dark
    primary:
      background: '#000000'
      foreground: '#aaaaaa'
    normal:
      black:   '#262626'
      red:     '#cc0000'
      green:   '#00a100'
      yellow:  '#a6a600'
      blue:    '#006cd8'
      magenta: '#ff00ff'
      cyan:    '#00a1a1'
      white:   '#aaaaaa'
    bright:
      black:   '#626262'
      red:     '#ff4400'
      green:   '#00ff00'
      yellow:  '#ffff00'
      blue:    '#0080ff'
      magenta: '#ff55ff'
      cyan:    '#00eaea'
      white:   '#dedede'

```

For the rest of the setup it's important to name the anchor of each color
scheme exactly the same as the name of the color scheme itself. In the example
above:

```yaml
  schuam_dark: &schuam_dark
```

Than underneath all the color schemes there is a line in the config file that
determines with scheme is in use. For example:

```yaml
colors: *schuam_dark
```


## Python Script

Then I wrote a short python script ([set_colorscheme.py](set_colorscheme.py)).
This script parses the configuration file, looks for all available color
schemes, checks which one is currently set, and than replaces the current color
scheme with the next available one.

In order for it to work the Python's **pyyaml** package must be installed on
the system. When I wrote the script I had Python 3.8.5 installed on my machine.
I haven't tested is with any other version, but it should pretty much work with
any other version of python (a least any other Python 3 version).

Additionally the script has to be executable by the user, and reachable from
the user's PATH. Since I wanted to keep the script in Alacritty's config
directory, I placed a link in a directory that is in my PATH where I keep other
executable scripts as well.


## Key Binding

Finally I put the following line into the key_bindings section of Alacritty's
config file:

```yaml
key_bindings:
  - { key: F, mods: Control, command: {program: "set_colorscheme"} }
```

Now I'm able to circle through my color schemes by pressing \<Ctrl-F\>.

