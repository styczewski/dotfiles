"  ____                    _ ____  _    _
" |  _ \ __ ___      _____| / ___|| |  | |
" | |_) / _` \ \ /\ / / _ \ \___ \| |/ / |
" |  __/ (_| |\ V  V /  __/ |___) |   <| |
" |_|   \__,_| \_/\_/ \___|_|____/|_|\_\_|
" Zoptymalizowana wersja: 2024

" Vim-plug initialization {{{
let vim_plug_just_installed = 0
let g:netrw_browsex_viewer="feh"
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif
" }}}

" Active plugins {{{
call plug#begin('~/.vim/plugged')

" Wygląd
Plug 'lifepillar/vim-gruvbox8'
Plug 'romainl/Apprentice'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" FZF - Ładowane na żądanie
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'on': ['Files', 'GFiles', 'Buffers', 'History', 'Ag', 'Rg', 'FZFLines'] }
Plug 'chengzeyi/fzf-preview.vim', { 'on': 'FzfPreviewProjectFiles' }

" Narzędzia tekstowe i edycja
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring'
"Plug 'preservim/nerdcommenter'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'easymotion/vim-easymotion', { 'on': ['<Plug>(easymotion-prefix)', '<Plug>(easymotion-s)'] }
Plug 'kshenoy/vim-signature'
Plug 'vim-scripts/VisIncr', { 'on': 'VisIncr' }
Plug 'navicore/vissort.vim'
Plug 'markonm/traces.vim' " Dynamiczne podglądanie search/replace (bardzo wydajne)
Plug 'dkarter/bullets.vim'

" Języki i formaty
Plug 'vimwiki/vimwiki', { 'for': 'vimwiki' }
Plug 'preservim/vim-markdown', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': ['markdown', 'pandoc'] }
Plug 'lilydjwg/colorizer', { 'on': 'ColorHighlight' }

" Snippets
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
let g:snipMate = { 'snippet_version' : 1 }
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

" Inne
Plug 'sk1418/HowMuch', { 'on': 'HowMuch' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'vim-scripts/IndexedSearch'
Plug 'vim-scripts/DrawIt', { 'on': 'DrawIt' }

call plug#end()

if vim_plug_just_installed
    :PlugInstall
endif
" }}}

" Główne ustawienia {{{
set nocompatible
filetype plugin indent on
syntax on

set encoding=utf-8
set background=dark
silent! colorscheme gruvbox8_soft

" Wydajność UI
set lazyredraw            " Nie odświeżaj ekranu podczas makr
set ttyfast               " Szybsze przesyłanie znaków do terminala
set updatetime=300        " Szybsza reakcja wtyczek (default 4000ms)
set shortmess+=c          " Mniej komunikatów w linii komend

" Edycja i formatowanie
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=140
set wrap
set linebreak
set autoindent
set hidden                " Pozwala na ukrywanie buforów bez zapisu

" Wyszukiwanie
set incsearch
set nohlsearch
set ignorecase
set smartcase

" Interfejs
set number
set relativenumber
set laststatus=2
set wildmenu
set confirm
set splitbelow splitright
set scrolloff=0           " Brak marginesu przy przewijaniu
set list
set listchars=tab:▒░,trail:▓,nbsp:░

" Foldery systemowe (automatyczne tworzenie)
set directory=~/.vim/dirs/tmp
set backupdir=~/.vim/dirs/backups
set undodir=~/.vim/dirs/undos
set undofile
set backup

for d in [&directory, &backupdir, &undodir]
    if !isdirectory(d) | call mkdir(d, "p") | endif
endfor
" }}}

" Easymotion {{{
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" s{char} to move to {char}
map <Leader>s <Plug>(easymotion-s)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Easy line wrapping
imap gq <ESC>gw}0A
nnoremap <leader>gq vipgq

let g:bullets_enabled_filetypes = ['markdown', 'text', 'gitcommit']
let g:bullets_outline_levels = ['num', 'abc', 'std-', 'std*', 'std+']

