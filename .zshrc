# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
plugins=(git)

source $ZSH/oh-my-zsh.sh
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# User configuration

# --- Uniwersalne ładowanie fzf ---
if fzf --zsh &>/dev/null; then
  # Dla fzf >= 0.48.0
  source <(fzf --zsh)
elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  # Debian / MX Linux / Ubuntu (starsze wersje z APT)
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
elif [ -f /usr/share/fzf/key-bindings.zsh ]; then
  # Arch Linux / Fedora
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
elif [ -f ~/.fzf.zsh ]; then
  # Instalacja ręczna przez git clone
  source ~/.fzf.zsh
fi

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cfz='vim ~/.zshrc'
alias rcfz='source ~/.zshrc'
alias ls='eza --group-directories-first --icons'
alias lsa='eza -a --group-directories-first --icons'
alias lls='eza -l --group-directories-first --icons'
alias lsd='eza -D --icons'
alias lst='eza --tree --icons'
alias lst1='eza --tree --level=1 --icons'
alias lst2='eza --tree --level=2 --icons'
alias lst3='eza --tree --level=3 --icons'
alias sshmikrus='ssh root@srv16.mikr.us -p 10454'
alias mkdate="mkdir `date '+%Y-%m-%d'` && cd `date '+%Y-%m-%d'` "
alias stoper="/home/pstyczewski/.local/bin/termdown"
alias timer="/home/pstyczewski/.local/bin/termdown"
alias zegar="/home/pstyczewski/.local/bin/termdown -z"
alias g='git'

# Alias 'ff': Interaktywne otwarcie pliku w Vimie z podglądem
alias fv='vim $(fzf --preview "if [ -d {} ]; then eza --tree --icons {}; else batcat --style=numbers --color=always {}; fi")'

# Przechodzenie do katalogu z podglądem jego struktury przez eza
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/.*' -prune -o -type d -print 2> /dev/null | fzf --preview 'eza --tree --level=2 --icons=always {} | head -200') && cd "$dir"
}

# Szybkie wyszukiwanie pliku z pełnymi informacjami z eza
ff() {
    find . -iname "*$1*" -exec eza -ld --icons --time-style=long-iso --git {} +
}

mkcd () {
  case "$1" in /*) :;; *) set -- "./$1";; esac
  mkdir -p "$1" && cd "$1"
}

# Tworzy katalog z bieżącą datą i czasem (np. 2026-09-13_12-55), a następnie do niego przechodzi
mkd() {
  local dir_name="$(date +%Y-%m-%d_%H-%m)"

  # Jeśli podasz dodatkowy argument (np. mkd moj_projekt), nazwa będzie dopisana na końcu
  if [ -n "$1" ]; then
    dir_name="${dir_name}_$1"
  fi

  mkdir -p "$dir_name" && cd "$dir_name"
}

# fif (Find In Files) - szuka tekstu i otwiera wybrany plik w Vimie na odpowiedniej linii
fif() {
  if [ -z "$1" ]; then
    echo "Użycie: fif <szukana_fraza>"
    return 1
  fi
  local file
  file=$(rg --line-number --no-heading --color=always --smart-case "$1" | \
    fzf --ansi --color=hl:175,hl+:212 \
        --delimiter : \
        --preview 'bat --color=always --style=header,grid --highlight-line {2} {1}' \
        --preview-window 'up:60%:+{2}-5') && \
  vim "$(echo "$file" | cut -d: -f1)" +$(echo "$file" | cut -d: -f2)
}

function y() {
	local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
	command rm -f -- "$tmp"
}

# Przełączanie gałęzi Git z podglądem ostatnich commitów
fgb() {
  local branch
  branch=$(git branch -a --format="%(refname:short)" | fzf --preview 'git log --oneline --graph --date=short --color=always {} | head -200')
  if [ -n "$branch" ]; then
    git checkout $(echo "$branch" | sed "s/origin\///")
  fi
}

# Podgląd zmodyfikowanych plików (git status) z difffem na żywo
fgd() {
  local file
  file=$(git status -s | fzf --preview 'git diff --color=always {2}' | awk '{print $2}')
  if [ -n "$file" ]; then
    vim "$file"
  fi
}
