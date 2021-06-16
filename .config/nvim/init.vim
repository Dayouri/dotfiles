" started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

syntax off
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"     PLUGINS
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif


""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')


" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Commentary
Plug 'tpope/vim-commentary'

" Coc (completion and more) Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() } }

" Airline
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Lightline
Plug 'mengelbrecht/lightline-bufferline'
Plug 'itchyny/lightline.vim'

" html snippets (<C-Y>,)
Plug 'mattn/emmet-vim'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Easylly modify surrounds 
Plug 'tpope/vim-surround'

" Language pack with syntax highlighting and indentation
Plug 'sheerun/vim-polyglot'

 " Better Visual Guide
Plug 'Yggdroot/indentLine'

" Or build from source code by using yarn: https://yarnpkg.com
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
 
" autopair ), ], html tags, etc...
Plug 'jiangmiao/auto-pairs'

"Color picker
Plug 'KabbAmine/vCoolor.vim'

" parenthesis rainbow
Plug 'frazrepo/vim-rainbow'

" Git plugin
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" Print function signatures in echo area
Plug 'Shougo/echodoc.vim'

" cheat.sh integration (documentation, cheat sheets)
Plug 'dbeniamine/cheat.sh-vim'

" source code browser providing an overview of the structure of source code
Plug 'yegappan/taglist'

" LSP and tags symbols
Plug 'liuchengxu/vista.vim'

" statusline from tmux (support for powerline
"  symbols and vim/airline/lightline statusline integration)
Plug 'edkolev/tmuxline.vim'

" Colorschemes
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'arzg/vim-colors-xcode'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/gruvbox-material'
Plug 'franbach/miramare'
Plug 'tomasiser/vim-code-dark'
Plug 'wojciechkepka/vim-github-dark'
Plug 'PyGamer0/github-dimmed.vim'
Plug 'owozsh/amora'
Plug 'marcelbeumer/spacedust.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIGURATION
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set encoding=utf-8
set numberwidth=1
" When you press <leader>re you can search and replace the selected text
vnoremap <silent> <leader>re :call VisualSelection('replace', '')<CR>

"close netrw (nvim native file explorer) normally
autocmd FileType netrw setl bufhidden=wipe

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Makes search act like search in modern browsers
set incsearch 

set wrap "Wrap lines

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:\ 

" Fast editing and reloading of vimrc configs
map <leader>e :e! ~/.config/nvim/init.vim<cr>
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

filetype plugin indent on
" set ttymouse=sgr
" important
set mouse=a             " mouse support
let mapleader=","
set laststatus=2
set showtabline=2
set softtabstop=0 noexpandtab
" set shiftwidth=4
set number              " show line numbers
" set relativenumber
set hidden
set noshowmode
set noshowmatch
set nolazyredraw
set smartindent
set autoindent          " keeps indentation on new line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <C-H> :nohlsearch<CR>
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level
" syntax enable

"set nolazyredraw

if has("gui_running")
  set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vista.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" automatically use the + buffer (the system clipboard) by default.
set clipboard=unnamed


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Editing mappings
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   <leader>h - Find and replace
map <leader>h :%s///g<left><left><left>

" Add a undo breakpoint when using Ctrl-w/u in INSERT mode
" inoremap <c-u> <c-g>u<c-u>
" inoremap <c-w> <c-g>u<c-w>

nnoremap <esc><esc> :noh<return><esc>

" clipboard copy/paste
nnoremap <leader>y "*y
nnoremap <leader>p "*p

" ____        terminal        ____
tnoremap <Esc> <C-\><C-n>

" move vertically by visual line (go to 'fake' lines)
nnoremap j gj
nnoremap k gk
" Open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright

