" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Automatic reloading of .vimrc
""autocmd! bufwritepost .vimrc source %

" Get pathogen up and running
""filetype off
"call pathogen#runtime_append_all_bundles()
""call pathogen#helptags()

filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'chriskempson/base16-vim'
Plugin 'mattdbridges/bufkill.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'sjl/gundo.vim'
""Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/OmniCppComplete'
""Plugin 'klen/python-mode'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'
""Plugin 'ervandew/supertab'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/TaskList.vim'
""Plugin 'drmingdrmer/xptemplate'
Plugin 'peterhoeg/vim-qml'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'derekwyatt/vim-protodef'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'rdnetto/YCM-Generator'
""Plugin 'jmcantrell/vim-virtualenv'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
""Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

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
set printoptions=header:0,duplex:long,paper:letter

" set the search scan to wrap lines
set wrapscan

" Make command line two lines high
set ch=2

" set visual bell -- i hate that damned beeping
set vb

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
""set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

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
set clipboard+=unnamed

" Automatically read a file that has changed on disk
set autoread

set grepprg=grep\ -nH\ $*

" Don't use Ex mode, use Q for formatting
map Q gq

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
nmap <silent> <leader>vi ovim:set ts=2 sts=2 sw=2:<CR>vim600:fdm=marker fdl=1 fdc=0:<ESC>

" set text wrapping toggles
nmap <silent> <leader>ww :set invwrap<CR>:set wrap?<CR>

" Edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>

" Shrink the current window to fit the number of lines in the buffer.  Useful
" for those buffers that are only a few lines
nmap <silent> <leader>sw :execute ":resize " . line('$')<cr>

" Use the bufkill plugin to eliminate a buffer but keep the window layout
nmap <leader>bd :BD<cr>

" Make the current file executable
nmap <leader>x :w<cr>:!chmod 755 %<cr>:e<cr>

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"
""let g:ycm_key_list_select_completion=[]
""let g:ycm_key_list_previous_completion=[]

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"-----------------------------------------------------------------------------
" FSwitch mappings
"-----------------------------------------------------------------------------
nmap <silent> <leader>of :FSHere<CR>
nmap <silent> <leader>ol :FSRight<CR>
nmap <silent> <leader>oL :FSSplitRight<CR>
nmap <silent> <leader>oh :FSLeft<CR>
nmap <silent> <leader>oH :FSSplitLeft<CR>
nmap <silent> <leader>ok :FSAbove<CR>
nmap <silent> <leader>oK :FSSplitAbove<CR>
nmap <silent> <leader>oj :FSBelow<CR>
nmap <silent> <leader>oJ :FSSplitBelow<CR>


" YouCompleteMe Settings
nnoremap <leader>jf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_python_binary_path = '/usr/bin/python3'

"-----------------------------------------------------------------------------
" FuzzyFinder Settings
"-----------------------------------------------------------------------------
""let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|class|meta|lock|orig|jar|swp)$|/test/data\.|(^|[/\\])\.(svn|hg|git|bzr)($|[/\\])'
""let g:fuf_splitPathMatching = 1
""let g:fuf_maxMenuWidth = 110
""let g:fuf_timeFormat = ''
""nmap <silent> ,fc :FufMruCmd<cr>
""nmap <silent> ,fm :FufMruFile<cr>
""set wildignore+=*.o,*.class,.git,.svn
""let g:CommandTMatchWindowAtTop = 1
""nmap <silent> ,fb :FufBuffer<cr>
""nmap <silent> ,ff :FufFile<cr>

"-----------------------------------------------------------------------------
" Gundo Settings
"-----------------------------------------------------------------------------
nmap <c-F5> :GundoToggle<cr>

"-----------------------------------------------------------------------------
" XPTTemplate settings
"-----------------------------------------------------------------------------
""let g:xptemplate_brace_complete = 0
""let g:xptemplate_vars = "SParg="
""imap <C-l> <C-\><CR>

