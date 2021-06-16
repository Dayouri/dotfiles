#
# ~/.bashrc
#

[[ $- != *i* ]] && return

for DOTFILE in \
	.bash_functions \
	.bash_aliases
do
	[ -f $HOME/$DOTFILE ] && source $HOME/$DOTFILE
done 

for editor in nvim vim vi nano
do
	if command -v $editor &> /dev/null; then
		EDITOR=$editor
		break
	fi
done

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
# case ${TERM} in
# 	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
# 		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
# 		;;
# 	screen*)
# 		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
# 		;;
# esac

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if type -P dircolors >/dev/null ; then
	if [[ -f ~/.dir_colors ]] ; then
		eval $(dircolors -b ~/.dir_colors)
	elif [[ -f /etc/DIR_COLORS ]] ; then
		eval $(dircolors -b /etc/DIR_COLORS)
	fi
fi

if [[ ${EUID} == 0 ]] ; then
	export PS1="\033[01;36m\][\u@\h\[\033[01;38;5m\] \W\[\033[01;36m\]]\$\[\033[00m\]"
else
	export PS1="\033[01;36m\][\u@\h\[\033[01;38;5m\] \W\[\033[01;36m\]]\$\[\033[00m\]"
fi

unset use_color safe_term match_lhs sh

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"


export PATH=$PATH:~/.scripts/bin:$HOME/.gem/ruby/2.5.0/bin:$HOME/.gem/ruby/3.0.0/bin


# use fzf with ripgrep
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m'
fi

# tab completion support for cht.sh
. ~/.bash.d/cht.sh

##-----------------------------------------------------------------------------
## Powerline-go prompt
##-----------------------------------------------------------------------------

#function _update_ps1() {
#    PS1="$($GOPATH/bin/powerline-go -error $? -jobs $(jobs -p | wc -l))"

#    # Uncomment the following line to automatically clear errors after showing
#    # them once. This not only clears the error for powerline-go, but also for
#    # everything else you run in that shell. Don't enable this if you're not
#    # sure this is what you want.

#    #set "?"
#}

#if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

##-----------------------------------------------------------------------------
