# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/scolsen/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt appendhistory
bindkey -v
# End of lines configured by zsh-newuser-install

# 256 color support
TERM=screen-256color
export CLICOLOR=1

# Prompt 
P="|%1~ ∴ "

# Display vim mode
function zle-keymap-select zle-line-init {
  VIM_PROMPT="${${KEYMAP/vicmd/normal}/(main|viins)/insert}"
  PROMPT="$VIM_PROMPT$P"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Keybindings

bindkey fj vi-cmd-mode 

# Citations Folder
citDir="$HOME/citations/"

# citation generator
function cite {
  read  "?Author Name: " author
  read  "?Work Title: " work
  echo "Select a Document Type: "
  select opt in Book Article; do
    if [ "$opt" = "Book" ]; then
      work="*$work.*"
      break;
    elif [ "$opt" = "Article" ]; then
      work="\"$work.\""
      break;
    else 
      clear 
      echo "bad option"
    fi
  done
    read -k 1 "?Translated [y/N]" trans
    if [[ $trans =~ [Yy] ]]; then
      read "?Translator: " translator
      transStr="Translated by $translator. "
    fi
    echo "\n"
    read "?Publisher: " publisher
    read "?Publisher Location: " location
    read "?Pub Year: " pubyear
    authorFile="${author//[,\*\.]/}"
    workFile="${work//[,\*\.]/}"
    authorFile="$authorFile:l"
    workFile="$workFile:l"
    
    mlaStr="$author. $work $transStr$publisher, $pubyear."
    chicagoStr="$author. $work $transStr$location: $publisher, $pubyear."
    citFile="$citDir${authorFile// /_}_${workFile// /_}.md"
    echo "# MLA" > "$citFile"
    echo "$mlaStr" >> "$citFile"
    echo "# Chicago" >> "$citFile"
    echo "$chicagoStr" >> "$citFile"
    echo "Wrote citation file: $citFile"
}

function word_count {
  wc -w $1 | awk '{$1=$1};1' | cut -f 1 -d " "  
}

function line_count {
  wc -l $1 | awk '{$1=$1};1' | cut -f 1 -d " "  
}

function char_count {
  wc -m $1 | awk '{$1=$1};1' | cut -f 1 -d " "  
}

source .env

alias rz='. ~/.zshrc'
alias whc='which'
alias words='word_count'
alias lines='line_count'
alias chars='char_count'

alias ga= 'git add $@; git status'
alias gs='git status'
alias gc='git commit -m'

alias vrc='vim ~/.vimrc'
alias zrc='vim ~/.zshrc'
alias brc='vim ~/.bashrc'
alias lls='ls -d ^[A-Z]*'