" NERDTree
map <leader>i :NERDTreeToggle<CR>
let NERDTreeChDirMode = 2     "setting root dir in NT also sets VIM's cd
let NERDTreeWinSize = 35

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" easier moving between buffers
""map <Leader>n <esc>:bprevious<CR>
""map <Leader>m <esc>:bnext<CR>
map <Leader>n <esc>:b#<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWritePre * :%s/\s\+$//e

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
autocmd FileType cpp nnoremap <leader>rm :make!<CR>
autocmd FileType cpp nnoremap <leader>cm :! cmake ..<CR>


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
"" set hlsearch
"" set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Settings for airlines
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_theme='dark'

" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*


" Settings for jedi
""let g:jedi#popup_on_dot = 0

" Settings for pep8
let g:pep8_map='<leader>8'

" Settings for python-mode
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode
""map <Leader>g :call RopeGotoDefinition()<CR>
""let g:pymode_rope_enable_shortcuts = 1
""let g:pymode_rope_vim_completion = 1
""let g:pymode_rope_goto_def_newwin = "vnew"
""let g:pymode_rope_extended_complete = 1
""let g:pymode_breakpoint = 0
""let g:pymode_syntax = 1
""let g:pymode_syntax_builtin_objs = 1
""let g:pymode_syntax_builtin_funcs = 1
""let g:pymode_doc = 1
""""let g:pymode_rope_autoimport_modules = ["os.*", "gi.repository.*"]
""let g:pymode_rope_always_show_complete_menu = 1
""map <Leader>b Oimport pdb; pdb.set_trace() # BREAKPOINT<C-c>

" automaticaly load the tags on every save for cpp files
autocmd BufWritePost *.cpp :TlistUpdate
" configure tags - add additional tags here or comment out not-used ones
""set tags+=./tags;~/dev
""set tags+=~/.vim/tags/cpp.tags
""set tags+=~/.vim/tags/sfml.tags
""set tags+=~/.vim/tags/gl.tags
""set tags+=~/.vim/tags/glfw.tags

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ %:p:h<CR>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set ofu=syntaxcomplete#Complete
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
""autocmd FileType python set omnifunc=pythoncomplete#Complete

" OmniCppComplete
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_ShowAccess = 1
let OmniCpp_SelectFirstItem = 0
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
set completeopt=menuone,longest,preview
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction
inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>
imap <C-space> <C-x><C-o>

" SuperTab Settings
"" let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
""let g:SuperTabDefaultCompletionType = "context"

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
" the script nust be modified becouse the key 'f, F' is reasonable for movement
set nofoldenable

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

""map <leader>l :TaskList<CR>
map <leader>l :TlistToggle<CR>


set enc=utf-8

autocmd FileType python map R :w<CR>:!python3 "%"<CR>

" Run the last shell command
nnoremap <leader>rl :!!<CR>

set cursorline
nnoremap <leader>c :set cursorline!<CR>
nnoremap <C-s> :w<CR>


" Taglist
let Tlist_Ctags_Cmd='ctags'
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 35

if has('gui_running')
  set background=dark
  colorscheme solarized
  let g:airline_theme='solarized'
  call togglebg#map("<F5>")
 "" colorscheme base16-default
 "" let g:airline_theme='base16'
  ""set t_Co=256
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
  ""colorscheme xoria256
else
  set t_Co=256
  set background=dark
  colorscheme solarized
  let g:airline_theme='solarized'
  call togglebg#map("<F5>")
  ""colorscheme xoria256
  ""colorscheme zenburn
  ""let g:airline_theme='dark'
  ""let g:solarized_termcolors=256
  ""colorscheme solarized
  ""let base16colorspace=256
  ""colorscheme base16-default
  ""let g:airline_theme='base16'
endif

autocmd FileType python highlight ColorColumn ctermbg=grey guibg=DimGrey


"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate')
"  run = 'source ' + activate_this
"  execfile(run, dict(__file__=activate_this))
"EOF