" Buffers
"""""""""""""""""

" close current buffer
nmap <leader>bc :bd<cr>
nmap <Space>q :bd<cr>


" Previous and next buffer
nnoremap <Space>n :bn<CR>
nnoremap <Space>p :bp<CR>
" nnoremap <S-F8> :sbprevious<CR>
" nnoremap <S-F8> :sbprevious<CR>

" When F5 is pressed, a numbered list of file names is printed, and the user needs to type a single number based on the 'menu' and press enter. The 'menu' disappears after choosing the number so it appears only when you need it.
nnoremap <F5> :buffers<CR>:buffer<Space>


"Fast saving
nmap <leader>w :w!<cr>

"Fast exit
nma <leader>q :q<cr>

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Zoom / Restore window a la tmux
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <leader>z :ZoomToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    Plugins Settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable echodoc on startup
let g:echodoc#enable_at_startup = 1

" let g:rainbow_active = 1


""""""""""""""""""""""""""""""""""""""
" Tmux line
"
""""""""""""""""""""""""""""""""""""""
let g:tmuxline_preset = {
      \'a'    : '#(whoami)@#H',
			\'b'    : '#(pwd)',
      \'c'    : '#(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD)',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'x'    : '',
      \'y'    : ['%d-%m-%y', '%R'],
      \'z'    : '#(~/yy/bin/battery -t)'}



""""""""""""""""""""""""""""""""""""""
" Signify
"
""""""""""""""""""""""""""""""""""""""
let g:signify_disable_by_default = 1

nnoremap <leader>gg :SignifyToggle<cr>

nnoremap <leader>gd :SignifyDiff<cr>
nnoremap <leader>gp :SignifyHunkDiff<cr>
nnoremap <leader>gu :SignifyHunkUndo<cr>

" hunk jumping
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)



""""""""""""""""""""""""""""""""""""""

" For Python Completion and lint/formatting, install :
" jedi for code completion: pip install jedi
" flake8 for code linting: pip install flake8
" autopep8 for code formatting: pip install autopep8


""""""""""""""""""""""""""""""""""""""
" fzf
"
""""""""""""""""""""""""""""""""""""""
map ; :Files<CR>
nmap <Leader>t :BTags<CR>
" fzf find tags (functions, ..)
nmap <Leader>T :Tags<CR>
" fzf find lines
" current buffer
nmap <Leader>l :BLines<CR>
" all buffers
nmap <Leader>L :Lines<CR>

""""""""""""""""""""""""""""""""""""""
" Lightline
"
""""""""""""""""""""""""""""""""""""""
let g:lightline = {
            \ 'colorscheme': 'oceanicnext',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'relativepath', 'modified', 'method' ] ]
            \ },
            \ 'component_function': {
                \   'method': 'NearestMethodOrFunction'
            \ },
        \ }
let g:lightline.tabline = {
            \ 'left': [ [ 'buffers' ] ],
            \ 'right': [ [ 'tabs' ] ] }
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline.separator        = {'left': "\uE0B0", 'right': "\uE0B2"}
let g:lightline.subseparator = {'left': "\uE0B1", 'right': "\uE0B3" }

" Toggle vista view window
nnoremap <Leader>t :Vista!!<CR>

""""""""""""""""""""""""""""""""""""""
" Airline
"
""""""""""""""""""""""""""""""""""""""
" " " Enable extensions
" let g:airline_extensions = ['branch', 'hunks', 'coc', 'tabline']
" " let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
" " let g:airline_theme='powerlineish'
" let g:airline_theme='oceanicnext'
" let g:airline_powerline_fonts = 1
" " Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
" let g:airline#extensions#tabline#formatter = 'unique_tail'

" " Update section z to just have line number
" let g:airline_section_z = airline#section#create(['linenr'])

" " Do not draw separators for empty sections (only for the active window) >
" let g:airline_skip_empty_sections = 1

" " Custom setup that removes filetype/whitespace from default vim airline bar
" let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" " " Customize vim airline per filetype
" " " 'list'      - Only show file type plus current line number out of total
" " let g:airline_filetype_overrides = {
" "   \ 'list': [ '%y', '%l/%L'],
" "   \ }

" " Enable caching of syntax highlighting groups
" let g:airline_highlighting_cache = 1


" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline_symbols.space = "\ua0"

" set laststatus=2


""""""""""""""""""""""""""""""""""
"  COLORS
""""""""""""""""""""""""""""""""""
" ___ roxma/nvim-yarp

" ___ rafi/awesome-vim-colorschemes' 
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" colorscheme
let base16colorspace=256
" True Color Support if it's avaiable in terminal
if has("termguicolors")
    set termguicolors
endif

" For dark version.
set background=dark
" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
" let g:gruvbox_material_background = 'medium'
" colorscheme gruvbox-material

colorscheme oceanic_material

" use ripgrep instead of grep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

""""""""""""""""""""""""""""""""""""""
" <COC.nvim>
"
""""""""""""""""""""""""""""""""""""""

let g:coc_global_extensions = [
\ 'coc-css',
\ 'coc-emmet',
\ 'coc-eslint',
\ 'coc-explorer',
\ 'coc-highlight',
\ 'coc-html',
\ 'coc-json',
\ 'coc-prettier',
\ 'coc-project',
\ 'coc-sh',
\ 'coc-snippets',
\ 'coc-tag',
\ 'coc-tsserver',
\ 'coc-xml',
\ 'coc-yaml',
\ ]

" Use :Prettier to format current buffer
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" <leader>f for range format
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Toogle tree file explorer
nnoremap <space>e :CocCommand explorer<CR>

nmap <space>s :CocCommand snippets.editSnippets<cr>

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" coc-nvim symbols navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"   <leader>ds    - Fuzzy search current project symbols
nnoremap <silent> <Space>cs :<C-u>CocList -I -N --top symbols<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>ca  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>cws  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>cp  :<C-u>CocListResume<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <tab> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<tab>'
"
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   File-specific configurations
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f # --- <esc>a
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 


""""""""""""""""""""""""""""""
" => JavaScript section
""""""""""""""""""""""""""""""
" au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

" au FileType javascript imap <C-t> $log();<esc>hi
" au FileType javascript imap <C-a> alert();<esc>hi

" au FileType javascript inoremap <buffer> $r return 
" au FileType javascript inoremap <buffer> $f // --- PH<esc>FP2xi

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => CoffeeScript section
""""""""""""""""""""""""""""""
function! CoffeeScriptFold()
    setl foldmethod=indent
    setl foldlevelstart=1
endfunction
au FileType coffee call CoffeeScriptFold()

au FileType gitcommit call setpos('.', [0, 1, 1, 0])


""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
" if exists('$TMUX') 
"     if has('nvim')
"         set termguicolors
"     else
"         set term=screen-256color 
"     endif
" endif


""""""""""""""""""""""""""""""
" => Twig section
""""""""""""""""""""""""""""""
autocmd BufRead *.twig set syntax=html filetype=html


""""""""""""""""""""""""""""""
" => Markdown
""""""""""""""""""""""""""""""
let vim_markdown_folding_disabled = 1


""""""""""""""""""""""""""""""
"   PHP
""""""""""""""""""""""""""""""
" autocmd FileType php syntax enable
