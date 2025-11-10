# =============================================================================
# ZSHRC Configuration
# =============================================================================
# Author: Rizwan Iqbal (@automaticalldramatic)
# Last Updated: 2024-11-03
# Repository: github.com/automaticalldramatic/dotfiles
#
# This config is optimized for:
# - Ghostty terminal (theme-aware colors)
# - Keyboard-first workflows
# - Go development
# - GNU Stow dotfiles management
# =============================================================================

# =============================================================================
# KEY BINDINGS
# =============================================================================

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# =============================================================================
# COMPLETION SYSTEM
# =============================================================================

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Enable completion system
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# =============================================================================
# HISTORY CONFIGURATION
# =============================================================================
# Credit: https://registerspill.thorstenball.com/p/which-command-did-you-run-1731-days

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt INC_APPEND_HISTORY        # Immediately append to history file
setopt EXTENDED_HISTORY          # Record timestamp in history
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
setopt SHARE_HISTORY             # Share history between all sessions
unsetopt HIST_VERIFY             # Execute commands using history immediately

## colored LS
### to understand how this works, read `man ls`

export LSCOLORS=ExFxCxDxBxegedabagacad

colorflag="-G"
alias ls="ls ${colorflag}"
alias l="ls -lFG" # all files, in long format
alias la="ls -alFG" # all files inc dotfiles, in long format

## quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias c='clear'
alias e='exit'

### enable aliases to be sudo'ed
alias sudo='sudo '

## git
### you must install git for these to work ""
alias gs='git status'
alias ga='git add .'
alias gc='git commit -asm' # // requires you to type a commit message
alias gp='git push'
alias gpr='git pull --rebase'
alias gd='git diff'
alias gf='git fetch'
alias gl="git log --graph --pretty=format:'%C(yellow)%h %C(red)%ad %C(bold blue)%an%Cgreen%d %Creset%s' --date=short -10"
alias gss="git stash save"
alias gsp="git stash pop"
alias mygl="gl --author=riz --all"
alias gbv="git branch -vv"
alias gffs="git flow feature start"
alias gffp="git flow feature publish"
alias gcm="git checkout master; gpr"
alias gcd="git checkout develop; gpr"
alias hist="history | grep"
alias idea="open -na \"IntelliJ IDEA.app\" --args \"$@\""

## python
alias activate_myenv="source ~/pyEnvs/myenv/bin/activate"

## misc.
alias myip="curl http://ipecho.net/plain; echo"

# Functions
# ---------------------------------------------
fpath+=~/.zfuncs

autoload -U colors && colors # Enable colors in prompt
autoload -Uz git_info
autoload -Uz ssh_info

# Auto complete
# ---------------------------------------------
autoload -U compinit && compinit
. /Users/riz/Code/z/z.sh

# Prompt
# --------------------------------------------
setopt prompt_subst

## Custom conditional prompt. The first line shows name@machineName with directory listing and gi_info
# The second line is a nested condition. The fist level checks for last failing command and shows the ouch emoji along with the status code of the last failing command, if it failed. We pass the return code of last command to `kill -l` to display name of the error code. The scond nesting is an if command that checks if the user is in a directory for AgileFox and shows a fox emoji, respectively.
# Most of this is well documented on http://www.manpagez.com/man/1/zshmisc/

ouchPS="😬"
normPS="⚡️"
afPS="🦊"

whichSymbol() {
  if [[ $1 == *agilefox* ]]; then
    echo $afPS
  else
    echo $normPS
  fi
}

 
PS1='
%B%F{#B5BD68}%n@%m %F{#808080}in%f $(ssh_info)%F{#5E8D87}%~%u %f$(git_info)
%(?.$(whichSymbol $PWD).$ouchPS %F{#FB6090}%b[%? $(kill -l $?)]%f ) '

#------------------------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Golang
# --------------------------------------------

export CGO_ENABLED=0
export GO111MODULE=on
export GOPRIVATE=github.com/agilefoxHQ/*
export GONOPROXY=github.com/agilefoxHQ/*
export GONOSUMDB=github.com/agilefoxHQ/*

# =============================================================================
# ENVIRONMENT VARIABLES - OLLAMA
# =============================================================================

export OLLAMA_CONTEXT_LENGTH=32768
export OLLAMA_NUM_PARALLEL=4
export OLLAMA_FLASH_ATTENTION=true
export OLLAMA_HOST=http://127.0.0.1:11434
export OLLAMA_KEEP_ALIVE=10m0s
export OLLAMA_MAX_LOADED_MODELS=1


# Goose: Specific environment
# --------------------------------------------
export GOOSE_SHELL="/bin/zsh"
export GOOSE_INHERIT_ENV="true"

# Misc
# --------------------------------------------
export GPG_TTY=$(tty)

# pnpm
# --------------------------------------------
export PNPM_HOME="/Users/riz/Library/pnpm"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/riz/Code/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/riz/Code/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/riz/Code/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/riz/Code/google-cloud-sdk/completion.zsh.inc'; fi

# --- Consolidated PATH setup ---

# Ensure Homebrew is sourced first for Apple Silicon
eval "$(/opt/homebrew/bin/brew shellenv)"

# Define common user-level bin paths. ORDER MATTERS.
# Put directories you want to prioritize earlier in the list.
USER_BIN_PATHS=(
    "$HOME/.nvm/versions/node/v22.13.1/bin" # NVM should come early if you want its node/npm
    "$PNPM_HOME"                            # pnpm home
    "$HOME/.local/bin"                      # General user binaries
    "$HOME/Code/google-cloud-sdk/bin"       # Google Cloud SDK
    "/opt/homebrew/opt/postgresql@16/bin"   # PostgreSQL
    "/usr/local/go/bin"                     # GoLang
    "/usr/local/MacGPG2/bin"                # MacGPG2
    "/Library/Frameworks/Mono.framework/Versions/Current/Commands" # Mono
    "/Applications/iTerm.app/Contents/Resources/utilities" # iTerm utilities
)

# Filter out non-existent paths to keep PATH clean
# and combine them with system paths (which are usually already in PATH from /etc/paths)
CONSOLIDATED_PATH=""
for p in "${USER_BIN_PATHS[@]}"; do
    if [[ -d "$p" && ! "$CONSOLIDATED_PATH" =~ ":$p:" ]]; then # Check if directory exists and not already in consolidated path
        CONSOLIDATED_PATH="$p:$CONSOLIDATED_PATH"
    fi
done

# Final export. Ensure Homebrew's paths are already in here, as brew shellenv does that.
# The default system paths are usually managed by /etc/paths or macOS itself and are typically at the end.
# Pyenv will later prepend its shims to this.
export PATH="$CONSOLIDATED_PATH:$PATH"

# --- End Consolidated PATH setup ---

export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/riz/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/riz/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/riz/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/riz/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/riz/.lmstudio/bin"
# End of LM Studio CLI section

# =============================================================================
# LOCAL OVERRIDES (Secrets, machine-specific config)
# =============================================================================

# Source local configuration file if it exists
# This file should contain:
# - API keys (GEMINI_API_KEY, ANTHROPIC_API_KEY, etc.)
# - Machine-specific paths
# - Work-specific configuration
# - Any other secrets that shouldn't be in version control

if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi

# =============================================================================
# END OF CONFIGURATION
# =============================================================================
