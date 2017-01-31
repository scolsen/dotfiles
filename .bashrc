# .bashrc

# User specific aliases and functions

gitbrn="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
pathchar="|"

#PS1

RED="\e[38;5;196m"
REDDARK="\e[38;5;88m"
NC="\e[0m"

PS1M="${RED}\W:${NC}"

PS1L="${RED}\W:${NC}\n$pathchar${REDDARK}[${gitbrn}]:" #displays path and branch

PS1=$PS1M 

export PS1

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#ENV_VARIABLES
ANT_HOME=$HOME/ant/apacheant
ANT_OPTS="-Xms1024m -Xmx2048m"
NODE_HOME=$HOME/node/nodejs
JAVA_HOME=$HOME/jdk1.8.0_121
CCOLLAB_HOME=$HOME/ccollab-client
PATH=$PATH:$CCOLLAB_HOME:$JAVA_HOME/bin:$ANT_HOME/bin:$NODE_HOME/bin

export JAVA_HOME

#ALIASES
# jump to root git repo directory. 
alias git-root='cd $(git rev-parse --show-toplevel)' 
alias gt='gnome-terminal' #open a new gnome terminal window
alias gb='echo -e "Current Branch:${REDDARK} $(git branch 2>/dev/null | grep '^*' | colrm 1 2)"'
alias minimal-prompt='PS1=$PS1M'
alias long-prompt='PS1=$PS1L'
