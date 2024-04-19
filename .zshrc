# export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim
# Set the shell to zsh
export SHELL=/bin/zsh

# zsh plugins
# plugins=(git)
# ZSH_THEME="robbyrussell"
# source $ZSH/oh-my-zsh.sh
source $HOME/.config/antigen/antigen.zsh

antigen bundle 'zsh-users/zsh-syntax-highlighting'
antigen bundle 'zsh-users/zsh-autosuggestions'
antigen bundle 'agkozak/zsh-z'
antigen bundle 'jeffreytse/zsh-vi-mode'
antigen apply

# use block cursor
ZVM_CURSOR_STYLE_ENABLED=false

## My "Plugins"
sources=(
  'aliases'
  'git'
)

for s in "${sources[@]}"; do
  source $HOME/.config/zsh/custom/${s}.zsh
done

# Append a command directly
zvm_after_init_commands+=('[ -f ~/.config/zsh/custom/keymaps.zsh ] && source ~/.config/zsh/custom/keymaps.zsh')

eval "$(starship init zsh)"

# path
path+=("/opt/homebrew/bin")
path+=("$HOME/.config/bin")
export PATH
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"

echo "zsh's config loaded"
