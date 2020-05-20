""" _____              _               
"" |  ___|   _ _______| |__   _____  __
"" | |_ | | | |_  / _ \ '_ \ / _ \ \/ /     NeoVIM config file.
"" |  _|| |_| |/ /  __/ |_) | (_) >  <      ~/.config/nvim/init.vim
"" |_|   \__,_/___\___|_.__/ \___/_/\_\     (This file may not be read on Arch by default. RTFM.)
"""
""" This config requires vim-plug. Install it first with the following command:
"" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
""    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"" Plug calls has to be first.
call plug#begin('~/.local/share/nvim/plugged')
" Using CoC. Its better i think. Intellisense from VScode.
"" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"" Deoplete-jedi for polyglot completion
"" https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources for more.
" Plug 'zchee/deoplete-jedi'
"" polyglot is collection of language packs
" Plug 'sheerun/vim-polyglot'
" jedi-vim autocomplete for python
" Plug 'davidhalter/jedi-vim'
" Coc intellisense completion like VScode https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript', {'branch': 'master'}
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'psf/black', { 'branch': 'stable' } " :Black autoformater https://github.com/psf/black
"" color previews from coc-highlight. Good alt: https://github.com/ap/vim-css-color
"" Themes {
Plug 'morhetz/gruvbox'
Plug 'icymind/NeoSolarized'
Plug 'franbach/miramare'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"" }

"Plug 'dense-analysis/ale' " Multilanguage Linting (remember to disable cocs linting)
Plug 'ryanoasis/vim-devicons' "https://github.com/ryanoasis/vim-devicons
Plug 'brooth/far.vim'
Plug 'vim-scripts/MultipleSearch'


Plug 'jiangmiao/auto-pairs' " Pairs () [] {} '' etc https://github.com/jiangmiao/auto-pairs
Plug 'vimwiki/vimwiki' " https://github.com/vimwiki/vimwiki
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'machakann/vim-highlightedyank' " https://github.com/machakann/vim-highlightedyank
" Folds code
Plug 'tmhedberg/SimpylFold' "https://github.com/tmhedberg/SimpylFold
" Allows easy commenting even mulstiline with visual mode. :Commenter
Plug 'damofthemoon/vim-commenter' " https://github.com/damofthemoon/vim-commenter
Plug 'junegunn/fzf' " fuzzyfinder is great.
Plug 'damofthemoon/vim-leader-mapper' " Nice configurable menu on <leader> press. https://github.com/damofthemoon/vim-leader-mapper
let mapleader = "\<Space>"
"" Pop up leader-bindings-window at top, bottom or center
let g:leaderMapperPos = "bottom"
let g:leaderMapperWidth = 30
let g:vimwiki_list = [{'path': '~/.vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

let g:miramare_transparent_background = 0
let g:airline_theme = 'gruvbox'
let g:miramare_enable_italic = 1
let g:miramare_disable_italic_comment = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
hi HighlightedyankRegion cterm=reverse gui=reverse
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"let g:deoplete#enable_at_startup = 1
let g:neomake_python_enabled_makers = ['pylint']
"let g:neoformat_basic_format_align = 1
"let g:neoformat_basic_format_retab = 1
"let g:neoformat_basic_format_trim = 1
let g:highlightedyank_highlight_duration = 1000
"let g:airline#extensions#ale#enabled = 1
"let g:ale_sign_error = '🛑'
"let g:ale_sign_warning = '⚠'
" fix for OperatorMono font
hi Comment gui=italic cterm=italic
hi htmlArg gui=italic cterm=italic

call plug#end()

syntax enable
filetype indent on
set clipboard=unnamedplus
set cursorline 
set cmdheight=1
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set wildmenu
set lazyredraw
set showmatch
set encoding=utf-8
set ignorecase
set smartcase
set number relativenumber
set autoindent
set tabstop=4
set expandtab
set laststatus=2
set showtabline=2
set incsearch
set hlsearch
set noshowmode
set termguicolors "" Make function to check if has guicolors
set background=dark
set mouse=a     "" fully gui functional mouse
set shell=sh    "" required for nerdtree to open some files?
set splitbelow splitright
" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile


"" Sets delay between pressing leader and window popping.
"" So you can use a leader command before menu pops.
set timeoutlen=200
"set fillchars+=vert:\ " Set split separator char. default |
"colorscheme miramare
colorscheme gruvbox 
"" Background colors for active vs inactive windows
hi ActiveWindow guibg=#282828
hi InactiveWindow guibg=#1D2021

"" miramare colors #2A2426 #242021
"" gruvbox colors #1D2021 #32302F probably

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction

" Enable spellcheck for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" Automatically re-read file if a change was detected outside of vim
set autoread

" Keybindings
"" :map, :noremap works in all modes
"" :nmap, :nnoremap works in normal mode
"" :vmap, :vnoremap works in visual mode
"" noremap means non recursive. recursive is standard.
"" ie. :map j gg, :map Q j means Q is gg. With :noremap W j, W is j.

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

noremap <C-n> :NERDTreeToggle<CR>
"" Splits navigation, saving a keypress:
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
"" Resize splits with ctrl arrowkeys
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>
"" Remap leader from \ to space.
nnoremap <Space> <Nop>
"" Define leader key to space and call vim-leader-mapper
nnoremap <silent> <Leader> :LeaderMapper "<Space>"<CR>
vnoremap <silent> <Leader> :LeaderMapper "<Space>"<CR>
"" \tt opens terminal in new vertical split
noremap <Leader>tt :split term://fish<CR>

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>


"" Additional stuff
"" w!! to save as sudo if file is not owned by user
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Run xrdb whenever Xdefaults or Xresources are updated
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

"" NERDTree Options

"augroup nerdtree_open_always
"        autocmd!
"        autocmd VimEnter * NERDTree | wincmd p
"augroup END

augroup nerdtree_open_if_no_file
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END

augroup nerdtree_open_if_dir
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
augroup END
"" Broken when opening some .c and .py files from empty vim? lint plugin problem?
"augroup nerdtree_close_nerdtree_on_opening_file 
"        autocmd BufEnter NERD_tree_* nmap  d<CR> <CR> :NERDTreeToggle <CR>
"        autocmd BufLeave NERD_tree_* unmap d<CR>
"augroup END

augroup nerdtree_autoclose_if_alone
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

augroup nerdtree_dont_open_stuff_inside_nerdtree
        autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
augroup END

"" Other Nerdtree options
let NERDTreeAutoDeleteBuffer = 1
"let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize = 20
let g:Tlist_WinWidth = 20

"" vim-leader-mapper options

"" Create a window of bindings. First a submenu for fuzzysearch.:
" let fzfMenu = {'name':                            "FZF Menu",
             " \'f': [":Files",                     "FZF file search"],
             " \'b': [":Buffers",                   "FZF buffer search"],
             " \'s': [":BLines",                    "FZF text search into current buffer"],
             " \'S': [":Lines",                     "FZF text search across loaded buffers"],
             " \'g': [":BCommits",                  "FZF git commits of the current buffer"],
             " \'G': [":Commits",                   "FZF git commits of the repository"],
             " \}
             "
             " Define the menu content including the above menu

let g:leaderMenu = {'name':                         "Global Menu",
             \'c': [':Commenter',                   'Comment out selection'],
             \'v': [':vsplit',                      'Split buffer vertically'],
             \'h': [':split',                       'Split buffer horizontally'],
             \'n': [':NERDTreeToggle',              'ToggleNERDtree'],
             \'p': [':Farr',                        'Search and Replace'],
             \'r': [':retab',                       ':retab tabspaces => spaces'],
             \'s': [':Search',                      'Search'],
             \'d': [':bd',                          'Close buffer'],
             \'l': [':ls',                          'List opened buffers'],
             \'q': [':q',                           'Quit Nvim (:q)'],
             \'<': [':foldclose',                   'Close fold (<)'],
             \'>': [':foldopen',                    'Open fold (>)'],
             \'w': [':w',                           'Save file (:w)'],
             \'t': [':split term://fish',           'Open Term in vsplit'],
             \'z': [':set foldlevel=1000',          'Open all folds'],
             \'x': [':set foldlevel=0',             'Close all folds'],
             \}




"" Add to leaderMenu to enable fzf menu (needs config). What plugin has :Files etc...
"\'f': [fzfMenu,                "FZF menu (needs config)"],
" Reloading source and opening menu again kills nvim!
" \'r': [':so ~/.config/nvim/init.vim',  'Reload init.vim (might kill nvim)'],
