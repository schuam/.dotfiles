# My Bash Configuration

Instead of cramping my whole configuration into one single file (.bashrc), I use
three different files:

- settings
- aliases
- functions

They are located in '.bash/startup' and sourced by .bashrc in that order.


# TODOs

My bash configuration needs a little cleaning up.

- My environmental variables, which are set in the settings file at the moment
  should go into the .bash_profile file. That way they would only be set once
  (when the login shell is started).
- At the end of the settings file I commented out some lines that are supposed
  to start the X server automatically when I log in into tty1. This assumes that
  I use qtile as a window manager, which I don't do right now. First of all the
  why to figure out if qtile runs is not optimal as explained in
  https://mywiki.wooledge.org/ProcessManagement. I will most likely leave it
  like that anyways, because I assess the possible problems associated with it
  as minimal. But, in case I start using qtile again and/or I want to start the
  X server automatically when I log into tty1 this line should go into .bashrc
  itself or actually into .bash_profile (at the very end) to make sure the
  whole .bashrc is run before X is started. That isn't really necessary, but
  cleaner.