let g:EasyMotion_startofline = 1 " keep cursor column when JK motion
map  <leader>/ <Plug>(easymotion-sn)
omap <leader>/ <Plug>(easymotion-tn)
" }}}

" Autokomendy (Optymalizacja: użycie augroup) {{{
augroup MyCustomAutocmds
    autocmd!
    " PDF i DOC
    autocmd BufReadPost *.pdf silent set ro | silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
    autocmd BufReadPost *.doc set ro | %!antiword "%"
    
    " Typy plików
    autocmd FileType html,javascript,htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
    
    " OmniCompletion
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType markdown setlocal formatoptions=jcroqlnt
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    
    " Dynamiczny Showbreak
    autocmd OptionSet number if v:option_new | set showbreak= | else | set showbreak=↳ | endif
augroup END
" }}}

" Funkcje pomocnicze {{{
function! WriteBackup()
    let _modified = &modified
    let fname = expand("%:p:r") . "." . strftime("%Y%m%d-%H%M%S") . "_bck." . expand("%:e")
    execute "silent w " . fnameescape(fname)
    let &modified = _modified
    echo "Backup zapisany: " . fname
endfunction

function! ToggleHiddenAll()
    if !exists('s:hidden_all') | let s:hidden_all = 0 | endif
    if s:hidden_all == 0
        let s:hidden_all = 1
        set noshowmode noruler nonumber norelativenumber laststatus=0 noshowcmd
    else
        let s:hidden_all = 0
        set showmode ruler number relativenumber laststatus=2 showcmd
    endif
endfunction
" }}}

" Easymotion {{{
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" s{char} to move to {char}
map <Leader>s <Plug>(easymotion-s)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

let g:EasyMotion_startofline = 1 " keep cursor column when JK motion
map  <leader>/ <Plug>(easymotion-sn)
omap <leader>/ <Plug>(easymotion-tn)
" }}}

" Mapowania {{{
let mapleader = "\<Space>"

" Zamiana : i ; (szybszy dostęp do komend)
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Systemowy schowek (wymaga xsel)
nnoremap <c-p> :r !xsel -b<CR>
vmap <c-c> :w !xsel -i -b<CR><CR>

" Backup i ustawienia
nnoremap <C-S-b> :call WriteBackup()<CR>
nnoremap <leader>rvim :source $MYVIMRC<CR>
nnoremap <leader>vim :e $MYVIMRC<CR>

" Nawigacja i okna
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tt :tabnew<CR>
nnoremap <S-h> :call ToggleHiddenAll()<CR>

" przesuwanie linii oraz dodawanie nowych
no <C-k> ddkP
no <C-j> ddp
no <C-l> o<ESC>k
no <C-h> O<ESC>j

"macro
nnoremap Q @q
vmap Q ;norm @q<CR>
nnoremap K @k
vmap K ;norm @k<CR>
nnoremap U @u
vmap U ;norm @u<CR>

"nawigacja w zawijanych wierszach
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

" Rozmiar okien (strzałki)
nnoremap <left>  :3wincmd <<cr>
nnoremap <right> :3wincmd ><cr>
nnoremap <up>    :3wincmd +<cr>
nnoremap <down>  :3wincmd -<cr>

" usuń polskie znaki z linii lub całego pliku - zależne od 'tpope/vim-abolish'
nmap <leader>ą ;S/{ą,ż,ś,ź,ę,ć,ń,ó,ł,Ą,Ż,Ś,Ź,Ę,Ć,Ń,Ó,Ł}/{a,z,s,z,e,c,n,o,l,A,Z,S,Z,E,C,N,O,L}/g<CR>
nmap <leader>Ą ;%S/{ą,ż,ś,ź,ę,ć,ń,ó,ł,Ą,Ż,Ś,Ź,Ę,Ć,Ń,Ó,Ł}/{a,z,s,z,e,c,n,o,l,A,Z,S,Z,E,C,N,O,L}/g<CR>

