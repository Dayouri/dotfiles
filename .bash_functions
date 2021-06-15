function cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        ls -F --color=auto
}

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}


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

