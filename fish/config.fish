fish_vi_key_bindings
set fish_greeting ""
#set -gx TERM xterm-256color

set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always


# aliases

alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -lah"
alias lla "ll -A"
alias g git
alias v vim
alias vim nvim
# command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH ~/.cargo/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH


# tmux functions
function ide
    tmux split-window -h -p 20
    tmux split-window -v -p 66
    tmux split-window -v -p 50
end

function tmux-sessionizer
  if test -n "$argv[1]" 
    set selected $argv[1]
  else 
    set selected $(find ~/Developments ~/Desktop -mindepth 1 -maxdepth 2 -type d | fzf)
  end
  set selected_name $(basename "$selected" | tr . _)

  if test -z "$selected_name";
    return
  end

  set tmux_running $(pgrep tmux) 

  if test -z "$tmux_running";
    tmux new-session -s $selected_name -c $selected
    exit 0
  end

  if ! tmux has-session -t=$selected_name 2> /dev/null;
    tmux new-session -ds $selected_name -c $selected
  end

  tmux switch-client -t $selected_name

end

function show-desktop-icon
  if test (uname) != Darwin
    exit 0
  end
  if test $(defaults read com.apple.finder CreateDesktop) = "true"
    defaults write com.apple.finder CreateDesktop false;
  else
    defaults write com.apple.finder CreateDesktop true;
  end
  killall Finder
end

function disable-auto-switch-desktop
  if test (uname) != Darwin
    exit 0
  end
  defaults write com.apple.dock workspaces-auto-swoosh -bool NO
  killall Dock
end

# keymaps
bind -M insert \cf tmux-sessionizer
# bind -M insert \cr 'source ~/.config/fish/config.fish'

starship init fish | source
zoxide init fish | source

set -x JAVA_HOME '/opt/homebrew/opt/openjdk@17'
set -x JDTLS_JVM_ARGS "-javaagent:$HOME/.local/share/java/lombok.jar"

echo "Fish reloaded"

