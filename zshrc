if [[ "$(uname -s)" == "Darwin" ]]; then
    arch=$(uname -m)
    if [[ "$arch" == "x86_64" ]]; then
        # Assuming Homebrew is installed in the standard location for x86_64
        echo "[on x86_64] Setting up Homebrew"
        eval $(/usr/local/bin/brew shellenv)
    elif [[ "$arch" == "arm64" ]]; then
        # Assuming Homebrew is installed in the standard location for ARM64
        echo "[on arm64] Setting up Homebrew"
        eval $(/opt/homebrew/bin/brew shellenv)
    else
        echo "Unrecognized architecture: $arch"
    fi
fi


typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)
#plugins=(autoswitch_virtualenv $plugins)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


export VISUAL='nano'
export EDITOR='nano'



# Compilation flags
# export ARCHFLAGS="-arch x86_64"


autoload -U compinit
compinit -i -C



# ==========
# Directory
# ==========

alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."


######
setopt pushd_ignore_dups  # don't push directory if it's already on the stack
setopt pushdminus         # use - instead of + for specifying a directory in the stack
setopt always_to_end          # When completing a word, move the cursor to the end of the word
setopt append_history         # this is default, but set for share_history
setopt auto_cd                # cd by typing directory name if it's not a command
setopt auto_list              # automatically list choices on ambiguous completion
setopt auto_menu              # automatically use menu completion
setopt auto_pushd             # Make cd push each old directory onto the stack
setopt completeinword         # If unset, the cursor is set to the end of the word
setopt correct_all            # autocorrect commands
setopt extended_glob          # treat #, ~, and ^ as part of patterns for filename generation
setopt extended_history       # save each command's beginning timestamp and duration to the history file
setopt glob_dots              # dot files included in regular globs
setopt hash_list_all          # when command completion is attempted, ensure the entire  path is hashed
setopt hist_expire_dups_first # # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_find_no_dups      # When searching history don't show results already cycled through twice
setopt hist_ignore_dups       # Do not write events to history that are duplicates of previous events
setopt hist_ignore_space      # remove command line from history list when first character is a space
setopt hist_reduce_blanks     # remove superfluous blanks from history items
setopt hist_verify            # show command with history expansion to user before running it
setopt histignorespace        # remove commands from the history when the first character is a space
setopt inc_append_history     # save history entries as soon as they are entered
setopt interactivecomments    # allow use of comments in interactive code (bash-style comments)
setopt longlistjobs           # display PID when suspending processes as well
setopt no_beep                # silence all bells and beeps
setopt nocaseglob             # global substitution is case insensitive
setopt nonomatch              ## try to avoid the 'zsh: no matches found...'
setopt noshwordsplit          # use zsh style word splitting
setopt notify                 # report the status of backgrounds jobs immediately
setopt numeric_glob_sort      # globs sorted numerically
setopt prompt_subst           # allow expansion in prompts
setopt pushd_ignore_dups      # Don't push duplicates onto the stack
setopt share_history          # share history between different instances of the shell
HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=${HISTSIZE}

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'


# ==========
# History
# ==========

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=25000

setopt extended_history        # record timestamp of command in HISTFILE
setopt hist_expire_dups_first  # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups        # ignore duplicated commands in history list
setopt hist_ignore_space       # don't add commands that start with space to history
setopt hist_verify             # show command with history expansion before running it
setopt share_history           # share history between shells



# put machine specific things in zshrc_local
if [ -f "$HOME/.zshrc_local" ]; then
  source "$HOME/.zshrc_local"
fi


###############################################
# Extra MacOS stuff from Hauntsaninja

if [[ "$OSTYPE" == "darwin"* ]]; then

function pwdf() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

function lsf() {
  osascript 2>/dev/null <<EOF
    set output to ""
    tell application "Finder" to set the_selection to selection
    set item_count to count the_selection
    repeat with item_index from 1 to count the_selection
      if item_index is less than item_count then set the_delimiter to "\n"
      if item_index is item_count then set the_delimiter to ""
      set output to output & ((item item_index of the_selection as alias)'s POSIX path) & the_delimiter
    end repeat
EOF
}

function cdf() {
  cd "$(pwdf)"
}

function quick-look() {
  (( $# > 0 )) && qlmanage -p $* &>/dev/null &
}

# Show/hide hidden files in the Finder
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"


fi
##############################



################
# Boaz specific additions


export GREENSTART='\033[32m'
export GREENEND='\033[0m'
export REDSTART='\033[31m'
export REDEND='\033[0m'



# Check if the directory "~/code/boazpersonal/scripts" exists
if [[ -d "$HOME/code/boazpersonal/scripts" ]]; then
    echo "Directory $HOME/code/boazpersonal/scripts found."
    export SCRIPTS="$HOME/code/boazpersonal/scripts"
    export PATH="$SCRIPTS:$PATH"
else
    echo "Directory $HOME/code/boazpersonal/scripts not found."
    export SCRIPTS="$HOME/scripts"
fi


alias lso='/bin/ls'

# Check if 'bat' command exists
if command -v bat > /dev/null 2>&1; then
  # If it exists, alias 'cat' to 'bat'
  alias cat='bat'
fi


# from https://github.com/natelandau/dotfiles

if eza --icons &>/dev/null; then
    alias ls='eza --git --icons'                             # system: List filenames on one line
    alias l='eza --git --icons -lF'                          # system: List filenames with long format
    alias ll='eza -lahF --git'                               # system: List all files
    alias lll="eza -1F --git --icons"                        # system: List files with one line per file
    alias llm='ll --sort=modified'                           # system: List files by last modified date
    alias la='eza -lbhHigUmuSa --color-scale --git --icons'  # system: List files with attributes
    alias lx='eza -lbhHigUmuSa@ --color-scale --git --icons' # system: List files with extended attributes
    alias lt='eza --tree --level=2'                          # system: List files in a tree view
    alias llt='eza -lahF --tree --level=2'                   # system: List files in a tree view with long format
    alias ltt='eza -lahF | grep "$(date +"%d %b")"'          # system: List files modified today
elif command -v eza &>/dev/null; then
    alias ls='eza --git'
    alias l='eza --git -lF'
    alias ll='eza -lahF --git'
    alias lll="eza -1F --git"
    alias llm='ll --sort=modified'
    alias la='eza -lbhHigUmuSa --color-scale --git'
    alias lx='eza -lbhHigUmuSa@ --color-scale --git'
    alias lt='eza --tree --level=2'
    alias llt='eza -lahF --tree --level=2'
    alias ltt='eza -lahF | grep "$(date +"%d %b")"'
elif command -v colorls &>/dev/null; then
    alias ll="colorls -1A --git-status"
    alias ls="colorls -A"
    alias ltt='colorls -A | grep "$(date +"%d %b")"'
elif [[ $(command -v ls) =~ gnubin || $OSTYPE =~ linux ]]; then
    alias ls="ls --color=auto"
    alias ll='ls -FlAhpv --color=auto'
    alias ltt='ls -FlAhpv| grep "$(date +"%d %b")"'
else
    alias ls="ls -G"
    alias ll='ls -FGlAhpv'
    alias ltt='ls -FlAhpv| grep "$(date +"%d %b")"'
fi

# Source environment specific files 
# Directory containing the files
# Directory containing the files
DIR="$HOME/zshrc-source"

# Check if the directory exists
if [[ -d $DIR ]]; then
  # Loop through each file including hidden files in the directory
  for file in "${DIR}"/*(.D); do
    # Source it
    echo "Sourcing $file"
    source "$file"
  done
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

