# .bashrc

#====Source global definitions====#
#==================================#
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
#==================================#
#====#########################====#

#USER#

######################
#====RC VARIABLES====#
######################
# description:	User deifned variables to use within
#		this rc file. 

#====
#rcvar:colors
#====
RED="\e[38;5;196m"
REDDARK="\e[38;5;88m"
NC="\e[0m"

#====
#rcvar:git
#====
gitbrn="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"

###################
#====FUNCTIONS====#
###################
# decription:	User defined functions mostly for
#		automating multi-step tasks as 
#		well as enabling some git tricks.

#====
#functions:error handling
#====
#If running process exited with error, print message and exit
#$1 is the message to print. 
error_c_exit(){
	msg="$1"	
	if [ $? > 0 ]; then 			
		echo $msg
		sleep 3	
		exit
	fi
}
#If running process exited with error, print message, don't exit
error_c(){
	msg="$1"	
	if [ $? > 0 ]; then 			
		echo $msg
	fi
}

#====
#functions:git
#====
#Checkout the specified branch and store the previous branch and specified branch to variables
store_branches(){
	#store branch history for back and forward. 
	prevbranch="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
	git checkout $@ 
	nextbranch="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
}

#open all conflicting files form a git merge. 
git_conflict(){
	# open conflict files in gedit
	$(git status 2> /dev/null | grep '^both: modified' |)
}

#switch to branch stored in prevbranch var
git_prev(){
	#switch to previously checked out branch
	if [ -z ${prevbranch+x} ]; then
		error_c "No previous branch set."	
	else		
		git checkout $prevbranch
	fi
}

#switch to branch stored in prevbranch var
git_next(){
	#switch to next branch
	if [ -z ${nextbranch+x} ]; then
		error_c "No next branch set."	
	else		
		git checkout $nextbranch
	fi
}

#get the current branch, used to ensure the prompt remains updated. 
get_branch(){
	gitbrn="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
	PS1L="${RED}\W${NC}${REDDARK}(${gitbrn}):${NC}" #displays path and branch
}

#test a git merge by creating a new test branch from the current branch and merging there. 
test_merge(){
	echo "Logging results at:$logfile"
	curr_branch="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
	if [ $1 == "-p" ] || [ $1 == "--pull" ]; then 
		shift 
		merge_target=$1	
		git checkout $merge_target
		git pull 
		error_c_exit "Git pull error. Error logged to $HOME/test-merge-error.log Exiting."
	else 	
		merge_target=$1	
	fi	
	git checkout -b merge-test-ols
	git merge $merge_target
	git log 
	read -p "Test branch merged--merge actual branch?" yn
	if [ $yn == "yes" ] || [ $yn == "y" ]; then 
		git checkout $curr_branch 
		git branch -d merge-test-ols 
		git merge $merge_target	
	elif [ $yn == "no" ] || [ $yn == "n" ]; then 
		git checkout $curr_branch
		git branch -d merge-test-ols
		echo "Branch not merged. Test branch deleted."	
	fi 
}

