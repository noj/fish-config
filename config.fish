# My fish shell config, VI keybindings is the deal

abbr ll ls -l
abbr la ls -a
abbr cds cd ~/work/sim
abbr cdg cd ~/work/sim/go
abbr cda cd ~/work/ansible

abbr vim nvim
abbr uvn uv run nvim

set -x EDITOR nvim
set -x VISUAL nvim
set -x GOROOT /usr/local/go

fish_add_path -g /usr/local/go/bin
fish_add_path -g /opt/homebrew/bin
fish_add_path -g /opt/homebrew/opt/ruby/bin
fish_add_path -g ~/bin
fish_add_path -g ~/go/bin
fish_add_path -g ~/.cargo/bin
fish_add_path -g /usr/local/zig-linux-x86_64-0.13.0

if type -q kubecolor
    abbr k kubecolor
else if type -q kubectl
    abbr k kubctl
end

if type -q batcat
    abbr cat batcat -p
    set -x BAT_THEME zenburn
end

# FZF setup
if type -q fzf
  fzf --fish | source

  # Open git grep result in nvim
  function ggv
    set -l query $argv[1]
    set -l selection (git grep -n $query | fzf --reverse)

    if test -n "$selection"
      set -l file (echo $selection | cut -d: -f1)
      set -l line (echo $selection | cut -d: -f2)
      nvim +$line $file
    end
  end
end

# VI Key bindings
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

# FZF setup
if type -q fzf
    fzf --fish | source

    # vesper
    set -Ux FZF_DEFAULT_OPTS "\
    --color=fg:#fefefe,bg:#101010,hl:#ffc799
    --color=fg+:#d0d0d0,bg+:#232323,hl+:#99ffe4
    --color=info:#afaf87,prompt:#ff8080,pointer:#99ffe4
    --color=marker:#87ff00,spinner:#ffcfa8,header:#65737e"
end


# This prompt will look something like this:
#
# [I] owl:~/s/g/n/monkey.odin (main)
# >
function fish_prompt -d "Write out the prompt"
    printf '%s%s%s:%s%s%s%s%s%s\n> ' \
        (set_color bryellow) \
        (prompt_hostname) \
        (set_color normal) \
        (set_color $fish_color_cwd) \
        (prompt_pwd) \
        (set_color normal) \
        (set_color brmagenta) \
        (fish_git_prompt) \
        (set_color normal)
end

# Yubikey SSH agent
function ssha_yk
  set -x SSH_AUTH_SOCK $SSH_AUTH_SOCK_LOCAL
end

# Secretive SSH agent
function ssha_sec
  set -x SSH_AUTH_SOCK ~/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
end
