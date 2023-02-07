:filetype on

:set ignorecase
:set smartcase
set incsearch
:set cursorline
:set mouse=a

" tab sizes and such
:set tabstop=2
:set shiftwidth=2
:set expandtab

syntax on
set number relativenumber
colorscheme default

let mapleader="\<Space>"

" general convenience mappings tailored to me
nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>fd :filetype detect<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" for managing opening of files (fzf)
map <silent> <F2> :Files<CR>
map <silent> <F3> :Buffers<CR>
map <silent> <F4> :Marks<CR>
map <silent> <F5> :Rg<CR>

" coc stuff
:nmap <space>e <Cmd>CocCommand explorer<CR>

" visual cue for seeing which split you're in
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

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

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'

" js / ts stuff
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'posva/vim-vue'

" code completion and language servers
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" code completion extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-vetur', 'coc-explorer']
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" language specific sections
" Go
autocmd Filetype go setlocal tabstop=8
autocmd Filetype go setlocal shiftwidth=8
autocmd Filetype go setlocal expandtab!

map <leader>gi <Esc>:GoImplements<CR>
map <leader>gf <Esc>:GoReferrers<CR>
map <leader>gr <Esc>:GoRename<CR>
map <leader>gd <Esc>:GoDef<CR>
map <leader>gb <Esc>:GoBuild<CR>
map <leader>gt <Esc>:GoTest<CR>
map <leader>doc <Esc>:GoDoc<CR>

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" prettier:
" autocmd InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync

" vim-vue
" hard coded list of pre-processors to help speed up vim-vue rather than it
" self detecting
let g:vue_pre_processors = ['typescript', 'stylus']

" nnn config
" Floating window. This is the default
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Comment' } }
