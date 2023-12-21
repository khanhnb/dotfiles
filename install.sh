#!/bin/bash

rm -rf ~/.config/nvim
rm -rf ~/.config/fish
rm -rf ~/.config/alacritty
rm -rf ~/.config/wezterm
rm ~/.tmux.conf
rm ~/.gitconfig
rm -rf ~/.config/yabai
rm -rf ~/.config/skhd
ln -s $(pwd)/nvim ~/.config/nvim
ln -s $(pwd)/fish ~/.config/fish
ln -s $(pwd)/alacritty ~/.config/alacritty
ln -s $(pwd)/wezterm ~/.config/wezterm
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/yabai ~/.config/yabai
ln -s $(pwd)/skhd ~/.config/skhd
ln -s $(pwd)/.gitconfig ~/.gitconfig
