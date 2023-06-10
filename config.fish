# Homebrew
set current_arch (uname -m)

if test $current_arch = "arm64"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else if test $current_arch = "x86_64"
    eval "$(/usr/local/bin/brew shellenv)"
else
    echo "Archtecture unknown, failed to initialize Homebrew."
end

# PATH
fish_add_path ~/go/bin
fish_add_path ~/bin

# env
set -gx HOMEBREW_NO_ENV_HINTS 0

# aliases
alias R="R --no-save --no-restore-data --quiet"
alias be="bundle exec"

# arrow
set -gx ARROW_HOME "$HOME/builds/arrow-$(arch)"

# chruby
#source "/opt/homebrew/opt/chruby/share/chruby/chruby.sh"
