
:set ignorecase
:set smartcase
set incsearch
:set cursorline

" tab sizes and such
:set tabstop=2
:set shiftwidth=2
:set expandtab

set number
colorscheme default
color default

" for managing opening of files (fzf)
map <silent> <F2> :Files<CR>
map <silent> <F3> :Buffers<CR>

call plug#begin()

" visual stuff like airline and handy extensions for searching / navigating files
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mcchrish/nnn.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" general text plugins and navigation plugins
Plug 'townk/vim-autoclose'
Plug 'justinmk/vim-sneak'

" language specific plugins
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'posva/vim-vue'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

call plug#end()

" language specific overrides
" Go
autocmd Filetype go setlocal tabstop=8
autocmd Filetype go setlocal expandtab!

" config for plugins
" prettier:
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 0
autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync

" nnn config
" Floating window. This is the default
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Comment' } }
