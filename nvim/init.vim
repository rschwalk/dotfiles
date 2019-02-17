" Fish doesn't play all that well with others
set shell=/bin/bash

" =============================================================================
" # PLUGINS
" =============================================================================

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" Automatic reloading of .vimrc
""autocmd! bufwritepost .vimrc source %
filetype off                  " required!
call plug#begin('~/.config/nvim/plugged')

" Load plugins
" VIM enhancements
Plug 'tpope/vim-fugitive'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'wincent/loupe'
Plug 'ervandew/supertab'
"Plug 'derekwyatt/vim-fswitch'
"Plug 'derekwyatt/vim-protodef'

" GUI enhancements
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
"Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/TaskList.vim'
Plug 'flazz/vim-colorschemes'
"Plug 'w0ng/vim-hybrid'
"Plug 'frankier/neovim-colors-solarized-truecolor-only'
"Plug 'sjl/gundo.vim'
"Plug 'scrooloose/nerdtree'
"Plug 'fholgado/minibufexpl.vim'
"Plug 'altercation/vim-colors-solarized'
"Plug 'jnurmine/Zenburn'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'ctrlpvim/ctrlp.vim'

" Semantic language support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
\ }
Plug 'mattn/webapi-vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" Completion plugins
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
"Plug 'vim-scripts/OmniCppComplete'
"Plug 'klen/python-mode'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

" LanguageClient enhancements
Plug 'neomake/neomake'
Plug 'Shougo/echodoc.vim'
""Plug 'nvie/vim-flake8'
""Plug 'Valloric/YouCompleteMe'
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" Syntactic language support
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'
Plug 'plasticboy/vim-markdown'
"Plug 'peterhoeg/vim-qml'
""Plug 'scrooloose/syntastic'

call plug#end()

" Automatic reloading of .vimrc
autocmd! bufwritepost $MYVIMRC source %

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype on
filetype plugin on
filetype plugin indent on
filetype indent on
set autoindent
let python_highlight_all=1
syntax on

" Real programmers don't use TABs but spaces
set tabstop=8
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Printing options
set printoptions=header:0,duplex:long,paper:A4

" set the search scan to wrap lines
set wrapscan

" Make command line two lines high
set ch=2

" set visual bell -- i hate that damned beeping
"" set vb

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

" Don't update the display while executing macros
set lazyredraw

" Hide the mouse pointer while typing
set mousehide

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

" Gui option
set go-=m
set go-=T
set go-=r
set go-=l
set go-=b

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Make the command-line completion better
set wildmenu

" Permanent undo
set undodir=~/.vimdid
set undofile

" When completing by tag, show the whole tag, not just the function name
"" set showfulltag

" Set the textwidth to be 80 chars
set textwidth=80

" get rid of the silly characters in separators
set fillchars = ""

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Enable search highlighting
set hlsearch

" Incrementally match the search
set incsearch

" Add the unnamed register to the clipboard
set clipboard+=unnamedplus

" Automatically read a file that has changed on disk
set autoread

set grepprg=grep\ -nH\ $*

" Relitive line numbers
set relativenumber

" Don't use Ex mode, use Q for formatting
map Q gq

" Use more sense splitting
set splitbelow
set splitright

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" <leader>s for Rg search
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', expand('%'))
endfunction

"command! -bang -nargs=? -complete=dir Files
"  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
"  \ 'options': '--tiebreak=index'}, <bang>0)

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F11>

" Rebind <Leader> key
let mapleader = ","

" Wipe out all buffers
nmap <silent> <leader>wa :1,900bwipeout<cr>

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>
nmap <silent> <leader>kd :!mkdir -p %:p:h<CR>

" put the vim directives for my file editing settings in
nmap <silent> <leader>vi ovim:set ts=2 sts=2 sw=2 tw=79 fo=+t:<CR>vim600:fdm=marker fdl=1 fdc=0:<ESC>

" set text wrapping toggles
nmap <silent> <leader>ww :set invwrap<CR>:set wrap?<CR>

" Edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>

" Shrink the current window to fit the number of lines in the buffer.  Useful
" for those buffers that are only a few lines
nmap <silent> <leader>sw :execute ":resize " . line('$')<cr>

" Search and replace the current word
nnoremap <Leader>ss :%s/<C-r><C-w>/

