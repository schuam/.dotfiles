# Konsole: Profile und Color Schemes

The KDE Konsole stores profiles and color schemes in the directory

    ~/.local/share/konsole/

I created a bunch of profiles that differ only in the color scheme they use.
The file in which the profiles is stored has the same name as the file in
which the corresponding color scheme is stored, except for a differen extention
('.profile' for the profile file and '.colorscheme' for the color scheme)

My profiles and color schemes are stored in

    ~/.dotfiles/konsole

I made a symbolic link to it using

    ln -svn ~/.dotfiles/konsole/ ~/.local/share/konsole/

