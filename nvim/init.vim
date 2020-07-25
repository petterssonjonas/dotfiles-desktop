""  _____              _
"" |  ___|   _ _______| |__   _____  __
"" | |_ | | | |_  / _ \ '_ \ / _ \ \/ /     NeoVIM config file.
"" |  _|| |_| |/ /  __/ |_) | (_) >  <      ~/.config/nvim/init.vim
"" |_|   \__,_/___\___|_.__/ \___/_/\_\     
""
"" This config requires vim-plug. Install it first with the following command:
"" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
""    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"" 
""""""""""""" VimPlug START """""""""""""""
"" Plug calls have to come first.
call plug#begin('~/.local/share/nvim/plugged') 
Plug 'neoclide/coc.nvim', {'branch': 'release'} " M$ VScode AI completion engine for Vim.
"Plug 'dense-analysis/ale'                   " Multilanguage Linting (disable Coc linting)
"Plug 'icymind/NeoSolarized'                 " --- Themes     ---
"Plug 'franbach/miramare'                    " Gruvbox clone sort of
"Plug 'dylanaraps/wal.vim'                   " Change colors with wallpaper.
Plug 'morhetz/gruvbox'                       " Optricians favourite.
Plug 'vim-airline/vim-airline-themes'        " --- End Themes ---
Plug 'vim-airline/vim-airline'               " Info and buffer bars.
Plug 'ap/vim-css-color'                      " Color and color code higlighter
Plug 'ryanoasis/vim-devicons'                " https://github.com/ryanoasis/vim-devicons
Plug 'Yggdroot/indentLine'                   " Code intentation lines
Plug 'psf/black', { 'branch': 'stable' }     " :Black autoformatter for Python.
Plug 'brooth/far.vim'                        " Find and replace. :help Far
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Need both these.
Plug 'junegunn/fzf.vim'                      " Fuzzyfinder :help FZF
Plug 'vim-scripts/MultipleSearch'            " :help Search, :SearchReset
Plug 'tpope/vim-fugitive'                    " :help Git 
Plug 'jiangmiao/auto-pairs'                  " Auto pairs {([''])} Looking for better alternative.
Plug 'scrooloose/nerdtree'                   " I dont really use this anymore. See floaterm+ranger.
Plug 'Xuyuanp/nerdtree-git-plugin'           " Maybe only reason to use nerdtree.
Plug 'airblade/vim-gitgutter'                " Shows changes from git branch line for line.
Plug 'machakann/vim-highlightedyank'         " Highlights yank region. Its the little things...
Plug 'tmhedberg/SimpylFold'                  " Code Folder. <>
Plug 'damofthemoon/vim-commenter'            " :Commenter. Multiline in V-mode, Multi-lang.
Plug 'damofthemoon/vim-leader-mapper'        " Configurable popup menu on <leader> press.
Plug 'terryma/vim-multiple-cursors'          " https://github.com/terryma/vim-multiple-cursors 
Plug 'yuttie/comfortable-motion.vim'         " Soft scrolling (set keybinds)
Plug 'gcavallanti/vim-noscrollbar'           " Uselessly cool scrollbar inside airline.
Plug 'mhinz/vim-startify'                    " StartPage for Vim. Not really useless.
Plug 'voldikss/vim-floaterm'                 " Floating terminal and term programs in Vim! Awesome!

""""""""""""""" Plugin options """""""""""""""

let mapleader = "\<Space>" " Set leader to space.
" In general settings set timeoutlen=millisec so you can use other leader
" commands before menu pops up.
let g:leaderMapperPos = "middle"
let g:leaderMapperWidth = 60

let g:indentLine_setColors = 1
let g:indentLine_char = '┊'

hi HighlightedyankRegion cterm=reverse gui=reverse
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:highlightedyank_highlight_duration = 1000

"let g:ale_sign_error = '🛑'
"let g:ale_sign_warning = '⚠'

let g:comfortable_motion_no_default_key_mappings = 1 " Set own further down.

let g:webdevicons_enable = 1

""""""""""""""" Airline START """""""""""""""

" Select buffer tabs with leader+num.
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
let g:airline_theme = 'gruvbox'
let g:airline#extensions#coc#enabled = 1
"let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#capslock#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' " Noscrollbar takes this space.
let g:airline#extensions#default#section_truncate_width = { 'y': 9, } " Lenght of noscrollbar.
let g:airline_right_sep = "\uE0B2"
let g:airline_left_sep = "\uE0c6" " Powerline-extras character.

""""""""""""""" Airline END """""""""""""""

""""""""""""""" Floaterm START """""""""""""""

let g:floaterm_shell = "/usr/bin/fish"
let g:floaterm_winblend = 15
let g:floaterm_keymap_kill   = '<F6>'
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.4
let g:floaterm_position = "center"
let g:floaterm_wintype = "floating"


""""""""""""""" Floaterm END """""""""""""""

""""""""""""""" VimPlug END """""""""""""""
call plug#end()

""""""""""""" Startup Commands """""""""""""
autocmd VimEnter * if !argc() | Startify | wincmd w | endif
" Add | NERDtree if you want Startify and NERDtree on start
"
""""""""""""""" Airline EXTRAS START """""""""""""""

