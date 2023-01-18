HOME = os.getenv("HOME")

local o = vim.opt

o.shell = "/opt/homebrew/bin/fish"

-- This must be first, because it changes other options as a side effect.
o.compatible = false
--o.autoindent = true

-- use spaces instead TABs
o.tabstop=4
o.softtabstop=2
o.shiftwidth=2
o.shiftround = true
o.expandtab = true
o.list = true
o.listchars = "tab:»-,trail:·,extends:»,precedes:«"
o.printoptions = "header:0,duplex:long,paper:A4"
-- set the search scan to wrap lines
o.wrapscan = true
-- Make command line two lines high
o.ch = 2
-- allow backspacing over everything in insert mode
o.backspace = "indent,eol,start"
-- Make sure that unsaved buffers that are to be put in the background are
-- allowed to go in there (ie. the "must save first" error doesn't come up)
o.hidden = true

-- Make the 'cw' and like commands put a $ at the end instead of just deleting
-- the text and replacing it
o.cpoptions = "ces$"
-- keep 50 lines of command line history
o.history = 50
-- show the cursor position all the time
o.ruler = true
-- display incomplete commands
o.showcmd = true
-- Don't update the display while executing macros
o.lazyredraw = true
-- When the page starts to scroll, keep the cursor 8 lines from the top and 8
-- lines from the bottom
o.scrolloff = 8
-- Make the command-line completion better
o.wildmenu = true
-- Permanent undo
o.undodir = HOME .. "/.vimdid"
o.undofile = true
-- Set the textwidth to be 80 chars
o.textwidth = 80
-- get rid of the silly characters in separators
o.fillchars = ""
-- Add ignorance of whitespace to diff
o.diffopt:append(",iwhite")
-- Enable search highlighting
o.hlsearch = true
-- Incrementally match the search
o.incsearch = true
-- Add the unnamed register to the clipboard
o.clipboard:append("unnamedplus")
-- Automatically read a file that has changed on disk
o.autoread = true
o.grepprg = "grep -nH $*"
-- Relitive line numbers
o.relativenumber = true
-- Use more sense splitting
o.splitbelow = true
o.splitright = true
-- we use lightline no need for additional mode info
o.showmode = false
o.title = true
o.cursorline = true
o.nu = true
-- don't automatically wrap on load
o.wrap = false
-- don't automatically wrap text when typing
o.fo:remove("t")
-- Syntax coloring lines that are too long just slows down the world
o.synmaxcol = 2048

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.cmd([[
" Automatic reloading of .vimrc
autocmd! bufwritepost $MYVIMRC source % " check later

" Enable syntax highlighting
" You need to reload this file for the change to apply
""filetype on
""filetype plugin on
""filetype plugin indent on
""filetype indent on
""let python_highlight_all=1
""syntax on

" Set up the gui cursor to look nice
""set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
""if has('nvim')
""  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
""  set inccommand=nosplit
""  noremap <C-q> :confirm qall<CR>
""end

" Gui option
""set go-=m
""set go-=T
""set go-=r
""set go-=l
""set go-=b

" Don't use Ex mode, use Q for formatting
map Q gq

" Rebind <Leader> key
let mapleader = ","

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid r when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the change you made.
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

" Wipe out all buffers
nmap <silent> <leader>wa :1,900bwipeout<cr>

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>
nmap <silent> <leader>kd :!mkdir -p %:p:h<CR>

" put the vim directives for my file editing settings in
nmap <silent> <leader>vi ovim:set ts=2 sts=2 sw=2 tw=79 fo=+t:<CR>vim600:fdm=marker fdl=1 fdc=0:<ESC>

" set text wrapping toggles
nmap <silent> <leader>cw :set invwrap<CR>:set wrap?<CR>

" Edit the vimrc file
""nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>ev :e ~/.config/nvim/init.lua<CR>

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

" VimWiki configuration
let g:vimwiki_list = [{'path': '~/MEGA/Linux/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_markdown_link_ext = 1

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

" <leader>= reformats current range
nnoremap <leader>= :'<,'>RustFmtRange<cr>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Session management
nmap <F3> :mksession! ./.session<cr>
nmap <F4> :source ./.session<cr>

set enc=utf-8

autocmd FileType python map R :w<CR>:!python3 "%"<CR>

" Run the last shell command
nnoremap <leader>rl :!!<CR>

nnoremap <leader>c :set cursorline!<CR>
nnoremap <C-s> :w<CR>

" limit the text width in mutt
au BufRead /tmp/mutt-* set tw=72

autocmd FileType python set colorcolumn=80
autocmd FileType elixir set colorcolumn=120
autocmd FileType fsharp set colorcolumn=120
autocmd FileType cpp set colorcolumn=100
"autocmd FileType cpp highlight ColorColumn ctermbg=darkgray

" cpp options
autocmd FileType cpp set makeprg=make\ -j16
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
autocmd FileType elixir set foldmethod=syntax
autocmd FileType c set foldmethod=syntax
autocmd FileType rust set foldmethod=syntax
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
"map <Leader>bp Oimport pdb; pdb.set_trace() # BREAKPOINT<C-c>

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
"if pumvisible()
"  if a:action == 'j'
"    return "\<C-N>"
"  elseif a:action == 'k'
"    return "\<C-P>"
"  endif
"endif
"return a:action
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
let g:python2_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" Settings for run neomake automatically
"-----------------------------------------------------------------------------
""autocmd BufWritePost * Neomake
""autocmd BufReadPost * Neomake
"""let g:neomake_markdown_enabled_makers = ['alex', 'markdownlint']
""let g:neomake_elixir_enabled_makers = ['mix', 'credo']
""let g:neomake_open_list = 0
""let g:neomake_cpp_enabled_makers = ['gcc']

" Settings for airlines
"-----------------------------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" delimitMate settings
"-----------------------------------------------------------------------------
let delimitMate_expand_cr = 1
au FileType fsharp let b:delimitMate_quotes = "\" "

" fzf settings
"-----------------------------------------------------------------------------
" Open hotkeys
""nmap <leader>f :Files<CR>
""nmap <leader>o :Buffers<CR>

autocmd BufReadPost *.rs setlocal filetype=rust

" language server protocol
"-----------------------------------------------------------------------------
""let g:LanguageClient_serverCommands = {
""      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
""      \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
""      \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
""      \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
""      \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
""      \ 'python': ['/usr/local/bin/pyls'],
""      \ 'fsharp': ['dotnet', '/home/rschwalk/.config/nvim/plugged/Ionide-vim/fsac/fsautocomplete.dll'],
""      \ }
""let g:LanguageClient_autoStart=1
""let g:LanguageClient_loadSettings = 1
""let g:LanguageClient_settingsPath = "/home/rschwalk/.config/nvim/settings.json"
""" Valid Options: "All" | "No" | "CodeLens" | "Diagnostics"
""let g:LanguageClient_useVirtualText = "No"
""""let g:LanguageClient_diagnosticsList = 'Location'
""set signcolumn=yes
""nnoremap <F5> :call LanguageClient_contextMenu()<CR>
""nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
""nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
""nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
""nnoremap <silent> gr :call LanguageClient#textDocument_references({'includeDeclaration': v:false})<cr>
""
""augroup LanguageClient_config
""  au!
""  au BufEnter * let b:Plugin_LanguageClient_started = 0
""  au User LanguageClientStarted setl signcolumn=yes
""  au User LanguageClientStarted let b:Plugin_LanguageClient_started = 1
""  au User LanguageClientStopped setl signcolumn=auto
""  au User LanguageClientStopped let b:Plugin_LanguageClient_started = 0
""  au CursorMoved * if b:Plugin_LanguageClient_started | sil call LanguageClient#textDocument_documentHighlight() | endif
""augroup END
""
""" bases
""nn <silent> xb :call LanguageClient#findLocations({'method':'$ccls/inheritance'})<cr>
""" bases of up to 3 levels
""nn <silent> xB :call LanguageClient#findLocations({'method':'$ccls/inheritance','levels':3})<cr>
""" derived
""nn <silent> xd :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true})<cr>
""" derived of up to 3 levels
""nn <silent> xD :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true,'levels':3})<cr>
""
""" caller
""nn <silent> xc :call LanguageClient#findLocations({'method':'$ccls/call'})<cr>
""" callee
""nn <silent> xC :call LanguageClient#findLocations({'method':'$ccls/call','callee':v:true})<cr>
""
""" $ccls/member
""" nested classes / types in a namespace
""nn <silent> xs :call LanguageClient#findLocations({'method':'$ccls/member','kind':2})<cr>
""" member functions / functions in a namespace
""nn <silent> xf :call LanguageClient#findLocations({'method':'$ccls/member','kind':3})<cr>
""" member variables / variables in a namespace
""nn <silent> xm :call LanguageClient#findLocations({'method':'$ccls/member'})<cr>
""
""nn xx x
""
""nn <silent> xh :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'L'})<cr>
""nn <silent> xj :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'D'})<cr>
""nn <silent> xk :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'U'})<cr>
""nn <silent> xl :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'R'})<cr>
""
""" racer + rust
""" https://github.com/rust-lang/rust.vim/issues/192
"""let g:rustfmt_command = "rustfmt +nightly"
""let g:rustfmt_autosave = 1
""let g:rustfmt_emit_files = 1
""let g:rustfmt_fail_silently = 0
""let g:rust_clip_command = 'xclip -selection clipboard'
"""let g:racer_cmd = "/usr/bin/racer"
"""let g:racer_experimental_completer = 1
""let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"
""
"""au BufWrite * :Autoformat
""
""" Completion with deoplete
""let g:deoplete#enable_at_startup = 1
""
""let g:SuperTabDefaultCompletionType = "<c-n>"

" echodoc settings
set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

"let g:rooter_manual_only = 1

" Elixir settings
"**** "let g:alchemist_tag_disable = 1
let g:alchemist_tag_map = 'gd'
autocmd BufWritePost *.exs,*.ex silent :!mix format %

" Completion with ncm2
set shortmess+=c
"autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" Use <TAB> to select the popup menu:
"inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
"inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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

"**** "-----------------------------------------------------------------------------
"**** " Gundo Settings
"**** "-----------------------------------------------------------------------------
"**** "nmap <c-F5> :GundoToggle<cr>

" NERDTree
map <leader>i :NERDTreeToggle<CR>
let NERDTreeChDirMode = 2     "setting root dir in NT also sets VIM's cd
let NERDTreeWinSize = 35

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
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=darkred
au InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWritePre * :%s/\s\+$//e

"call togglebg#map("<F9>")

""      colorscheme Tomorrow-Night
""      let g:airline_theme='tomorrow'

"hi! Normal ctermbg=NONE guibg=NONE
"hi! NonText ctermbg=NONE guibg=NONE


" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   "set termguicolors
"   source ~/.vimrc_background
" else
"   set background=dark
"   colorscheme gruvbox
" endif

"set termguicolors
"set background=light
"colorscheme solarized

highlight Comment cterm=italic gui=italic


"**** autocmd FileType python highlight ColorColumn guibg=DimGrey

]])
