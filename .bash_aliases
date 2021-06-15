alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

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

alias yygitcfg='/usr/bin/git --git-dir=${HOME}/.yycfg/ --work-tree=${HOME}'

alias yyHello="echo Hello, ${USER} :\)"
