call plug#begin('~/.config/nvim/plugged')

" Example plugins
Plug 'preservim/nerdtree' " File explorer
Plug 'itchyny/lightline.vim' " Status line
Plug 'morhetz/gruvbox' " Colorscheme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder

call plug#end()

" Configuration

" Enable syntax highlighting
syntax enable

" Set colorscheme to gruvbox
colorscheme gruvbox

" Map Ctrl-n to toggle NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Map Ctrl-p to call fzf
nnoremap <C-p> :FZF<CR>