#git hist, generate a simple diff history using commits. First gen a log file, then read log for values. 
git_hist(){
	histfile="$HOME/githist.log"
	ghoutput="$HOME/ghtmp.log"
	author="all"		
	commits=()
	messages=()
	while [ "$1" != "" ]; do 
		case $1 in 
		-o|--output)
			shift 
			$ghoutput=$1
		;;
		-a|--author)
			shift
			author="--author="$1""
		;;		
		esac
		shift
	done 
	if [[ "$author" == "all" ]]; then
		git log --pretty=format:'%h : %s' > $ghoutput	
	else
		git log "$author" --pretty=format:'%h : %s' > $ghoutput
	fi
	echo -e "\n" >> $ghoutput	
	echo "$ghoutput"	
	while read -r l; do 
			cresult=$(sed -n -e "s/ : .*//p" <<< $l)	
			mresult=$(sed -n -e "s/[0-9|a-z]* ://p" <<< $l)
			if [[ $cresult != "" ]]; then			
				commits[${#commits[@]}]+=$cresult
				messages[${#messages[@]}]+=$mresult
			fi
	done < $ghoutput
	echo "Git Hist for $(git branch 2>/dev/null | grep '^*' | colrm 1 2) commits" > $histfile
	echo -e "Filters:\n $author" >> $histfile
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~">> $histfile
	c=0	
	j=1
	commlen="${#commits[@]}"
	for i in "${commits[@]}"; do 
		if (( $j >= $commlen )); then
			echo "Complete. Stored at $histfile"
		else 
			if [ $j == $(($commlen - 1)) ]; then
				echo -e "##FIRST COMMIT##" >> $histfile
			fi			
			echo -e "Changes between: \n $i ${messages[c]} \n ${commits[j]} ${messages[j]} \n" >> $histfile
			git diff --stat=80,40,1 "$i" "${commits[j]}" >> $histfile
			echo "======================================================================" >> $histfile
			j=$(($j + 1))
			c=$(($c + 1))
		fi
	done
}

#########################
#====PROMPT SETTINGS====#
#########################
# description:	The following settings specify the
#		appearance of the shell prompt.
#		Colors are defined above, in the 
#		rc variables section. 

#====
#prompt:minimal prompt
#====
#specifies a minimal prompt. Can switch to this prompt with the alias minimal-prompt
PS1M="${RED}\W:${NC}"

#====
#prompt:git prompt
#====
#specifies a prompt that displays the currently checked out branch if in a git repository. 
PS1L="${RED}\W${NC}${REDDARK}(${gitbrn}):${NC}" 

#====
#prompt:default
#====
#set the prompt to minimal prompt as deafult. 
PS1=$PS1M 

#====
#prompt:export
export PS1

#######################
#====ENV VARIABLES====#
#######################
# description:	User set enviornment variables. These
#		of course will change dependent on 
#		the system and where everything is
#		stored. But this is a general case.

#====
#env:ant
#====
ANT_HOME=$HOME/ant/apacheant
ANT_OPTS="-Xms1024m -Xmx2048m"

#====
#env:node
#====
NODE_HOME=$HOME/node/nodejs

#====
#env:java
#====
JAVA_HOME=$HOME/jdk1.8.0_121

#====
#env:smartbear
#====
CCOLLAB_HOME=$HOME/ccollab-client

#====
#env:vscode
#====

VSCODE_HOME=$HOME/VSCode-linux-x64

#====
#env:path
#====
PATH=$PATH:$VSCODE_HOME:$CCOLLAB_HOME:$JAVA_HOME/bin:$ANT_HOME/bin:$NODE_HOME/bin

#====
#env:exports
#====
export JAVA_HOME

#################
#====ALIASES====#
#################
# description: 	Common aliases I like to keep handy. 
#		mostly to automate common tasks and 
#		speed up git use. Many of the alias-
#		es are tied to the functions above.


#=====
#alias:prompt
#=====
#switch to a minimal prompt, defined in the prompt section.
alias minimal-prompt='PS1=$PS1M'
alias git-prompt='get_branch; PS1=$PS1L;'

#====
#alias:terminal
#====
#open a new gnome terminal window
alias gt='gnome-terminal' 

#====
#alias:yum
#====
alias suyum='sudo yum install $@'

#====
#alias:git
#==== 
#Jump to root folder in git repo.
alias git-root='cd $(git rev-parse --show-toplevel)'  
alias gr='git-root'

#Echo the currently checked out branch.
alias git-branch='echo -e "Current Branch:${REDDARK} $(git branch 2>/dev/null | grep '^*' | colrm 1 2)"'
alias gb='git-branch'

#Test the results of a merge by creating a new test branch from the current branch and merging the target.
alias git-test-merge='logfile="$(mktmp)"; test_merge $1 | tee $logfile'
alias gtm='git-test-merge'

#Just checkout, but save the current branch to a history.
alias git-checkout='store_branches $@'
alias gc='git-checkout'

#Checkout last checked out branch; branch 'back-arrow'
alias git-prev='git_prev'
alias gp='git-prev'

#Checkout next checkedout branch; branch 'forward-arrow'
alias git-next='git_next'
alias gn='git-next'

#print a history file summarizing commits and changes for the current branch.
alias git-hist='git_hist'
alias gh='git-hist'
