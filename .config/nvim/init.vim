" == Plugins ==

" specify directory for plugins
call plug#begin('~/.config/nvim/plugged')

" appearance
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vim-airline/vim-airline'
Plug 'agude/vim-eldar'
Plug 'sainnhe/sonokai'

" latex
Plug 'lervag/vimtex'

" initialize plugin system
call plug#end()


" == Colors ==

syntax on		" syntax highlighting
" Important!!
if has('termguicolors')
	set termguicolors
endif
" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1
colorscheme sonokai 

" == Options ==
set number										" shows line numbers
set clipboard=unnamedplus						" enables clipboard between neovim and other applications
set completeopt=noinsert,menuone,noselect		" modifies the auto-complete menu to behave more like an IDE
set cursorline									" highlights the current line in the editor
set mouse=a										" allows the use of the mouse in the editor
set title										" show the file title
set wildmenu									" shows a more advanced menu for auto-completion suggestions

" == CHADTree
nnoremap <leader>v <cmd>CHADopen<cr>
let g:chadtree_settings = { 'ignore.name_glob':[".*"] }

" == VimTeX ==

" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'evince'
"let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
" let g:vimtex_compiler_method = 'latexrun'

" `update` ensures document is saved before single-shot compilation
noremap <leader>ll <Cmd>update<CR><Cmd>VimtexCompileSS<CR>

let g:vimtex_quickfix_ignore_filters = [
  \'Underfull \\hbox (badness [0-9]*) in ',
  \'Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in ',
  \'Package hyperref Warning: Token not allowed in a PDF string',
  \'Package typearea Warning: Bad type area settings!',
  \]
