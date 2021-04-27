
" Install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'           " Show sign column for git diff
Plug 'bogado/file-line'                 " Open files using foo.rb:42 syntax
Plug 'elixir-lang/vim-elixir'           " Elixir support
Plug 'garbas/vim-snipmate'              " Insert snippets using tab
Plug 'janko-m/vim-test'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf'                     " Basic fzf wrapper
Plug 'junegunn/fzf.vim'                 " Fuzzy file finder
Plug 'junegunn/goyo.vim'                " Distraction free writing
Plug 'kassio/neoterm'
Plug 'kchmck/vim-coffee-script'         " Coffeescript syntax higlighting
Plug 'leafgarland/typescript-vim'       " Typescript syntax highlighting
Plug 'MarcWeber/vim-addon-mw-utils'     " Needed by snipmate
Plug 'nanotech/jellybeans.vim'          " Jellybeans color scheme
Plug 'rizzatti/dash.vim'                " Documentation lookup using Dash.app
Plug 'terryma/vim-multiple-cursors'     " Sublime text style multiple cursors
Plug 'thinca/vim-localrc'               " Add per project vimrc files
Plug 'tomtom/tlib_vim'                  " Needed by snipmate
Plug 'Townk/vim-autoclose'              " Insert matching pair () {} []
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'             " Toggle comments easily
Plug 'tpope/vim-endwise'                " Add end after ruby blocks
Plug 'tpope/vim-fugitive'               " Git wrapper
Plug 'tpope/vim-rails'                  " Rails support
Plug 'tpope/vim-rhubarb'                " Needed by fugitive for Gbrowse
Plug 'tpope/vim-surround'               " Easily change quotes/bracket pairs
Plug 'tpope/vim-unimpaired'             " Misc mappings like ]<space> or ]c
Plug 'vim-airline/vim-airline'
Plug 'vim-ruby/vim-ruby'                " Ruby support

call plug#end()

colorscheme jellybeans

set autoindent                  " Indent: Copy indent from current line when starting new line
set expandtab                   " Tab settings - Use spaces to insert a tab
set backupdir=~/.vim/tmp        " Don't clutter my dirs with swp/tmp files
set colorcolumn=80,120          " Show vertical bar to indicate 80/120 chars
set directory=~/.tmp            " Don't clutter my dirs with swp/tmp files
set fillchars+=vert:│           " Make vertical separator a continuous line
set grepprg=rg\ --vimgrep       " Use ripgrep for file search
set hlsearch                    " Search: Highlight results
set ignorecase smartcase        " Search: ignore case, unless uppercase chars given
set incsearch                   " Search: Show results as you type
set laststatus=2                " Always show status line
set list                        " Show tabs and trailing whitespace
set listchars=tab:>-,trail:·    " Set chars to show for tabs or trailing whitespace
set nofoldenable                " Disable code folding
set relativenumber number       " Line numbers: Show current #, but use relative #s elsewhere
set rtp+=/usr/local/opt/fzf     " Set fzf path
set shiftround                  " Indentation: When at 3 spaces, >> takes to 4, not 5
set shiftwidth=2                " Tab settings - Use 2 spaces for each indent level
set softtabstop=2               " Tab settings - Count 2 spaces in editing operations
set splitbelow                  " Open new split panes below
set splitright                  " Open new split panes to the right
set t_Co=256                    " Use 256 colors in tmux
set tags=$HOME/.tags_cache      " Keep tags file in a single place
set updatetime=100              " Gitgutter waits this long to update hunk markers
set wildmode=list:full          " Command mode tab completion - complete upto ambiguity


" Enable extended matching with %
runtime macros/matchit.vim

" Hide ~ in line number columns after end of buffer
highlight EndOfBuffer ctermfg=bg

let g:markdown_fenced_languages = ['ruby', 'elixir']
let g:markdown_minlines = 100

" Run tests in vertical neoterm pane
let g:neoterm_default_mod = 'vertical'
let test#strategy = 'neoterm'

if filereadable('dev.yml')
  let test#ruby#rails#executable = 'dev test'
endif

let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_removed = '•'
let g:gitgutter_sign_removed_first_line = '•↑'
let g:gitgutter_sign_modified_removed = '•'