" Switch spell cheking
nmap <silent> <leader>sc :set spell!<CR>
nmap <A-n> ]s
nmap <A-p> [s
nmap <A-c> 1z=

" Use to eliminate a buffer but keep the window layout
nmap <leader>bd :bp\|bd #<cr>

" Make the current file executable
""nmap <leader>x :w<cr>:!chmod 755 %<cr>:e<cr>

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" Neovim terminal settings
:tnoremap <Esc> <C-\><C-n>
:tnoremap <A-h> <C-\><C-n><C-w>h
:tnoremap <A-j> <C-\><C-n><C-w>j
:tnoremap <A-k> <C-\><C-n><C-w>k
:tnoremap <A-l> <C-\><C-n><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l
:au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space>n :nohlsearch<Bar>:echo<CR>

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
"map <c-j> <c-w>j
"map <c-k> <c-w>k
"map <c-l> <c-w>l
"map <c-h> <c-w>h

" easier moving between buffers
""map <Leader>n <esc>:bprevious<CR>
""map <Leader>m <esc>:bnext<CR>
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
map <Leader>n <esc>:b#<CR>

" <leader>= reformats current tange
nnoremap <leader>= :'<,'>RustFmtRange<cr>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Session management
nmap <F2> :mksession! ./.session<cr>
nmap <F3> :source ./.session<cr>

set enc=utf-8

autocmd FileType python map R :w<CR>:!python3 "%"<CR>

" Run the last shell command
nnoremap <leader>rl :!!<CR>

set cursorline
nnoremap <leader>c :set cursorline!<CR>
nnoremap <C-s> :w<CR>

" limit the text width in mutt
au BufRead /tmp/mutt-* set tw=72

set nu
"" set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
autocmd FileType python set colorcolumn=80
autocmd FileType cpp set colorcolumn=120
autocmd FileType cpp highlight ColorColumn ctermbg=darkgray

" cpp options
autocmd FileType cpp set makeprg=make\ -j4
autocmd FileType cpp nnoremap <leader>rm :make<CR>
autocmd FileType cpp nnoremap <leader>rc :make clean<CR>
autocmd FileType cpp nnoremap <leader>cm :! cmake ..<CR>

" Follow Rust code style rules
au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
au Filetype rust set colorcolumn=100

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c

" disable arrow keys
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <right> <nop>
inoremap <left> <nop>
noremap <up> <nop>
noremap <down> <nop>
noremap <right> <nop>
noremap <left> <nop>

" Set folding
autocmd FileType python set foldmethod=indent
autocmd FileType cpp set foldmethod=syntax
autocmd FileType c set foldmethod=syntax
set foldlevel=99

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" easier formatting of paragraphs
"" vmap Q gq
"" nmap Q gqap

" Useful settings
set history=700
set undolevels=700

" Make search case insensitive
set ignorecase
set smartcase

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Set breakpoint in python source
map <Leader>bp Oimport pdb; pdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
"set ofu=syntaxcomplete#Complete
"au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
"""autocmd FileType python set omnifunc=pythoncomplete#Complete
"
"" OmniCppComplete
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_ShowAccess = 1
"let OmniCpp_SelectFirstItem = 0
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"set completeopt=menuone,longest,preview
"" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"function! OmniPopup(action)
"    if pumvisible()
"        if a:action == 'j'
"            return "\<C-N>"
"        elseif a:action == 'k'
"            return "\<C-P>"
"        endif
"    endif
"    return a:action
"endfunction
"inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
"inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>
"imap <C-space> <C-x><C-o>

noremap <leader>gpl :-1read ~/dotfiles/nvim/templates/gpl.templ<CR>wi

" Comment
noremap <space>" I"<esc>
vnoremap <space>" I"<esc>

noremap <space># I#<esc>
vnoremap <space># I#<esc>

noremap <space>/ I//<esc>
vnoremap <space>/ I//<esc>

noremap <space>! I!<esc>
vnoremap <space>! I!<esc>

noremap <space>- I--<esc>
vnoremap <space>- I--<esc>

inoremap <leader>x <esc>
noremap <leader>x <esc>
vnoremap <leader>x <esc>

set nofoldenable



"------------------
" Plugin settings
"==================



" Neovim settings
"-----------------------------------------------------------------------------
""let g:python_host_prog = '/home/rschwalk/dev/tools/pyvenv/neovim/bin/python'
""let g:python3_host_prog = '/home/rschwalk/dev/tools/pyvenv/neovim3/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

" Settings for run neomake automatically
"-----------------------------------------------------------------------------
autocmd! BufWritePost * Neomake!
let g:neomake_open_list = 0
let g:neomake_cpp_enabled_makers = ['gcc']

" Settings for airlines
"-----------------------------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_theme='dark'

" delimitMate settings
"-----------------------------------------------------------------------------
let delimitMate_expand_cr = 1

" fzf settings
"-----------------------------------------------------------------------------
" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>m :Buffers<CR>

" language server protocol
"-----------------------------------------------------------------------------
let g:LanguageClient_settingsPath = "/home/rschwalk/.config/nvim/settings.json"
let g:LanguageClient_serverCommands = {
            \ 'rust': ['rustup', 'run', 'stable', 'rls']
            \ }
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" racer + rust
" https://github.com/rust-lang/rust.vim/issues/192
"let g:rustfmt_command = "rustfmt +nightly"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'
"let g:racer_cmd = "/usr/bin/racer"
"let g:racer_experimental_completer = 1
let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"

" Completion
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" tab to select
" and don't hijack my enter key
"inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
"inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")
" Use <TAB> to select the popup menu:
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


"let g:UltiSnipsExpandTrigger="<c-l>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"-----------------------------------------------------------------------------
" FSwitch mappings
"-----------------------------------------------------------------------------
"nmap <silent> <leader>of :FSHere<CR>
"nmap <silent> <leader>ol :FSRight<CR>
"nmap <silent> <leader>oL :FSSplitRight<CR>
"nmap <silent> <leader>oh :FSLeft<CR>
"nmap <silent> <leader>oH :FSSplitLeft<CR>
"nmap <silent> <leader>ok :FSAbove<CR>
"nmap <silent> <leader>oK :FSSplitAbove<CR>
"nmap <silent> <leader>oj :FSBelow<CR>
"nmap <silent> <leader>oJ :FSSplitBelow<CR>

" YouCompleteMe Settings
""nnoremap <leader>jf :YcmCompleter GoToDefinition<CR>
""nnoremap <leader>jc :YcmCompleter GoToDeclaration<CR>
""nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
""let g:ycm_python_binary_path = '/usr/bin/python3'
""let g:ycm_show_diagnostics_ui = 0
""let g:ycm_global_ycm_extra_conf = "~/.config/nvim/ycm_extra_conf.py"
""""let g:ycm_key_list_select_completion=[]
""""let g:ycm_key_list_previous_completion=[]


"-----------------------------------------------------------------------------
" Gundo Settings
"-----------------------------------------------------------------------------
"nmap <c-F5> :GundoToggle<cr>

" NERDTree
"map <leader>i :NERDTreeToggle<CR>
"let NERDTreeChDirMode = 2     "setting root dir in NT also sets VIM's cd
"let NERDTreeWinSize = 35


" Setting for ctr-p
""nnoremap :CtrlP<CR>
""nnoremap :CtrlPBuffer<CR>
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_max_height = 30
"set wildignore+=*.pyc
"set wildignore+=*_build/*
"set wildignore+=*/coverage/*

" Settings for pep8
"let g:pep8_map='<leader>8'

" automaticaly load the tags on every save for cpp files
""autocmd BufWritePost *.cpp :TlistUpdate
" configure tags - add additional tags here or comment out not-used ones
""set tags+=./tags;~/dev
""set tags+=~/.vim/tags/cpp.tags
""set tags+=~/.vim/tags/sfml.tags
""set tags+=~/.vim/tags/gl.tags
""set tags+=~/.vim/tags/glfw.tags

" build tags of your own project with Ctrl-F12
"map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ %:p:h<CR>

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
" the script nust be modified becouse the key 'f, F' is reasonable for movement

"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1

""map <leader>l :TaskList<CR>
"map <leader>l :TlistToggle<CR>

" Taglist
"let Tlist_Ctags_Cmd='ctags'
"let Tlist_Use_Right_Window = 1
"let Tlist_WinWidth = 35




"------------------
" Color settings
"==================


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWritePre * :%s/\s\+$//e

"call togglebg#map("<F5>")

if has('gui_running')
  set background=dark
  colorscheme solarized
  let g:airline_theme='solarized'
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
else
  if filereadable(expand("~/.vimrc_background"))
      let base16colorspace=256
      source ~/.vimrc_background
      "let g:airline_theme=substitute(g:colors_name, "-", "_", "") ""'base16_ocean'
      let g:airline_theme='base16_atelierdune'
  else
      set background=dark
      colorscheme Tomorrow-Night
      let g:airline_theme='tomorrow'
  endif
endif

autocmd FileType python highlight ColorColumn guibg=DimGrey

