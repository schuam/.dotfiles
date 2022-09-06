# My Dotfiles

This repository contains my personal dotfiles.

Whenever possible, I try to organize my configuration files according to the
[XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
Which means that for example the configuration files (dotfiles) for program
"XYZ" are placed in the directory $XDG_CONFIG_HOME/XYZ/. A lot of programs
follow this convention and expect their configuration files at that location.
Some programs don't follow this convention natively, but make it possible to
use it by letting the user set certain environment variables. In such cases, I
set these variables in my .bash_profile file. And than there are programs where
it's just not possible to place the dotfiles into a directory under
$XDG_CONFIG_HOME. For most of these programs, I don't organize their
configuration in my dotfiles repository, with just one exception **bash** (Why
bash? Why?).

Anyways, for the most part, the structure of my dotfiles repository looks like
this:

```
.dotfiles
└── .config
    ├── <PROGRAM_1>
    └── <PROGRAM_2>
```

**bash** has its configuration files in a separate directory in the root
directory of this repository.

Anyway, feel free to use any of my dotfiles for your own setup. I just
recommend to look through any of the files that you want to use to make sure
they match your needs.

To install the dotfiles on your machine you have multiple option:

- Manually copy the files you want to use into the right location on your
  machine.
- Manually create links to the files you want to use in the right location on
  your machine.
- Use the **install.sh** script in the repository. It basically does the
  linking for you for all configuration files in the repository. **WARNING**:
  Before you run the script, read it, understand what it does, and make sure
  you want it to do what it does.
- If you use **Ansible** for your computer setup, you can use my
  [ansible role](https://github.com/schuam/ansible_role_dotfiles) for setting
  up my dotfiles.

If you clone my dotfiles repository to your machine and than create links to
them on your machine, be aware of the fact that any changes you pull from my
repository will take immediate effect on your system whether you like it or
not. In that setup, I strongly recommend to fetch changes first, check out the
differences, and only than merge possible changes.
