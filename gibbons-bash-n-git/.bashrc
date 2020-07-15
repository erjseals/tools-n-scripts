#This script is available from the 
#Udacity course on git and github
#It's a useful interactive course
#Check it out here: 
#https://www.udacity.com/course/how-to-use-git-and-github--ud775

# Enable tab completion
source ~/.git-completion.bash

# colors!
green="\[\033[0;32m\]"
yellow="\[\033[0;33m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
reset="\[\033[0m\]"

# Change command prompt
source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$purple\u$green\$(__git_ps1)$yellow \W $ $reset"
