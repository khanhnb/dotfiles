#! /bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap jason0x43/homebrew-neovim-nightly
brew reinstall neovim-nightly
brew install --cask iterm2
brew install fish tmux jq openvpn
