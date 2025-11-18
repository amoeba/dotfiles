# brew
set current_arch (uname -m)

if test $current_arch = "arm64"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else if test $current_arch = "x86_64"
    eval "$(/usr/local/bin/brew shellenv)"
else
    echo "Archtecture unknown, failed to initialize Homebrew."
end

# prompt
set -U pure_symbol_prompt "\$"

# functions
function fzf-git-recent
    set -l result (git recent | fzf | awk '{print $NF}')

    if test -n "$result"
        commandline "git checkout $result"
        commandline -f execute
    else
        echo "Result is empty, skipping checkout"
        commandline -f repaint
    end
end
bind \cb fzf-git-recent

# env vars
set -gx HOMEBREW_NO_ENV_HINTS 0
set -gx MAKEFLAGS -j8
set -gx EDITOR vim

# paths
fish_add_path "/opt/homebrew/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/.deno/bin"

# aliases
alias R="R --no-save --no-restore-data --quiet"
alias be="bundle exec"
alias k="kubectl"
alias rstudio="open -na Rstudio"
# aliases: git
alias gc="git commit"
alias gap="git add -p"

# arrow
set -gx ARROW_HOME "$HOME/builds/arrow-$(arch)"
set -gx ARROW_R_DEV "TRUE"
set -gx ADBC_HOME "$HOME/builds/adbc-$(arch)"

# 1p
source "$HOME/.config/op/plugins.sh"
