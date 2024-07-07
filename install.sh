#! /usr/bin/bash


# -----------------------------------------------------------------------------
# make a backup directory
# -----------------------------------------------------------------------------

# Todays date as part of the backup directory name
date=`date +%Y-%m-%d`

backup_dir="$PWD/dotfiles_backup_$date"
mkdir -p $backup_dir


# -----------------------------------------------------------------------------
# bash
# -----------------------------------------------------------------------------

echo
echo "bash:"

for i in .bash_logout .bashrc .bash_profile .bash
do
    mv $HOME/$i $backup_dir
    ln -svn $PWD/bash/$i $HOME/$i
done;

mkdir -p $XDG_DATA_HOME/bash

source $HOME/.bash_profile


# -----------------------------------------------------------------------------
# .config
# -----------------------------------------------------------------------------

echo
echo ".config:"

# Make sure the XDG_CONFIG_HOME dir exists
mkdir -p $XDG_CONFIG_HOME

cd .config

for configuration in `find * -maxdepth 0`
do
    mv $HOME/.config/$configuration $backup_dir
    ln -svn $PWD/$configuration $XDG_CONFIG_HOME/$configuration
done

cd ..

# Create some special directories needed by vim
mkdir -p $XDG_DATA_HOME/vim/undo
mkdir -p $XDG_DATA_HOME/vim/swap
mkdir -p $XDG_DATA_HOME/vim/backup


# -----------------------------------------------------------------------------
# kde
# -----------------------------------------------------------------------------

echo
echo "WARNING: files in 'kde' are not linked or copied!"
echo "         Do that manually if needed!"
