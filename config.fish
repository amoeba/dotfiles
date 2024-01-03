# Homebrew
set current_arch (uname -m)

if test $current_arch = "arm64"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else if test $current_arch = "x86_64"
    eval "$(/usr/local/bin/brew shellenv)"
else
    echo "Archtecture unknown, failed to initialize Homebrew."
end

# ENV
set -gx HOMEBREW_NO_ENV_HINTS 0
set -gx MAKEFLAGS -j8
set -gx EDITOR vim

# PATH
fish_add_path ~/bin
fish_add_path ~/go/bin
fish_add_path ~/.cargo/bin

# aliases
alias R="R --no-save --no-restore-data --quiet"
alias be="bundle exec"
alias k="kubectl"
alias rstudio="open -na Rstudio"

# arrow
set -gx ARROW_HOME "$HOME/builds/arrow-$(arch)"
set -gx ARROW_R_DEV "TRUE"
