silent! call plug#begin('~/.local/share/nvim/plugged')

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mfussenegger/nvim-dap'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'scrooloose/syntastic'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-line'
Plug 'wellle/targets.vim'
Plug 'pangloss/vim-javascript'
Plug 'groenewege/vim-less'
Plug 'vim-scripts/bash-support.vim'
Plug 'tbastos/vim-lua'
" Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'PProvost/vim-ps1'
Plug 'nikvdp/ejs-syntax'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'dyng/ctrlsf.vim'
"Plug 'Shougo/denite.nvim'
Plug 'toyamarinyon/vim-swift'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-salve'
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'gberenfield/cljfold.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'freeo/vim-kalisi'
Plug 'altercation/vim-colors-solarized'
Plug 'robertmeta/nofrils'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'mhartington/nvim-typescript', { 'for': ['typescript', 'tsx'], 'do': 'sh ./install.sh' }
"Plug 'Shougo/deoplete.nvim'
Plug 'Quramy/tsuquyomi'
Plug 'ap/vim-css-color'
Plug 'w0rp/ale'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'vimlab/split-term.vim'
Plug 'neovim/nvim-lspconfig'

call plug#end()


syntax on
filetype plugin indent on
set encoding=utf-8
set number
set tabstop=2
set expandtab
set shiftwidth=2
set shiftround
set smartindent
set autoindent
set splitbelow
set splitright
set textwidth=88
set colorcolumn=+1
set formatoptions-=t
set nowrap
set nolist
set listchars=trail:.,tab:->
set nohlsearch
set timeoutlen=300
set ttimeoutlen=10
set foldmethod=indent
set foldlevel=99

set nobackup
set noswapfile
set undodir=~/.vim/undo//
set history=1000
set undolevels=1000
"set pastetoggle=<F2>

autocmd bufwritepre * :%s/\s\+$//e
set wildignore+=*\\jcr_root\\*,*\\META-INF\\*,*\\tmp\\*,*\\node_modules\\*,*.swp,*.zip,*.exe


"'''''''''''''' Global Plugin Settings
"augroup deniteresize
"  autocmd!
"  autocmd VimResized,VimEnter * call denite#custom#option('default',
"        \'winheight', winheight(0) / 2)
"augroup end
"
"call denite#custom#option('default', {
"      \ 'prompt': '❯'
"      \ })
"call denite#custom#var('file/rec', 'command',
"  \ ['find', '-L', ':directory',
"  \ '-path', '*/.svn/*', '-prune', '-o',
"  \ '-type', 'l', '-print', '-o',
"  \ '-type', 'f', '-print'])

nnoremap <C-p> :Denite file/rec<CR>

let g:gitgutter_map_keys = 0

let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1

let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

let NerdTreeIgnore=['node_modules']
let g:ctrlsf_ignore_dir=['node_modules', 'jcr_root', 'META-INF']
"let g:deoplete#enable_at_startup = 1

"autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

"""""""""""""""""""""""""" Environment
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

"""""""""""""""""""""""""" Bindings
" DISABLE UPPERCASING/LOWERCASING
xnoremap u <nop>
xnoremap U <nop>
nnoremap gu <nop>
nnoremap gU <nop>
" END DISABLE UPPERCASING/LOWERCASING

"set pastetoggle=<F2>
let NERDTreeIgnore=['\.pyc$', '\~$']
let g:NERDTreeWinSize=40
map <C-b> :NERDTreeToggle<CR>

let mapleader=" "
nnoremap <Space> <nop>
nmap <leader>l :set list!<CR>
map <Leader>n :bn<CR>
map <Leader>p :bp<CR>
" map <C-v> "+y

" This maps C-/ to toggle comment
map <C-_> <Leader>__

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

imap kj <Esc>
vmap kj <Esc>
cnoremap kj mode<CR>

nmap ; :
vmap ; :

nmap <Leader>v <Plug>CtrlSFPrompt

"''''''''''''''''''''''''''' Vim Fugitive
nmap <Leader>b :Gblame<CR>
nmap <Leader>g :Gdiff<CR>