" zakmnij bufor pliku
nnoremap <leader>x :close<CR>

" zmień katalog pracy
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" FZF mappings
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>o :FZF<CR>

augroup MarkdownLists
    autocmd!
    " n - rozpoznawanie list numerowanych podczas formatowania
    " r - automatyczne wstawianie lidera listy po Enter w trybie Insert
    " o - automatyczne wstawianie lidera po O lub o w trybie Normal
    " q - umożliwienie formatowania komentarzy/list za pomocą gq
    autocmd FileType markdown setlocal formatoptions+=nroq

    " Definicja wyglądu listy numerowanej (opcjonalne, pomaga przy wcięciach)
    autocmd FileType markdown setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+
augroup END

" TEO Syntax / Kolorowanie (vnoremapy zachowane z oryginału)
" Integracja kolorów z vim-surround dla Markdown
augroup MarkdownSurround
    autocmd!
    " Definicje skrótów: S + litera koloru w trybie wizualnym
    autocmd FileType markdown let b:surround_{char2nr('r')} = ">R\rR<"
    autocmd FileType markdown let b:surround_{char2nr('b')} = ">B\rB<"
    autocmd FileType markdown let b:surround_{char2nr('g')} = ">G\rG<"
    autocmd FileType markdown let b:surround_{char2nr('y')} = ">Y\rY<"
    autocmd FileType markdown let b:surround_{char2nr('p')} = ">P\rP<"
    autocmd FileType markdown let b:surround_{char2nr('o')} = ">O\rO<"
    autocmd FileType markdown let b:surround_{char2nr('R')} = ">tR\rRt<"
    autocmd FileType markdown let b:surround_{char2nr('B')} = ">tB\rBt<"
    autocmd FileType markdown let b:surround_{char2nr('G')} = ">tG\rGt<"
    autocmd FileType markdown let b:surround_{char2nr('Y')} = ">tY\rYt<"
    autocmd FileType markdown let b:surround_{char2nr('P')} = ">tP\rPt<"
    autocmd FileType markdown let b:surround_{char2nr('O')} = ">tO\rOt<"
augroup END

" Ustawienia specyficzne dla wtyczki preservim/vim-markdown
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_syntax_conceal = 1

