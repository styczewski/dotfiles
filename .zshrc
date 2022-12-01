# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/pstyczewski/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="kiwi"
# ZSH_THEME="alien-minimal/alien-minimal"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Activate vim mode  with <Escape>
# set -o vi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
alias aliasy='grep "alias" ~/.zshrc | more'
alias ls='exa --group-directories-first --icons'
alias lsa='exa -a --group-directories-first --icons'
alias lls='exa -l --group-directories-first --icons'
alias lsd='exa -D --icons'
alias lst='exa --tree --icons'
alias lst1='exa --tree --level=1 --icons'
alias lst2='exa --tree --level=2 --icons'
alias lst3='exa --tree --level=3 --icons'
alias qq='exit'
alias r='ranger'
alias vi='vim .'
alias vf='vifm .'
alias vl='vim -u ~/.vimrclite '
alias sr='sudo ranger'
alias cfz='vim ~/.zshrc'
alias cfst='vim ~/.Xdefaults && xrdb ~/.Xdefaults'
alias cfv='vim ~/.vimrc'
alias cfr='vim ~/.config/ranger/rc.conf'
alias cfi='vim ~/.config/i3/config'
alias cfa='vim ~/.abook/addressbook'
alias cfnews='vim ~/.newsboat/config'
alias cfmutt='vim ~/.config/mutt/muttrc'
alias cfq='vim ~/.config/qutebrowser/quickmarks'
alias cfqdiff='vimdiff ~/.config/qutebrowser/quickmarks ~/Dropbox/0remotefile/qutebrowser-url/h/quickmarks'
alias rcfz='source ~/.zshrc'
alias konfigi="ranger --cmd='set viewmode!' ~/bin/123config/home/pstyczewski/.config ~/.config"
alias binary="peaclock --config-dir ~/.config/peaclock --config ~/.config/peaclock/configbinary"
alias binaryunicode="peaclock --config-dir ~/.config/peaclock --config ~/.config/peaclock/configbinaryunicode"
alias clock="peaclock --config-dir ~/.config/peaclock --config ~/.config/peaclock/configdigital"
alias stoper="peaclock --config-dir ~/.config/peaclock --config ~/.config/peaclock/configstopwatch"
alias timer="peaclock --config-dir ~/.config/peaclock --config ~/.config/peaclock/configtimer"
alias capsoff="/home/pstyczewski/Dropbox/moje-aplikacje/capsoff"
alias texpander="echo `date '+%d.%m.%Y'` > /home/pstyczewski/.texpander/data && echo 'Szczecin, dnia' `date '+%d.%m.%Y'`'r.' > /home/pstyczewski/.texpander/szczdn && echo 'Police, dnia' `date '+%d.%m.%Y'`'r.' > /home/pstyczewski/.texpander/poldn"
alias mplayerpawel="mplayer -ontop -noborder -zoom -x 240 -y 135 -geometry 1170:730"
alias pawelmontuj="encfs /home/pstyczewski/Dropbox/pawel/.pawel /home/pstyczewski/encfs/pawel"
alias pawelodmontuj="fusermount -u ~/encfs/pawel"
alias notesmontuj="encfs /home/pstyczewski/Dropbox/pawel/.notes/ /home/pstyczewski/encfs/notes"
alias notesodmontuj="fusermount -u ~/encfs/notes"
alias gam="cd /home/pstyczewski/Documents/Dokumenty && clear"
alias gad="cd /home/pstyczewski/Downloads/ && clear"
alias gar="cd /home/pstyczewski/Dropbox/ && clear"
alias gae="cd /home/pstyczewski/encfs/ && clear"
alias gac="cd /home/pstyczewski/.config/ && clear"
alias poczta="source ~/.zshrc && cd /home/pstyczewski/muttfiles/ && mkdir -p `date '+%Y-%m-%d'` && cd `date '+%Y-%m-%d'` && neomutt"
alias pogoda="curl wttr.in/szczecin"
alias usunkopievim="find . -type d -name ".backups" -exec rm -rf {} \;"
alias backconfig='~/bin/backconfigwork.sh'
alias katalogdata="mkdir `date '+%Y-%m-%d'` && cd `date '+%Y-%m-%d'` "
alias kopie="rsync -avr --include='*.7z' /mnt/kopie/ /media/pstyczewski/Nowy/KOPIE-ZAPASOWE/"
alias internet="~/bin/netcheck/netcheck.sh -c 3 -s -f log_internet_`date '+%Y-%m-%d'`.txt"
alias pigo='ping 8.8.8.8'
alias pigolog='ping -c 8640 -i 3 8.8.8.8 | while read pong; do echo “$(date): $pong”; done > pings_dns.txt'
alias feh='feh --auto-zoom --scale-down -g 1360x768 -B white'
alias v='f -e vim' # quick opening files with vim
alias m='f -e mplayer' # quick opening files with mplayer
alias o='a -e xdg-open' # quick opening files with xdg-open
alias haslo='pwgen -1 16 -B -c -y | clipcopy && clippaste'
alias nagrajekran1024='ffmpeg -video_size 1024x768 -framerate 25 -f x11grab -i :0.0+500,250 output.mp4'
alias nagrajekran='ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0+0,0 output.mp4'
alias dokuallpdf2txt='for file in *.pdf; do pdftotext "$file" "$file.txt"; done'
alias doku='/home/pstyczewski/Dropbox/doku/doku'
alias szukajpakietu='sudo pacman -Syy && sudo pacman -Ssq '
alias calcurse='calcurse -D /home/pstyczewski/Dropbox/00zadania/calcurse_praca/'
alias cal='clear && cal'
alias Cal='clear && cal -3'
alias CAL="clear && cal `date '+%Y'`"
alias powiedz="espeak -v pl "
alias pandoctxt2pdf='_convert() { pandoc -V geometry:"top=2cm, bottom=1.5cm, left=1cm, right=1cm" "$1" --pdf-engine=xelatex -o "$2" ;}; _convert'
alias pandoctxt2docx='_convert() { pandoc -s "$1" -o "$2" ;}; _convert'
alias montujdyskkopii='sudo mount /dev/sdb3 /home/pstyczewski/mnt/dysk-kopii'

