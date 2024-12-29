# My fish shell config

abbr vim nvim
abbr ll ls -l
abbr la ls -a
abbr cds cd ~/work/sim
abbr cdg cd ~/work/sim/go
abbr cda cd ~/work/ansible
abbr k kubecolor


abbr cat bat -p
set -x BAT_THEME ansi

set -x EDITOR nvim
set -x VISUAL nvim

fish_add_path -g /opt/homebrew/bin
fish_add_path -g ~/bin
fish_add_path -g ~/.cargo/bin

# Key bindings
set -g fish_key_bindings fish_vi_key_bindings

bind --user -M insert \ck kill-line
bind --user -M normal \ck kill-line

bind --user -M insert \ca beginning-of-line
bind --user -M normal \ca beginning-of-line

bind --user -M insert \ce end-of-line
bind --user -M normal \ce end-of-line

bind --user -M insert \cp up-or-search
bind --user -M normal \cp up-or-search

bind --user -M insert \cn down-or-search
bind --user -M normal \cn down-or-search

bind --user -M insert \cr history-pager
bind --user -M normal \cr history-pager

# This prompt will look something like this:
#
# [I] owl:~/s/g/n/monkey.odin (main)
# >
#
function fish_prompt -d "Write out the prompt"
    printf '%s%s%s:%s%s%s%s%s%s\n> ' (set_color bryellow) (prompt_hostname) (set_color normal) \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) \
        (set_color brmagenta) (fish_git_prompt) (set_color normal)
end

# Yubikey SSH agent
function ssha_yk
  set -x SSH_AUTH_SOCK SSH_AUTH_SOCK_LOCAL
end

# Secretive SSH agent
function ssha_sec
  set -x SSH_AUTH_SOCK ~/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
end