hi DiffAdd    ctermfg=148 ctermbg=NONE cterm=bold guifg=#f8f8f2 guibg=#46830c gui=bold
hi DiffDelete ctermfg=197 ctermbg=NONE cterm=bold guifg=#8b0807 guibg=NONE    gui=NONE
hi DiffChange ctermfg=208 ctermbg=NONE cterm=bold guifg=#f8f8f2 guibg=#243955 gui=NONE
hi DiffText   ctermfg=231 ctermbg=24   cterm=bold guifg=#f8f8f2 guibg=#204a87 gui=bold

" Status line
" set statusline=
" set statusline+=\ %{fugitive#head()}\ #
" set statusline+=\ %f
" set statusline+=%=\ %y\ %l,%c\ %L


" Create a directory for the current file if it does not exist.
augroup Mkdir
  autocmd!
  autocmd BufWritePre *
    \ if !isdirectory(expand("<afile>:p:h")) |
        \ call mkdir(expand("<afile>:p:h"), "p") |
    \ endif
augroup END

" Make sorbet sigs look like comments
augroup format_ruby
  autocmd Syntax ruby syn region sorbetSig start='sig {' end='}'
  autocmd Syntax ruby hi def link sorbetSig Comment

  autocmd Syntax ruby syn region sorbetSigDo start='sig do' end='end'
  autocmd Syntax ruby hi def link sorbetSigDo Comment
augroup END

" Rebalance panes on resize
autocmd VimResized * :wincmd =


function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction


" Used in Snipmate
fun! SnippetFilename(...)
  let template = get(a:000, 0, "$1")
  let arg2 = get(a:000, 1, "")

  let basename = expand('%:t:r')

  if basename == ''
    return arg2
  else
    return substitute(template, '$1', basename, 'g')
  endif
endf


noremap  Q  @q

nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

map  <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Disable arrow keys
map  <up>    <nop>
imap <up>    <nop>
map  <down>  <nop>
imap <down>  <nop>
map  <left>  <nop>
imap <left>  <nop>
map  <right> <nop>
imap <right> <nop>

" I often mistype Q and Wq
command! Q  q
command! Wq wq

noremap <silent> j gj
noremap <silent> k gk

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" Leader key settings

let mapleader = ","

noremap  <leader>,    :Files<cr>
noremap  <leader>.    :w<cr>:TestLast<cr>
noremap  <leader>bb   :Buffers<cr>
noremap  <leader>bi   :source ~/.vimrc<cr>:PlugInstall<cr>
noremap  <leader>dd   :Dash<cr>
noremap  <leader>ff   :Rg<space>
noremap  <leader>fw   :Rg <C-r><C-w>
noremap  <leader>gbl  :Gblame<cr>
noremap  <leader>gbr  :Gbrowse<cr>
noremap  <leader>gg   :tabe ~/Dropbox/scratchpad.md<cr>
noremap  <leader>ghp  :!/opt/dev/bin/dev open pr &<cr><cr>
noremap  <leader>ghs  :GitGutterStageHunk<cr>
noremap  <leader>ghu  :GitGutterUndoHunk<cr>
noremap  <leader>gs   :Gstatus<cr>
noremap  <leader>mv   :call RenameFile()<cr>
noremap  <leader>nh   :nohl<cr>
noremap  <leader>o    :only<cr>
noremap  <leader>pp   "+p
noremap  <leader>q    :bd<cr>
noremap  <leader>rc   :Econtroller
noremap  <leader>rm   :!rm %
noremap  <leader>rv   :Eview
noremap  <leader>s    :A<cr>
noremap  <leader>tc   :Tclear<cr>
noremap  <leader>tf   :w<cr>:TestFile<cr>
noremap  <leader>tl   :w<cr>:T dev test --include-branch-commits<cr>
noremap  <leader>tn   :w<cr>:TestNearest<cr>
noremap  <leader>to   :Ttoggle<cr>
noremap  <leader>ts   :w<cr>:TestSuite<cr>
noremap  <leader>tt   :w<cr>:TestLast<cr>
noremap  <leader>ty   :w<cr>:T dev typecheck<cr>
noremap  <leader>vi   :tabe ~/.vimrc<cr>
noremap  <leader>vv   :vnew<cr>
vnoremap <leader>yy   "+y

if has('nvim')
  tnoremap <C-o> <C-\><C-n>

  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  tnoremap <leader>q  <C-\><C-n>:Ttoggle<cr>
endif
