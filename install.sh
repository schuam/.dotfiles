#! /bin/bash


# -----------------------------------------------------------------------------
# make a backup directory
# -----------------------------------------------------------------------------

# Todays date as part of the backup directory name
date=`date +%Y-%m-%d`

# Create backup directory
backup_dir="$PWD/dotfiles_backup_$date"
mkdir $backup_dir


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
source $HOME/.bash_profile


# -----------------------------------------------------------------------------
# .config
# -----------------------------------------------------------------------------

echo ".config"
cd .config
for configuration in `find * -maxdepth 0 ! -iname xdg-user-dirs ! -iname plasma-localerc`
do
    echo "    $configuration"
    mv $HOME/.config/$configuration $backup_configuration
    ln -svn $PWD/$configuration $XDG_CONFIG_HOME/$configuration
done
cd ..
echo "WARNING: xdg-user-dirs was ignored!"
echo "WARNING: plasma-localerc was ignored!"


# -----------------------------------------------------------------------------
# etc
# -----------------------------------------------------------------------------

echo "WARNING: files in 'etc' are not linked or copied!"
echo "         Do that manually if needed!"


# -----------------------------------------------------------------------------
# kde
# -----------------------------------------------------------------------------

echo "WARNING: files in 'kde' are not linked or copied!"
echo "         Do that manually if needed!"

