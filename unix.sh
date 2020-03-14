#!/bin/sh
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.dein.toml ~/.dein.toml
# ln -sf ~/dotfiles/.screenrc ~/.screenrc
git config --global core.excludesfile ~/dotfiles/.gitignore_global
