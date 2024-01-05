# My dev configs

![nvim](nvim.png "nvim")

Install requirements:
```
brew tap homebrew/cask-fonts
brew install font-geist-mono-nerd-font font-jetbrains-mono-nerd-font font-fira-code-nerd-font
brew install neovim tmux fish starship zoxide koekeishiya/formulae/skhd koekeishiya/formulae/yabai fzf ripgrep wezterm
```

To disable desktop rearrangement:
```
defaults write com.apple.dock "mru-spaces" -bool "false" && killall Dock
```
To enable desktop rearrangement:
```
defaults write com.apple.dock "mru-spaces" -bool "true" && killall Dock
```

To disable Dock (delay 1000s):
```
defaults write com.apple.dock autohide-delay -float 1000; killall Dock
```
To restore default behavior:
```
defaults delete com.apple.dock autohide-delay; killall Dock
```