augroup MarkdownColors
    autocmd!
    " Ustawiamy poziom ukrywania bezpośrednio dla plików markdown
    autocmd FileType markdown setlocal conceallevel=2
    autocmd FileType markdown setlocal concealcursor=c

    " 1. Twoje kolory specjalne (>R ... R<)
    "
    autocmd FileType markdown syntax region textred matchgroup=Conceal start=">R" end="R<" containedin=ALL concealends
    autocmd FileType markdown syntax region textblue matchgroup=Conceal start=">B" end="B<" containedin=ALL concealends
    autocmd FileType markdown syntax region textgreen matchgroup=Conceal start=">G" end="G<" containedin=ALL concealends
    autocmd FileType markdown syntax region textyellow matchgroup=Conceal start=">Y" end="Y<" containedin=ALL concealends
    autocmd FileType markdown syntax region textpink matchgroup=Conceal start=">P" end="P<" containedin=ALL concealends
    autocmd FileType markdown syntax region textorange matchgroup=Conceal start=">O" end="O<" containedin=ALL concealends
    autocmd FileType markdown syntax region hired matchgroup=Conceal start=">tR" end="Rt<" containedin=ALL concealends
    autocmd FileType markdown syntax region hiblue matchgroup=Conceal start=">tB" end="Bt<" containedin=ALL concealends
    autocmd FileType markdown syntax region higreen matchgroup=Conceal start=">tG" end="Gt<" containedin=ALL concealends
    autocmd FileType markdown syntax region hiyellow matchgroup=Conceal start=">tY" end="Yt<" containedin=ALL concealends
    autocmd FileType markdown syntax region hipink matchgroup=Conceal start=">tP" end="Pt<" containedin=ALL concealends
    autocmd FileType markdown syntax region hiorange matchgroup=Conceal start=">tO" end="Ot<" containedin=ALL concealends

    " 2. Definicja nagłówków z wymuszeniem priorytetu
    " Używamy 'syntax region', bo jest 'silniejszy' od 'match'
    autocmd FileType markdown syntax region myH1 start=/^#\s/ end=/$/ oneline containedin=ALL
    autocmd FileType markdown syntax region myH2 start=/^##\s/ end=/$/ oneline containedin=ALL
    autocmd FileType markdown syntax region myH3 start=/^###\s/ end=/$/ oneline containedin=ALL
    autocmd FileType markdown syntax region myH4 start=/^####\s/ end=/$/ oneline containedin=ALL
    autocmd FileType markdown syntax region myH5 start=/^#####\s/ end=/$/ oneline containedin=ALL
    autocmd FileType markdown syntax region myH6 start=/^######\s/ end=/$/ oneline containedin=ALL

    " 3. Przypisanie barw (hi! z wykrzyknikiem jest kluczowe)
    autocmd FileType markdown hi! myH1 ctermfg=167 guifg=#fb4934 gui=bold  " Czerwony
    autocmd FileType markdown hi! myH2 ctermfg=208 guifg=#fe8019 gui=bold  " Pomaranczowy
    autocmd FileType markdown hi! myH3 ctermfg=214 guifg=#fabd2f gui=bold  " Zólty
    autocmd FileType markdown hi! myH4 ctermfg=142 guifg=#b8bb26 gui=bold  " Zielony
    autocmd FileType markdown hi! myH5 ctermfg=109 guifg=#83a598 gui=bold  " Niebieski
    autocmd FileType markdown hi! myH6 ctermfg=175 guifg=#d3869b gui=bold  " Fioletowy Rózowy

    " 1. Definicja dopasowania: linia zaczynająca się od %%
    autocmd FileType markdown syntax match mkdComment /^%%.*/ containedin=ALL

    " 2. Przypisanie koloru: użycie standardowej grupy Comment (zazwyczaj szary/stonowany)
    " Możesz też przypisać własny kolor hex, jeśli wolisz.
    autocmd FileType markdown hi! link mkdComment Comment

augroup END

" Zmiana poziomu nagłówka w Markdown
augroup MarkdownHeadingShift
    autocmd!
    " Zwiększ poziom (dodaj #) - klawisz =
    autocmd FileType markdown nnoremap <buffer> = :s/^\(#*\)/\1#/ <Bar> :nohlsearch<CR>

    " Zmniejsz poziom (usuń #) - klawisz -
    autocmd FileType markdown nnoremap <buffer> - :s/^#// <Bar> :nohlsearch<CR>
augroup END

" Definicje kolorów 
hi textred ctermfg=red guifg=#ff0000
hi textblue ctermfg=74 guifg=#5fafd7
hi textgreen ctermfg=green guifg=#00ff00
hi textyellow ctermfg=yellow guifg=#ffff00
hi textpink ctermfg=98 guifg=#875faf
hi textorange ctermfg=166 guifg=#d75f00

hi hired    ctermfg=0 ctermbg=167 guifg=#000000 guibg=#fb4934
hi hiblue   ctermfg=0 ctermbg=109 guifg=#000000 guibg=#83a598
hi higreen  ctermfg=0 ctermbg=142 guifg=#000000 guibg=#b8bb26
hi hiyellow ctermfg=0 ctermbg=214 guifg=#000000 guibg=#fabd2f
hi hipink   ctermfg=0 ctermbg=175 guifg=#000000 guibg=#d3869b
hi hiorange ctermfg=0 ctermbg=208 guifg=#000000 guibg=#fe8019

" Szybki Python
augroup PythonRun
    autocmd FileType python nnoremap <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
augroup END
" }}}

" Airline Config {{{
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
" }}}

" vim:foldmethod=marker:foldlevel=0
