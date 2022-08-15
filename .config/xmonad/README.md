# Xmonad

Since it took me quite a while to setup Xmonad, I want to at least document the
setup a little bit.

First of all, I set Xmonad up on an Arch Linux machine. I'm assuming this
should work on other distributions as well, but I'm not sure. And I don't know
anything about setting up Xmonad when the sytem runs any kind of desktop
environment (e.g. KDE).


## Installation

First I tried to just use Arch's xmonad package. Unfortunately (at least at the
time I did that) the version in Arch's repos was not the newest available
version of Xmonad, and while configuring it, I came across some problems that
were fixed in version 0.17.0. Therefore I built Xmonad myself. I did that for
the most part by following the instructions in [Xmaond's installation
guide](https://xmonad.org/INSTALL.html). But since I didn't want to pollute my
$HOME and my $HOME/.config directory more than necessary, I made some slight
changes to the guide.

As instructed I first installed necessary packages (well most if not all of
them were already on my system):

```bash
sudo pacman -S \
git \
xorg-server xorg-apps xorg-xinit xorg-xmessage \
libx11 libxft libxinerama libxrandr libxss \
pkgconf
```

Then I craeted the directory ~/.config/xmonad and some further directories that
are needed to keep Xmonad from placing a .xmonad directory directly into your
home directory.

```bash
mkdir -p $XDG_CONFIG_HOME/xmonad
mkdir -p $XDG_CACHE_HOME/xmonad
mkdir -p $XDG_DATA_HOME/xmonad
```

After that I cloned Xmonad's source code, but instead doing so into the
~/.config/xmonad direcetory, as the guide tells you to do, I clonde the source
code into /opt/xmonad/src.

```bash
mkdir -p /opt/xmonad/src
cd /opt/xmonad/src
git clone --branch v0.17.0 https://github.com/xmonad/xmonad
git clone --branch v0.17.0 https://github.com/xmonad/xmonad-contrib
```

To build Xmonad, I had to install **stack**:

```bash
sudo pacman -S stack
```

In order to keep stack from creating a .stack directory directly in my home
directory, I added the following line to my .bash_profile file:

```
export STACK_ROOT="$XDG_CACHE_HOME"/stack
```
In the [Arch Wiki](https://wiki.archlinux.org/title/XDG_Base_Directory) they
recomand to set the $STACK_ROOT variable to $XDG_DATA_HOME/stack, but I didn't
consider stacks data as that important.

Afterwards, within /opt/xmonad/src, I run:

```bash
stack init
```

Then I changed into Xmonad's configuration directory, created some symbolic
links, and build and installed Xmonad.

```bash
cd ~/.config/xmonad
ln -snv /opt/xomand/src/xmonad xmonad
ln -snv /opt/xomand/src/xmonad-contrib xmonad-contrib
ln -snv /opt/xomand/src/stack.yaml stack.yaml
stack install
```

Since this way, Xmonad is installed into ~/.local/bin, I added that directory
to my path by adding the following line in ~/.bash_profile:

```bash
export PATH="$PATH/$HOME/.local/bin"
```

And that was it. Well at least for the installation. Configuring was a whole
different story.

