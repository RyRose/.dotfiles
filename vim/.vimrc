" Required Settings {{{
set nocompatible
set encoding=utf-8
"}}}

"https://github.com/junegunn/vim-plug {{{

" Automatic installation {{{
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" Plugins {{{
call plug#begin('~/.vim/plugged')

"https://github.com/google/vim-codefmt {{{

Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'pedrohdz/vim-yaml-folds'

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType vue AutoFormatBuffer prettier
augroup END

"}}}

call plug#end()
"}}}

"}}}

" General Settings {{{

filetype plugin indent on
syntax on
set belloff=all

" Whitespace {{{
" Remove trailing whitespace automatically on save. Taken from
" https://vim.fandom.com/wiki/Remove_unwanted_spaces.
autocmd BufWritePre * %s/\s\+$//e
" }}}

" Fold settings {{{
" Default to foldmethod=syntax except use markers for the vimrc so triple
" braces are handled correctly.
set foldmethod=syntax
set nofoldenable
au BufRead .vimrc :setlocal foldmethod=marker
au BufRead .vimrc :setlocal foldenable
"}}}

"Fix the staring inconsistency {{{
nmap Y y$
" }}}

" Good Description at http://dougblack.io/words/a-good-vimrc.html {{{
set cursorline
set number
set relativenumber
set showmode
set wildmenu
"}}}

" Set lazydraws so that rendering is much faster during macros {{{
set lazyredraw
"}}}

" A few search related options"{{{
nnoremap <leader><leader> :nohlsearch<CR>
set gdefault
set hlsearch
set incsearch
"}}}

" Next a few indentation options"{{{
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
"}}}

" Viminfo Settings"{{{
" I like a nice, large Vim info
" '1000 save history for 1000 files
" f1 save marks
" <500 save at most 500 lines in any yank
" 	which is saved
" /1000 save 1000 lines from command history
set viminfo='1000,f1,<500,:1000,/1000
" set bash history to at most 500 lines in
" the vim session (different from viminfo
set history=500
""}}}

" Vim sessionoptions"{{{
" really awesome
" add resize to the list, so that my resizing
" of various windows is preserved
set sessionoptions+=resize
"}}}

" Some particulars about commands and Completion {{{
set showcmd
" }}}

" Spell-check Markdown files and Git Commit Messages {{{
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell
" }}}

" Enable dictionary auto-completion in Markdown files and Git Commit Messages {{{
autocmd FileType markdown setlocal complete+=kspell
autocmd FileType gitcommit setlocal complete+=kspell
" }}}

" https://vim.fandom.com/wiki/Highlight_unwanted_spaces {{{
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" }}}

"}}}

" Project-specific vimrc config options. Must be at end of file! {{{
" Enable project-specific .vimrc.
set exrc
" Prevent insecure commands being ran in project-specific .vimrc.
set secure
" }}}
