set os (uname -s)
set arch (uname -m)

# Keep systemd-based systems awake when logged in via SSH
if set -q SSH_CLIENT
    if command -v systemd-inhibit >/dev/null
        if not pgrep -f "systemd-inhibit.*idle" >/dev/null
            echo "Inhibiting sleep via systemd..."
            systemd-inhibit --what=idle:sleep --who="SSH User" --why="Active SSH session" --mode=block fish -l
            exit
        end
    else
        echo "systemd-inhibit not available — cannot prevent sleep."
    end
end

# brew
if test "$os" = "Darwin"
	if test $arch = "arm64"
	    eval "$(/opt/homebrew/bin/brew shellenv)"
	else if test $arch = "x86_64"
			echo "Initializing Homebrew for Rosetta..."
	    eval "$(/usr/local/bin/brew shellenv)"
	else
	    echo "Architecture unknown, failed to initialize Homebrew."
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

function wt --description "Switch Git worktrees with fzf"
    set -l trees (git worktree list --porcelain | awk '
        /^worktree / { path = substr($0, 10) }
        /^branch /   { print path "\t[" substr($0, 19) "]" }
        /^detached$/ { print path "\t[detached]" }
    ')
    test (count $trees) -gt 0; or return 1
    if test (count $trees) -eq 1; and test (git rev-parse --is-bare-repository) = false
        echo 'wt: no other worktrees.' >&2
        return 0
    end
    set -l selected (printf '%s\n' $trees | fzf)
    and pushd (string split -m1 \t -- "$selected")[1]
end

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
alias pr="gh pr checkout"

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniforge/base/bin/conda
    eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/homebrew/Caskroom/miniforge/base/bin" $PATH
    end
end
# <<< conda initialize <<<

