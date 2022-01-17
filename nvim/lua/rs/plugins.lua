vim.cmd([[

filetype off                  " required!
call plug#begin('~/.config/nvim/plugged')

" Load plugins
" VIM enhancements
Plug 'tpope/vim-fugitive'
Plug 'will133/vim-dirdiff'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'wincent/loupe'
Plug 'ervandew/supertab'
Plug 'derekwyatt/vim-fswitch'
Plug 'derekwyatt/vim-protodef'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'flazz/vim-colorschemes'

" GUI enhancements
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'itchyny/lightline.vim'
"Plug 'bling/vim-bufferline'
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
"Plug 'vim-scripts/taglist.vim'
"  Plug 'vim-scripts/TaskList.vim'
"Plug 'flazz/vim-colorschemes'

" Polyglot loads language support on demand!
Plug 'sheerun/vim-polyglot'

"Plug 'w0ng/vim-hybrid'
"Plug 'frankier/neovim-colors-solarized-truecolor-only'
"Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
"Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdtree'
"Plug 'fholgado/minibufexpl.vim'
Plug 'altercation/vim-colors-solarized'
"Plug 'tomasr/molokai'

" Fuzzy finder
"Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'ctrlpvim/ctrlp.vim'

" Semantic language support
"  Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"  Plug 'mattn/webapi-vim'
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"  Plug 'ionide/Ionide-vim', {
"              \ 'do':  'make fsautocomplete',
"              \}

" Completion plugins
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-tmux'
"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-ultisnips'
"Plug 'vim-scripts/OmniCppComplete'
"Plug 'klen/python-mode'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" LanguageClient enhancements
Plug 'neomake/neomake'
Plug 'Shougo/echodoc.vim'
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist' " required for some navigation features
Plug 'slashmili/alchemist.vim'
"Plug 'nvie/vim-flake8'
Plug 'Chiel92/vim-autoformat'

" Syntactic language support
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'
Plug 'plasticboy/vim-markdown'
"Plug 'peterhoeg/vim-qml'
"Plug 'scrooloose/syntastic'

" Other
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()
]])
