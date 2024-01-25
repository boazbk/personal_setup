call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdtree' " File explorer
Plug 'itchyny/lightline.vim' " Status line
Plug 'morhetz/gruvbox' " Colorscheme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder
Plug 'powerman/vim-plugin-AnsiEsc'

call plug#end()

" Configuration

autocmd BufRead,BufNewFile *.log :AnsiEsc

" Enable syntax highlighting
syntax enable

" Set colorscheme to gruvbox
colorscheme gruvbox

" Map Ctrl-n to toggle NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Map Ctrl-p to call fzf
nnoremap <C-p> :FZF<CR>

filetype plugin indent on
set termguicolors
