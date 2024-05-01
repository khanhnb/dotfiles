export EDITOR=nvim
# Set the shell to zsh
export SHELL=/bin/zsh

setopt inc_append_history

source $HOME/.config/antigen/antigen.zsh

antigen bundle 'zsh-users/zsh-syntax-highlighting'
antigen bundle 'zsh-users/zsh-autosuggestions'
antigen bundle 'agkozak/zsh-z'
antigen apply

# use block cursor
ZVM_CURSOR_STYLE_ENABLED=false

## My "Plugins"
sources=(
  'aliases'
  'git'
  'keymaps'
)

for s in "${sources[@]}"; do
  source $HOME/.config/zsh/custom/${s}.zsh
done

eval "$(starship init zsh)"

# path
path+=("/opt/homebrew/bin")
path+=("$HOME/.config/bin")
export PATH
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"

echo "zsh's config loaded"
