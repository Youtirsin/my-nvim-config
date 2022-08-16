" regular options
set cmdheight=2
set fileencoding=utf-8
set encoding=utf-8
set hlsearch
set ignorecase
set mouse=a
set pumheight=10
set showmode
set showtabline=2
set smartcase
set smartindent
set splitbelow
set splitright
set updatetime=300
set expandtab
set shiftwidth=2
set tabstop=2
set cursorline
set number
set numberwidth=4
set nowrap
set scrolloff=8
set sidescrolloff=8
syntax on

" key maps
" leader key 
map <space> <Nop>
let g:mapleader = " "  
let g:maplocalleader = " "  

" better window navigation
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k

" resize with arrows
nmap <c-up> :resize -2<CR>
nmap <c-down> :resize +2<CR>
nmap <c-left> :vertical resize -2<CR>
nmap <c-right> :vertical resize +2<CR>

" stay in indent mode
vmap "<" "<gv"
vmap ">" ">gv"

" move text up and down
nmap <a-j> <Esc>:m .+1<CR>
nmap <a-k> <Esc>:m .-2<CR>

" move text up and down
vmap <a-j> :m .+1<CR>
vmap <a-k> :m .-2<CR>

call plug#begin()

Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}		" coc
Plug 'https://github.com/rafi/awesome-vim-colorschemes'								" themes
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }                    " themes
Plug 'https://github.com/vim-airline/vim-airline'                     " vim airline
Plug 'vim-airline/vim-airline-themes'                                 " vim airline themes
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}           " tree-sitter
Plug 'voldikss/vim-floaterm'                                          " vim-term
Plug 'numToStr/Comment.nvim'                                          " for comment
Plug 'https://github.com/airblade/vim-gitgutter'                      " git
Plug 'nvim-lua/plenary.nvim'                                          " telescope dependency
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }           " telescope

call plug#end()

" colorschemes
colorscheme tokyonight

" airline theme
let g:airline#extensions#tabline#enabled    = 1
let g:airline#extensions#tabline#formatter  = 'unique_tail'

" vim-term configuration
" keymaps
let g:floaterm_keymap_new     = '<Leader>tn'
let g:floaterm_keymap_prev    = '<F7>'
let g:floaterm_keymap_next    = '<F8>'
let g:floaterm_keymap_toggle  = '<Leader>tt'
" for windows
" let g:floaterm_shell          = 'powershell'
let g:floaterm_wintype        = 'split'
let g:floaterm_height         = 0.4

" vim gitgutter
" This path probably won't work
" let g:gitgutter_git_executable = 'C:\Program Files\Git\bin\git.exe'

" telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" treesitter
" used embedded lua
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "python", "javascript", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
require('Comment').setup()
EOF

" coc configurations
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ CheckBackspace() ? "\<TAB>" :
"      \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! CheckBackspace() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" use <alt-/> to trigger completion
if has('nvim')
  inoremap <silent><expr> <a-/> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" coc-plugin configurations
" coc-explorer
nmap <leader>e <Cmd>CocCommand explorer<CR>
