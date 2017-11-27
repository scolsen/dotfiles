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
# ls colors
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

alias rz='. ~/.zshrc'
alias cygh='/cygdrive/c/Users/scolsen'
alias ls='ls --color'
