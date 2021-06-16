alias cp="cp -i"                          # confirm before overwriting something

alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

alias yynvim_ftp='nvim ftp://spicynotxf@ftp.cluster020.hosting.ovh.net//'
alias yyphplaunch='php -S localhost:8000'
alias yyftpvim_spicynote='nvim ftp://spicynotxf@ftp.cluster020.hosting.ovh.net//www/wp-content/themes/'
alias yyShutdown='sudo shutdown -h now'
alias ll='ls -lhA'
alias lt='ls --human-readable --size -1 -S --classify'
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

alias yygitcfg='/usr/bin/git --git-dir=${HOME}/.yycfg/ --work-tree=${HOME}'

alias yyHello="echo Hello, ${USER} :\)"

alias count='find . -type f | wc -l'

alias cpv='rsync -ah --info=progress2'

alias trashmove='mv --force -t ~/.local/share/Trash '

alias cg='cd `git rev-parse --show-toplevel`'

alias pwdr='pwd > ~/.pwdremember'
alias cdr='cd $(cat ~/.pwdremember)'

# show mounted devices only
alias mnt="mount | grep ^/dev | gawk '{ print \$1,\$3}' | column -t | sort"

