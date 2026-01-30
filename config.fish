set os (uname -s)
set arch (uname -m)

# brew
if test "$os" = "Darwin"
	if test $current_arch = "arm64"
	    eval "$(/opt/homebrew/bin/brew shellenv)"
	else if test $current_arch = "x86_64"
	    eval "$(/usr/local/bin/brew shellenv)"
	else
	    echo "Archtecture unknown, failed to initialize Homebrew."
	end
end

# prompt
set -U pure_symbol_prompt "\$"

### functions
# fzf-git-recent
function fzf-git-recent --description "Switch to branch with fzf"
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

# fzf-open-editor
function fzf-open-editor --description "Open in $EDITOR with fzf"
	set -l result (fzf)

	if test -n "$result"
		commandline "$EDITOR \"$result\""
		commandline -f execute
	else
		commandline -f repaint
	end
end
bind \co fzf-open-editor

# env vars
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
alias gs="git status"
alias gap="git add -p"

# arrow
set -gx ARROW_HOME "$HOME/builds/arrow-$(arch)"
set -gx ARROW_R_DEV "TRUE"
set -gx ADBC_HOME "$HOME/builds/adbc-$(arch)"

# 1p
#source "$HOME/.config/op/plugins.sh"

# atuin
if status is-interactive
	atuin init fish --disable-up-arrow | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