alias pobierzzoom='wget https://zoom.us/client/latest/zoom_x86_64.pkg.tar.xz'
alias diffvim='ls  -r /home/pstyczewski/Dropbox/back-config/back-after-edit/*vim**pawelski* | head -1 | xargs vimdiff ~/.vimrc'


# CUSTOMIZATION FOR ZSH
if [ -r ~/Dropbox/zsh/myzshrc-aliasy ]; then
  source ~/Dropbox/zsh/myzshrc-aliasy
fi

function pdfexp(){
/usr/bin/pdftk $1 cat $2 output plik-$3.pdf
}

# https://github.com/gotbletu/dotfiles/blob/master/aliasrc/.aliasrc
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f "$1" ] ; then
        NAME=${1%.*}
        #mkdir $NAME && cd $NAME
        case "$1" in
          *.tar.bz2)   tar xvjf ./"$1"    ;;
          *.tar.gz)    tar xvzf ./"$1"    ;;
          *.tar.xz)    tar xvJf ./"$1"    ;;
          *.lzma)      unlzma ./"$1"      ;;
          *.bz2)       bunzip2 ./"$1"     ;;
          *.rar)       unrar x -ad ./"$1" ;;
          *.gz)        gunzip ./"$1"      ;;
          *.tar)       tar xvf ./"$1"     ;;
          *.tbz2)      tar xvjf ./"$1"    ;;
          *.tgz)       tar xvzf ./"$1"    ;;
          *.zip)       unzip ./"$1"       ;;
          *.Z)         uncompress ./"$1"  ;;
          *.7z)        7z x ./"$1"        ;;
          *.xz)        unxz ./"$1"        ;;
          *.exe)       cabextract ./"$1"  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "'$1' - file does not exist"
    fi
fi
}

mkcd () {
  case "$1" in /*) :;; *) set -- "./$1";; esac
  mkdir -p "$1" && cd "$1"
}

fo() {
    cd ~ | fd -t f | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
}
zle -N fo
bindkey "^j" fo

fcd() {
   cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)" && clear && tree -L 1
}
zle -N fcd
bindkey "^k" fcd


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PATH="/home/pstyczewski/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/pstyczewski/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/pstyczewski/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/pstyczewski/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/pstyczewski/perl5"; export PERL_MM_OPT;

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
