" == Plugins ==
" specify directory for plugins
call plug#begin('~/.config/nvim/plugged')

" appearance
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'} " folder structure 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " highlighting sintax
Plug 'vim-airline/vim-airline' " status line
Plug 'sainnhe/sonokai' " theme

" dev
Plug 'neoclide/coc.nvim', {'branch': 'release'} " code completion
Plug 'chrisbra/csv.vim' " csv support
Plug 'lervag/vimtex' " latex

" utils
Plug 'tpope/vim-commentary' " comment out lines
Plug 'leafOfTree/vim-project' " project management

call plug#end()

" == Theme ==
syntax on		" syntax highlighting
" Important!!
if has('termguicolors')
	set termguicolors
endif
" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'default'
let g:sonokai_better_performance = 1
let g:sonokai_transparent_background = 1
colorscheme sonokai 

" == general ==
set number										" shows line numbers
set clipboard=unnamedplus						" enables clipboard between neovim and other applications
set completeopt=noinsert,menuone,noselect		" modifies the auto-complete menu to behave more like an IDE
set cursorline									" highlights the current line in the editor
set mouse=a										" allows the use of the mouse in the editor
set title										" show the file title
set wildmenu									" shows a more advanced menu for auto-completion suggestions

" == CHADTree ==
nnoremap <leader>v <cmd>CHADopen<cr>
let g:chadtree_settings = { 'ignore.name_glob':[".*"] }

" == VimTeX ==
filetype plugin indent on
syntax enable
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'evince'
noremap <leader>ll <Cmd>update<CR><Cmd>VimtexCompileSS<CR>
let g:vimtex_quickfix_ignore_filters = [
  \'Underfull \\hbox (badness [0-9]*) in ',
  \'Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in ',
  \'Package hyperref Warning: Token not allowed in a PDF string',
  \'Package typearea Warning: Bad type area settings!',
  \]

" == coc ==
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" == vim-project ==
let g:vim_project_config = { 'project_base':['~/repository'] }
