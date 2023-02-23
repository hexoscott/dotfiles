
colorscheme desert

set ignorecase
set smartcase
set incsearch
set cursorline
set mouse=a

" tab sizes and such
:set tabstop=2
:set shiftwidth=2
:set expandtab

set number relativenumber

" colours
hi CursorLine cterm=NONE ctermbg=240
hi MatchParen cterm=none ctermbg=green ctermfg=blue

let mapleader="\<Space>"

" general convenience mappings tailored to me
nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>fd :filetype detect<CR>
" only scroll 1/4 of the page instead of half
nnoremap <expr> <C-d> (winheight(0) / 4) . '<C-d>'
nnoremap <expr> <C-u> (winheight(0) / 4) . '<C-u>'

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" splits
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" close buffers
noremap <leader>c :bd<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>b :Telescope file_browser<cr>
nnoremap <leader>B :Telescope file_browser path=%:p:h select_buffer=true<cr>

" ripgrep command control
set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
let g:rg_derive_root='true'

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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

" general text plugins and navigation plugins
Plug 'townk/vim-autoclose'
Plug 'justinmk/vim-sneak'

" language specific plugins
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'OmniSharp/omnisharp-vim'

Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'

" js / ts stuff
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'leafOfTree/vim-vue-plugin'

" code completion and language servers
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let g:airline_theme='bubblegum'

" code completion extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-vetur', 'coc-prettier', '@yaegassy/coc-volar']
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

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
map <leader>go <Esc>:GoDoc<CR>

" go debugging stuff
let g:go_debug_mappings = {
      \ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
      \ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
      \ '(go-debug-step)': {'key': 's'},
      \ '(go-debug-print)': {'key': 'p'},
  \}
autocmd Filetype go map <leader>ds :GoDebugStart<cr>
autocmd Filetype go map <leader>dt :GoDebugStop<cr>
autocmd Filetype go map <leader>db :GoDebugBreakpoint<cr>

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" C#
let g:OmniSharp_selector_findusages = 'fzf'

" vim-vue
" hard coded list of pre-processors to help speed up vim-vue rather than it
" self detecting
let g:vue_pre_processors = ['typescript', 'stylus']

" nnn config
" Floating window. This is the default
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Comment' } }

" lua config for telescope
lua << EOF
local fb_actions = require "telescope._extensions.file_browser.actions"

require("telescope").setup {
  extensions = {
    file_browser = {
      -- path
      -- cwd
      cwd_to_path = false,
      grouped = false,
      files = true,
      add_dirs = true,
      depth = 1,
      auto_depth = false,
      select_buffer = false,
      hidden = false,
      -- respect_gitignore
      -- browse_files
      -- browse_folders
      hide_parent_dir = false,
      collapse_dirs = false,
      quiet = false,
      dir_icon = "",
      dir_icon_hl = "Default",
      display_stat = { date = true, size = true },
      hijack_netrw = false,
      use_fd = true,
      git_status = true,
      mappings = {
        ["i"] = {
          ["<A-c>"] = fb_actions.create,
          ["<S-CR>"] = fb_actions.create_from_prompt,
          ["<A-r>"] = fb_actions.rename,
          ["<A-m>"] = fb_actions.move,
          ["<A-y>"] = fb_actions.copy,
          ["<A-d>"] = fb_actions.remove,
          ["<C-o>"] = fb_actions.open,
          ["<C-g>"] = fb_actions.goto_parent_dir,
          ["<C-e>"] = fb_actions.goto_home_dir,
          ["<C-w>"] = fb_actions.goto_cwd,
          ["<C-t>"] = fb_actions.change_cwd,
          ["<C-f>"] = fb_actions.toggle_browser,
          ["<C-h>"] = fb_actions.toggle_hidden,
          ["<C-s>"] = fb_actions.toggle_all,
        },
        ["n"] = {
          ["c"] = fb_actions.create,
          ["r"] = fb_actions.rename,
          ["m"] = fb_actions.move,
          ["y"] = fb_actions.copy,
          ["d"] = fb_actions.remove,
          ["o"] = fb_actions.open,
          ["g"] = fb_actions.goto_parent_dir,
          ["e"] = fb_actions.goto_home_dir,
          ["w"] = fb_actions.goto_cwd,
          ["t"] = fb_actions.change_cwd,
          ["f"] = fb_actions.toggle_browser,
          ["h"] = fb_actions.toggle_hidden,
          ["s"] = fb_actions.toggle_all,
        },
      },
    },
  },
}

require("telescope").load_extension "file_browser"
EOF
