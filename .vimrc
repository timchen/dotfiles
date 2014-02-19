set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

""" let Vundle manage Vundle
Bundle 'gmarik/vundle'

""" vundles
Bundle 'tpope/vim-sensible.git'
Bundle 'kien/ctrlp.vim'

Bundle 'kchmck/vim-coffee-script'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-rails'
Bundle 'rodjek/vim-puppet.git'
Bundle 'elzr/vim-json.git'

filetype plugin indent on

syntax enable         " Turn on syntax highlighting allowing local overrides
set background=dark
let g:solarized_contrast = "high"
let g:solarized_visibility = "normal"
colorscheme solarized

""" basic stuff
set number            " Show line numbers
set ruler             " Show line and column number
set encoding=utf-8    " Set default encoding to UTF-8
set cul
set nowrap                        " don't wrap lines
set backspace=indent,eol,start    " backspace through everything in insert mode

""" softtabs, 2 spaces
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs

""" list chars
set list                          " Show invisible characters
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

""" searching
set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

""" file-types to avoid opening
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=*.swp,*~,._*

""" backup and swap files
set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_tmp//      " where to put swap files.

""" line wrapping
let &colorcolumn="80,".join(range(120,999),",")
augroup vimrclinewrap
  " autocmd BufEnter * highlight OverLengthWarn ctermbg=yellow ctermfg=white guibg=#592929
  " autocmd BufEnter * match OverLengthWarn /\%80v.\+/
  autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  autocmd BufEnter *match OverLength /\%121v.\+/
augroup END

if has("gui_running")
  if has("autocmd")
    " Automatically resize splits when resizing MacVim window
    autocmd VimResized * wincmd =
  endif
endif

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

""" syntax stuff
let g:html_indent_tags = 'li\|p' " treat <li> and <p> tags like the block tags they are
let g:syntastic_check_on_open=1 " configure syntastic syntax checking to check on open as well as save

""" status line
if has("statusline") && !&cp
  set laststatus=2  " always show the status bar
  set statusline=%f\ %m\ %r
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

""" use the silver searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

nnoremap <leader><leader> <c-^> " switch between the last two files

""" get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

""" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

""" auto re-load vimrc
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END