"''''''''''''''''''''''''''' Syntax Checkers
" let g:syntastic_javascript_checkers=['jshint']
" let g:syntastic_html_checkers=['html']
" let g:syntastic_scss_checkers = ['stylelint']
" let g:syntastic_quiet_messages = { "type": "style" }

let g:ale_linters = { 'scss': ['stylelint'] }
let g:ale_linters_ignore = {'typescript': ['tslint']}

"''''''''''''''''''''''''''' BEGIN aesthetics
if !has('gui_running')
	set t_Co=256
endif

"''''''''''''''''''''''''''' DARKSIDE
set background=dark

""" nofrils
" - nofrills COMMANDS
" :NofrilsDark use dark theme
" :NofrilsLight use light theme
" :NofrilsSepia use sepia theme
" :NofrilsAcme use acme theme
" :NofrilsFocusNormal reset back to normal settings
" :NofrilsFocusCode focus only code, fade everything else
" :NofrilsFocusComments focus only comments, fade everything else

function! GoNoFrils()
	let g:nofrils_heavylinenumbers=1
	let g:nofrils_strbackgrounds=0
	let g:nofrils_heavycomments=0
	let g:airline_theme = 'distinguished'
	colorscheme nofrils-dark
	hi LineNr ctermfg=240
endfunction
noremap <leader>d :call GoNoFrils()<CR>

""" solarized
function! GoSolarized()
	set background=dark
	let g:solarized_termtrans = 1
	let g:solarized_termcolors = 256
	let g:solarized_italics = 1
	let g:solarized_underline = 0
	let g:solarized_bold = 0
	let g:solarized_contrast = 'normal'
	let g:solarized_visibility  ='normal'
	let g:airline_theme = 'solarized'
	colorscheme solarized
endfunction
noremap <leader>f :call GoSolarized()<CR>


"''''''''''''''''''''''''''' LIGHTSIDE
" set background=light

""" kalisi
function! GoKalisi()
	set background=light
	let g:airline_theme = 'kalisi'
	colorscheme kalisi
endfunction
noremap <leader>s :call GoKalisi()<CR>

""" minimalist
function! GoMinimalist()
	set background=light
	" let g:airline_theme = 'kalisi'
	colorscheme minimalist
endfunction
noremap <leader>m :call GoMinimalist()<CR>
""" nofrils
" let g:nofrils_heavylinenumbers=1
" let g:nofrils_strbackgrounds=0
" let g:nofrils_heavycomments=0
" let g:airline_theme = 'monochrome'
" colorscheme nofrils-light
" colorscheme nofrils-acme
" colorscheme nofrils-sepia

" colorscheme soda
" colorscheme seoul256-light
" colorscheme kalisi

"""" set NOFRILS by default
":call GoNoFrils()

noremap <leader>j :color jellybeans<CR>
color jellybeans
"''''''''''''''''''''''''''' END aeshetics


"''''''''''''''''''''''''''' Furter Vimscripting

function! HybridNumberToggle()
	if (&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
		set number
	endif
endfunc
noremap <leader>i :call HybridNumberToggle()<CR>


function! ToggleNumber()
	if (&number == 1)
		set norelativenumber
		set nonumber
	else
		set number
	endif
endfunc
noremap <leader>k :call ToggleNumber()<CR>


let nf_focus = 'normal'
function! ToggleFocus()
	if (g:nf_focus == 'normal')
		let g:nf_focus = 'comment'
		:NofrilsFocusComment
	else
		let g:nf_focus = 'normal'
		:NofrilsFocusNormal
		hi LineNr ctermfg=240
	endif
endfunc
noremap <leader>c :call ToggleFocus()<CR>


:au FocusLost * :set norelativenumber
:au FocusGained * :set relativenumber
:au FocusGained * :set number

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

noremap <leader>r :so ~/.config/nvim/init.vim<CR>

" port to lua config "
"local lspconfig = require('lspconfig')
"lspconfig.ols.setup({})

lua require('init')