function! Noscrollbar(...)
"let w:airline_section_y = '%{noscrollbar#statusline(9,'' '',''┃'',[''''],[''''])}'
"let w:airline_section_y = '%{noscrollbar#statusline(9,''┈'',''┊'',[''''],[''''])}'
"let w:airline_section_y = '%{noscrollbar#statusline(9,'' '',''█'',[''▌''],[''▐''])}'
"let w:airline_section_y = '%{noscrollbar#statusline(9,''■'',''◫'',[''◧''],[''◨''])}'
"let w:airline_section_y = '%{noscrollbar#statusline(9,''┈'',''│'',[''▕''],[''▏''])}'
let w:airline_section_y = '%{noscrollbar#statusline(9,'' '',''█'',[''▐''],[''▌''])}'
endfunction
call airline#add_statusline_func('Noscrollbar')

" CoC status line (section C (Middle) of airline) file location/name, language etc.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

""""""""""""""" Airline EXTRAS END """""""""""""""

colorscheme gruvbox
syntax enable
filetype indent on
set clipboard=unnamedplus
set cursorline
set cmdheight=1
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes
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
set shell=sh    "" required for some plugins to execute system functions.
set splitbelow splitright
" Set Comments and htmlargs to italic. Needs supported font
hi Comment gui=italic cterm=italic
hi htmlArg gui=italic cterm=italic

if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile " Dont fill system up with annoying swap files.
set autoread " Automatically re-read file if a change was detected outside of vim

"" Soft scrolling comfortable_motion.vim bindings.
nnoremap <silent> <PageDown> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <PageUp> :call comfortable_motion#flick(-100)<CR>

"" Sets delay between pressing leader and window popping.
"" So you can use a leader command before menu pops.
set timeoutlen=100
"set fillchars+=vert:\ " Set split separator char. default |

""""" Buffers BG Colors START """""
"" gruvbox colors: bg #282828, bg1 #3c3836
hi ActiveWindow guibg=#282828
hi InactiveWindow guibg=#3c3836
" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END
" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction

""""" Buffers BG Colors END """""

" Enable spellcheck for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

""""" Keybindings """"""
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

"noremap <silent> <C-n> :NERDTreeToggle<CR>

"" Navigating splits, saving a keypress: Ctrl-hjkl. Default C-w+left,right
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
"" Resize splits with ctrl arrowkeys
noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>
"" Remap leader from \ to space.
nnoremap <Space> <Nop>
"" Define leader key to space and call vim-leader-mapper
nnoremap <silent> <Leader> :LeaderMapper "<Space>"<CR>
vnoremap <silent> <Leader> :LeaderMapper "<Space>"<CR>

"" Additional stuff
"" w!! to save as sudo if file is not owned by user
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Run xrdb whenever Xdefaults or Xresources are updated
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

"""""""""""""" NERDTree START """"""""""""""

"augroup nerdtree_open_always
"        autocmd!
"        autocmd VimEnter * NERDTree | wincmd p
"augroup END
"
" augroup nerdtree_open_if_no_file
        " autocmd StdinReadPre * let s:std_in=1
        " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" augroup END

augroup nerdtree_open_if_dir
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
augroup END

" augroup nerdtree_autoclose_if_alone
        " autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" augroup END
" 
augroup nerdtree_dont_open_stuff_inside_nerdtree
        autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
augroup END
 
let NERDTreeAutoDeleteBuffer = 1
" let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize = 20
let g:Tlist_WinWidth = 20
let g:NERDTreeShowHidden=1
let g:webdevicons_enable_nerdtree = 1

""""""""""""""" NERDTree END """""""""""""""

""""""""""""""" vim-leader-mapper START """""""""""""""

"" Create a window of bindings. First a submenu for fuzzysearch.:
let fzfMenu = {'name':               "FZF Menu",
\'f': [":Files",                     "FZF file search"],
\'b': [":Buffers",                   "FZF buffer search"],
\'s': [":BLines",                    "FZF text search into current buffer"],
\'S': [":Lines",                     "FZF text search across loaded buffers"],
\'g': [":BCommits",                  "FZF git commits of the current buffer"],
\'G': [":Commits",                   "FZF git commits of the repository"],
\}

let keyMenu = {'name': "   Keybindings",
\'F12': [':FloatermToggle',          "F12 Floating Terminal"],
\'F9': [':FloatermNext',             "F9 Floaterm Next"],
\'F8': [':FloatermPrev',             "F8 Floaterm Previous"],
\'F7': [':FloatermNew',              "F7 Floaterm New"],
\'F6': [':FloatermKill',             "F6 Floaterm Kill"],
\'p': [':FloatermNew bpython',       "bPython"],
\'l': [':FloatermNew lazygit',       "LazyGit"],
\'r': [':FloatermNew ranger',        "Ranger"],
\}

""" Main menu content including the above menus

let g:leaderMenu = {'name':            "   Main Menu",
\'f': [fzfMenu,                        "FZF menu"],
\'k': [keyMenu,                        "Keybindings"],
\'c': [':Commenter',                   'Comment out selection'],
\'V': [':vsplit',                      'Split buffer vertically'],
\'H': [':split',                       'Split buffer horizontally'],
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
\'z': [':set foldlevel=1000',          'Open 1000 folds'],
\'R': [':so ~/.config/nvim/init.vim',  'Reload init.vim'],
\'G': [':GitGutterFold',               'Fold Git Changes'],
\}

""""""""""""""" vim-leader-mapper END """""""""""""""
