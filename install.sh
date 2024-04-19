#!/bin/bash

if test ! $(which brew); then
  echo "Installing homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

for i in $(cat ./osx/brewtap.txt)
do
  echo "Tapping $i"
  brew tap "$i"
done

for i in $(cat ./osx/brewleaves.txt)
do
  echo "Installing $i"
  brew install "$i"
done

# configure osx
# ./osx/osx.sh
