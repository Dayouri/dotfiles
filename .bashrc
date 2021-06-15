#
# ~/.bashrc
#

[[ $- != *i* ]] && return

if [ -e $HOME/.bash_functions ]; then
    source $HOME/.bash_functions
fi

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

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

if ${use_color} ; then
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

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

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

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"


# """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Youri's aliases 
# 
# """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

alias yynvim_ftp='nvim ftp://spicynotxf@ftp.cluster020.hosting.ovh.net//'
alias yyphplaunch='php -S localhost:8000'
alias yyftpvim_spicynote='nvim ftp://spicynotxf@ftp.cluster020.hosting.ovh.net//www/wp-content/themes/'
alias yyShutdown='sudo shutdown -h now'
alias ll='ls -lhA'
alias fhere="find . -name "

alias yygoproject_spicynote='cd ~/web/SpicyNote_27-09-2018/www/wp-content/'
alias yyjack='jackd -R -P89 -dalsa -dhw:1 -r48000 -p256 -n3'

# VIRTUALENV
alias yypyenv_web='source ~/.python_venvs/pythonWeb/bin/activate'

# Display Vim Cheat Sheet (requires mdcat to read md files)
vimHelpPath=$HOME/yy/doc/VimCheatSheet.md
[[ -f $vimHelpPath  ]] && alias yyvimCheatSheet='mdcat ${vimHelpPath}'

alias svim='nvim -u ~/.SpaceVim/vimrc'

alias yywebProj1='cd ~/webapps/react_tuto_oc/from_git/onlineShop/'

alias yynvimconf='nvim ${HOME}/.config/nvim/init.vim'



# """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Youri's PATH modifs
#
# """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

export PATH=$PATH:~/.scripts/bin:/home/youri/.gem/ruby/2.5.0/bin:/home/youri/.gem/ruby/3.0.0/bin


########
# Youri's custom functions
########


function yy_find_images {
	if [[ -n "$3" ]]; then
		local pz=$3
	else
		local pz=""
	fi
	if [[ -z "$2" ]] || ! [[ "$pz" =~ ^-p0$|^$ ]]; then
		echo "Usage: $0 <directory> <what> [-p0]"
		echo "  what = all|jpng"
		return 1
	fi
	if [[ "$2" == "all" ]]; then
		find $1 -type f -exec file {} \; | awk -F: '{if ($2 ~/image/) print $1}' -p0
	elif [[ "$2" == "jpng" ]]; then
    find $1 -type f -iregex '.*\.\(jpg\|jpeg\|png\)' -print0
  fi
}


function yyfind_some_images {
    find $1 -type f -iregex '.*\.\(jpg\|jpeg\|png\|gif\)'
}

function yyfind_all_images {
	find $1 -type f -exec file {} \; | awk -F: '{if ($2 ~/image/) print $1}' -print0
}

function yyfind_jpng {
    find $1 -type f -iregex '.*\.\(jpg\|jpeg\|png\)' -print0
}

function yyparallel_optimize-m-all {
    # runs a image optimization script
    # (yyoptimize-m-all must be in $PATH)
	# params:
	#   1 : input directory
    #   2 : output directory
	if [ -z "$1" ]; then
	# display usage if no parameters given
        echo "Usage: yyparallel_extract <input_directory> <output_directory>";
        return 1
    else
        find $1 -type f -print0 | parallel -0 yyoptimize-m-all -i {} -r 85 -o $2/{}
    fi
}

function __smartresize {
	backup_file=$1.bak
	cp $1 $backup_file
	size_file_before=$(stat -c%s $1)
	if [ -z "$2" ]; then
		path_args=""
	else
		path_args="-path $2"
	fi
	mogrify $path_args -filter Triangle -define filter:support=2 -thumbnail ${3:-'2048x1536>'} -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
	size_file_after=$(stat -c%s $1)
	if [[ $size_file_after -lt $size_file_before ]]; then
		echo "Size decreased, removing backup file.."
		rm -f $backup_file
	else
		echo "Size did not decrease, restauring backup file.."
		mv $backup_file $1
	fi
}

function smartresize {
	# Recursive (or not) vesrion of smartresize
	if [ -f $1 ]; then
		__smartresize $1
	elif [ -d $1  ]; then
		if hash parallel 2>/dev/null; then 
			echo "Running optimization with gnu's parallel.."
			find $1 -type f -print0 | parallel -0 __smartresize {}
		else
			echo "WARNING: Consider installing gnu's parallel to improve mass resize speed."
			yyfind_jpng $1 | while read f; do __smartresize "$f" ; done
		fi
	else
		echo "ERROR: \'$1\' is not a valid file/directory"
	fi
}

function yy_optimize_images_for_web {
	image_optim -r $1 --allow-lossy --jpegoptim-max-quality 82 --jpegrecompress-quality 2 --pngquant-quality 70-80
}

function yy_resize_optimize_images_for_web {
	# Runs smartresize and image_optim (must be installed) on file or folder
	read -p "WARNING: This operation is lossy, do you wish to continue?" -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "Performing smart resizing..."
		smartresize $1 && \
			echo "_____________ Resizing successfully done! ______________" && \
			echo "Performing Optimization..." && \ 
			yy_optimize_images_for_web $1 && \
			echo "_____________ Optimization successfully done! ______________"
	fi
}


function yy_check_images_health {
	printf "\nChecking directory \'$1\' for corrupted images...\n"
	yyfind_all_images "$1" | while read f; do identify -verbose -regard-warnings "$f" 1>/dev/null 2>/dev/null  || echo "$f">> ${2:-corrupted.dat}; done
	printf "\nDirectory \'$1\' has been checked . Corrupted filenames are stored in \'${2:-corrupted.dat}\'.\n\n"
}


function yymkcd {
	mkdir $1 && cd $1
}

# [requires mdcat]
function yyman {
	man $1 | mdless
}

# ____    WORDPRESS    ____
function yywp_newTheme {
 	if [ -z "$1" ]; then
		echo "Usage: yywp_newtheme <plugin_name>"
		return 1
	else
		mkdir -p "$1" && cd "$1" && \
			touch header.php index.php footer.php sidebar.php single.php page.php && \
			cat > style.css <<- EOM
Theme Name: $1
Author: Youri POULIN
Author URI: http://www.hostinger.com/tutorials
Description: responsive HTML5 theme
Version: 1.0
*/


* {
  box-sizing: border-box;

}

body {
    background-color: #f9f9f9;
    font-family: Helvetica;
}

EOM

			cat > functions.php <<- EOM
<?php
function add_normalize_CSS() {
    wp_enqueue_style( 'normalize-styles', "https://cdnjs.cloudflare.com/ajax/libs/normalize/7.0.0/normalize.min.css");
}
EOM

	fi
}



# use fzf with ripgrep
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m'
fi

# display useful linux commands
function yylinux_useful {
	echo "
# Linux tips n tricks
## Useful Commands:
### Check if hardware acceleration is enabled:
```bash
glxinfo | grep 'direct rendering'
```
### Display linux kernel
```bash
    uname -r
```

## System Optimization:
### Change swapinnes to 10:
Create `/etc/sysctl.d/99-swappiness.conf` and add
`vm.swappiness = 10`
### Change swapinnes to 10:
Create `/etc/sysctl.d/99-vfs_cache_pressure.conf`  and add
`vm.vfs_cache_pressure = 50`
"
}

# display useful tips after linux install
function yylinux_after_install {
	echo "
"
}

# tab completion support for cht.sh
. ~/.bash.d/cht.sh




alias config='/usr/bin/git --git-dir=/home/youri/.yycfg/ --work-tree=/home/youri'
