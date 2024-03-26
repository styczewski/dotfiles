"  ____                    _ ____  _    _ 
" |  _ \ __ ___      _____| / ___|| | _(_)
" | |_) / _` \ \ /\ / / _ \ \___ \| |/ / |
" |  __/ (_| |\ V  V /  __/ |___) |   <| |
" |_|   \__,_| \_/\_/ \___|_|____/|_|\_\_|
" Ostatnia modyfikacja: czw, 11 sty 2024, 10:29:46 CET
" Vim-plug initialization {{{

let vim_plug_just_installed = 0
let g:netrw_browsex_viewer="feh"
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif
" }}}
" Active plugins {{{
call plug#begin('~/.vim/plugged')

" Plugins from github repos:
Plug 'lifepillar/vim-gruvbox8' "Colorsheme
Plug 'romainl/Apprentice'
Plug 'vim-airline/vim-airline-themes' " Airline
Plug 'vimwiki/vimwiki'
Plug 'sk1418/HowMuch'
Plug 'tyru/capture.vim'
Plug 'junegunn/fzf' , { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'chengzeyi/fzf-preview.vim'
Plug 'vim-airline/vim-airline' " Airline
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
  let g:snipMate = { 'snippet_version' : 1 }
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'godlygeek/tabular' "Tabularize
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround' " Surround
Plug 'scrooloose/nerdcommenter' " Code commenter
Plug 'easymotion/vim-easymotion'
Plug 'kshenoy/vim-signature'
"Plug 'DougBeney/pickachu'
Plug 'vim-scripts/VisIncr'
"Plug 'itchyny/calendar.vim'
Plug 'navicore/vissort.vim'
Plug 'lilydjwg/colorizer' " Paint css colors with the real color
Plug 'markonm/traces.vim'
Plug 'vim-scripts/AutoComplPop'
"Plug 'Valloric/YouCompleteMe'
Plug 'vim-scripts/MultipleSearch'
Plug 'guns/xterm-color-table.vim'
Plug 'tpope/vim-abolish'
Plug 'junegunn/goyo.vim'
Plug 'vim-scripts/DrawIt'


" Plugins from vim-scripts repos:
Plug 'vim-scripts/IndexedSearch' " Search results counter
"+ Plug 'vim-scripts/matchit.zip' " XML/HTML tags navigation
"+ Plug 'vim-scripts/Wombat' " Gvim colorscheme
" Plug 'vim-scripts/YankRing.vim' " Yank history navigation

" colorscheme
"let g:colors_name = "gruvbox8_hard"

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif
" }}}

" Schemat kolorów i tło {{{
colorscheme gruvbox8_soft
set background=dark

" zmiana koloru tła - jasne/ciemne
nmap <C-g> ;let &background = ( &background == "dark"? "light" : "dark" )<CR>
"}}}

fun! WriteBackup()
        let _modified = &modified
        let fname = expand("%:p:r") . "." . strftime("%Y%m%d-%H%M%S") . "." . expand("%:e")
        silent exe ":w " . fnameescape(fname)
        let &modified = _modified
        echo "Write " . fname
endfun
nnoremap <C-S-b> :call WriteBackup()<CR>

" automatyczne usuwanie spacji na końcach linii
"autocmd BufWritePre * :%s/\s\+$//ge

" PDF {{{
autocmd BufReadPre *.pdf silent set ro
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
"}}}

" Vim settings set... {{{
set nocompatible " no vi-compatible
set shortmess+=c
set wrap
set linebreak
set hidden
set list
set cm=blowfish2
set expandtab "tabs and spaces handling
set tabstop=4 "tabs and spaces handling
set softtabstop=4 "tabs and spaces handling
set shiftwidth=4 "tabs and spaces handling
set textwidth=140
set rtp+=~/.fzf "fuzzy finder
set ls=2 " always show status bar

" Enable CursorLine
" set cursorcolumn
" set cursorline
" set colorcolumn=80

set incsearch " incremental search
set nohlsearch " highlighted search results
set ignorecase " Ignoring case in a pattern
set smartcase " Ignoring case in a pattern
set number " show line numbers
set relativenumber "relative numbers
set splitbelow splitright
set completeopt=menuone,longest
set scrolloff=0 " when scrolling, keep cursor x lines away from screen border
set wildmenu " podpowiedzi dla komend systemowych i uzupełnianie nazw plików
set confirm " pytaj o potwierdzenie zamiast odmawiać wykonania operacji
set timeoutlen=1000 ttimeoutlen=0 " Eliminating delays on ESC in vim and
set showcmd

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo

syntax on " syntax highlight on

"set spelllang=pl "sprawdzanie pisowni
setlocal nospell
set complete+=kspell

" set listchars=tab:▸\ ,eol:¬,trail:_

" settings for hidden chars
set listchars=tab:▒░,trail:▓,nbsp:░
" \u2592\u2591 are used for tab, \u2593 for trailing spaces in line, and \u2591 for nbsp.
" In Vim help they suggest using ">-" for tab and "-" for trail.

" change showbreak when line numbers are on or off.
" show no char when line numbers are on, and \u21aa otherwise.
au OptionSet number :if v:option_new | set showbreak= |
                   \ else | set showbreak=↳ |
                   \ endif

set lazyredraw
" }}}
" Vim other settings {{{
"au BufWinLeave *.* mkview
"au BufWinEnter *.* silent loadview

" Pretty soft break character.
"let &showbreak='↳ '

" https://vim.fandom.com/wiki/View_and_diff_MS_Word_files
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

"}}}
" Moje własne mapowania {{{
" wstawianie z systemowego schowka
nmap ! ;wqa<CR>
nnoremap <c-p> :r !xsel -b<CR>
vmap <c-c> ;w !xsel -i -b<CR><CR>
imap <leader>pp ;r !xsel -o -b<CR>a
"vnoremap <silent> <c-x> y:new<cr>P:sil w !wl-copy<cr><cr>:q!<cr>
"vnoremap <c-x> y:new<cr>Pgg0vG$h<c-c>:q!<cr>
vnoremap <c-x> y:new<cr>p

" uruchamianie skryptu python
" nnoremap <C-p> :w:! clear; python3 %<cr>

" matematka
"ino <C-x> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" spacja nierozdzielająca
imap <C-Space>  

let mapleader = "\<Space>"
"let mapleader = ","
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap zl zL
nnoremap zh zH
vnoremap . <ESC>v)
vnoremap , (<ESC>v(
vnoremap n j<ESC>V
vnoremap m k<ESC>V
inoremap UU <Esc>hviWgUe
inoremap Uu <Esc>bviwgu~ea
inoremap uu <Esc>bviwguea
inoremap ąą <Esc>[sz=
nnoremap <leader>da :r! date '+\%Y-\%m-\%d'<CR>
nnoremap <leader>dda :r! date<CR>

" cofanie porcjami, dzięki utworzeniu break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
"inoremap <space> <space><c-g>u - niemożliwe z uwagi na abbreviations

" autouzupełnianie nawiasów i cudzysłowów
" inoremap '' ''<left>
" inoremap "" ""<left>
inoremap "" „”<left>
inoremap () ()<left>
inoremap [] []<left>
inoremap {} {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap <C-l> <ESC>la
inoremap <BS> <Nop>
inoremap <Del> <Nop>
nmap } }zt
nmap { {zt

" zapisz jako root
ca w!! w !sudo tee "%"

" wstaw numer linii do pliku
nmap <leader>linia ;%s/^/\=printf('%02d-', line('.'))<cr>

" zamknij inne zawinięcia poza bieżącym
nnoremap ,z zMzvzt

" wyśrodkowanie wyników wyszukiwania (rozwijanie zawinięć)
nnoremap n nzzzv
nnoremap N Nzzzv

" przesuwanie linii oraz dodawanie nowych
no <C-k> ddkP
no <C-j> ddp
no <C-l> o<ESC>k
no <C-h> O<ESC>j

" nawigacja w zakładkach
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>
nnoremap <leader>tm :tabm
nnoremap <leader>tt :tabnew<CR>
nnoremap <PageDown> :silent bn<CR> :redraw!<CR>
nnoremap <PageUp> :silent bp<CR> :redraw!<CR>

" podziel okno
nnoremap <leader>ts :new<CR>
nnoremap <leader>tv :vnew<CR>

" zmień podział ekranu z pionowego na poziomy
map <leader><right> <C-w>t<C-w>H
map <leader><down> <C-w>t<C-w>K

" zmiana rozmiaru podzielonych okien
nnoremap <left>  :3wincmd <<cr>
nnoremap <right> :3wincmd ><cr>
nnoremap <up>    :3wincmd +<cr>
nnoremap <down>  :3wincmd -<cr>

"autocmd FileType markdown nnoremap <leader>pan :w<cr>:!pandoc % --pdf-engine=lualatex --toc -V toc-title:"Spis treści" -V mainfont="calibri.ttf" -V colorlinks -V urlcolor=NavyBlue -o %:r.pdf <cr>
nnoremap <F2> :w<cr>:Vimwiki2HTML<CR>:! vim -s /home/pstyczewski/bin/vimcolorvimwiki.vim /home/pstyczewski/encfs/notes/wiki_html/%:r.html<CR>
nnoremap <F4> :w<cr>:Vimwiki2HTML<CR>:! vim -s /home/pstyczewski/bin/vimcolorvimwiki.vim /home/pstyczewski/encfs/notes/wiki_html/%:r.html<CR>:! chromium --headless --disable-gpu --print-to-pdf-no-header --print-to-pdf=/home/pstyczewski/Dokumenty/generowane-vimwiki/%:r.pdf /home/pstyczewski/encfs/notes/wiki_html/%:r.html<CR>:! zathura /home/pstyczewski/Dokumenty/generowane-vimwiki/%:r.pdf&<CR>

nmap <leader>rvim ;source ~/.vimrc<CR>
nmap <leader>vim ;e ~/.vimrc<CR>
nmap <leader>cfz ;e ~/.zshrc<CR>
nmap <leader>cfi ;e ~/.config/i3/config<CR>

" Dragvisuals
vnoremap <S-Right>  xpgvlolo
vnoremap <S-left>   xhPgvhoho
vnoremap <S-Down>   xjPgvjojo
vnoremap <S-Up>     xkPgvkoko
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Easy line wrapping
imap gq <ESC>gw}0A
nnoremap <leader>gq vipgq
" Set wrapping
nmap <leader>wrap ;set wrap linebreak nocursorline<CR>

" zaznacz wszystko
nnoremap <leader>a ggVG

" zakmnij bufor pliku
nnoremap <leader>x :close<CR>

" zmień katalog pracy
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" włącz i wyłącz autokomentowanie
nnoremap <leader>c :setlocal formatoptions-=cro<CR>
nnoremap <leader>C :setlocal formatoptions=cro<CR>

" włącz i wyłącz autowcięcia
nnoremap <leader>i :setlocal autoindent<CR>
nnoremap <leader>I :setlocal noautoindent<CR>

" usuń polskie znaki z linii lub całego pliku - zależne od 'tpope/vim-abolish'
nmap <leader>ą ;S/{ą,ż,ś,ź,ę,ć,ń,ó,ł,Ą,Ż,Ś,Ź,Ę,Ć,Ń,Ó,Ł}/{a,z,s,z,e,c,n,o,l,A,Z,S,Z,E,C,N,O,L}/g<CR>
nmap <leader>Ą ;%S/{ą,ż,ś,ź,ę,ć,ń,ó,ł,Ą,Ż,Ś,Ź,Ę,Ć,Ń,Ó,Ł}/{a,z,s,z,e,c,n,o,l,A,Z,S,Z,E,C,N,O,L}/g<CR>

" konwersja cudzysłowów z wersji 'do druku' na komputerowe
nnoremap <leader>cudz ;%S/{„,”,‛,’,—}/{\",\",',',-}/g<CR>

" zamień spacje znakiem - w lini bądź w całym pliku
nmap <leader>- ;s/\s\+/-/g<CR>
nmap <leader>_ ;%s/\s\+/-/g<CR>

" usuń spacje na końcach linii
nmap <Leader>1 ;%s/\s\+$//e<cr>

" zastąp wiele pustych liń jedną
nmap <Leader>2 ;%s/\(\n\n\)\n\+/\1/<cr>

" szukaj zaznaczonego tekstu
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" zastępuj ostatnio szukany ciąg za pomocą ... (możesz użyć * aby wyszukać słowo pod kursorem)
nnoremap <leader>r :%s///g<left><left>
nnoremap <leader>rc :%s///gc<left><left><left>

" j.w. ale w zaznaczeniu
xnoremap <leader>r :s///g<left><left>
xnoremap <leader>rc :s///gc<left><left><left>

" zastąp całe słowo pod kursorem; następnie przez kropkę szukaj i powtarzaj następne zastąpienie
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" szukaj w poprzednim zaznaczeniu "
vmap <leader>f ;s/\%V

" po wyszukaniu wyświetl wyniki w nowej karcie
nnoremap <silent> <F3> :redir @a<CR>:g//<CR>:redir END<CR>:tabnew<CR>:put! a<CR>

nnoremap <leader>p :set list!<cr>
nnoremap <leader>slo :setlocal spell!<CR>
nnoremap <leader>pl :setlocal spell spelllang=pl<CR>
nnoremap <leader>en :setlocal spell spelllang=en<CR>

" my extended gx - line must contains only filename
nnoremap goi :!nomacs <C-r><C-l>&<CR>
nnoremap gop :!zathura <C-r><C-l>&<CR>
nnoremap gob :!firefox <C-r><C-l>&<CR>
nnoremap gom :!mpv <C-r><C-l>&<CR>
nnoremap gof :!feh <C-r><C-l>&<CR>
nnoremap gox :!xdg-open <C-r><C-l>&<CR>

"macro
nnoremap Q @q
vmap Q ;norm @q<CR>
nnoremap K @k
vmap K ;norm @k<CR>

"nawigacja w zawijanych wierszach
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

"}}}
" TEO syntax & keys {{{
nmap <leader>ll ;so ~/.vim/syntax/wiki.vim<cr>
"nmap <leader>ll ;so ~/.vim/syntax/markdown.vim<cr>

autocmd Syntax * syntax region textred start=">R" end="R<"
autocmd Syntax * syntax region textblue start=">B" end="B<"
autocmd Syntax * syntax region textgreen start=">G" end="G<"
autocmd Syntax * syntax region textyellow start=">Y" end="Y<"
autocmd Syntax * syntax region textpink start=">P" end="P<"
autocmd Syntax * syntax region textorange start=">O" end="O<"

autocmd Syntax * syntax region textred start="xR" end="Rx"
autocmd Syntax * syntax region textblue start="xB" end="Bx"
autocmd Syntax * syntax region textgreen start="xG" end="Gx"
autocmd Syntax * syntax region textyellow start="xY" end="Yx"
autocmd Syntax * syntax region textpink start="xP" end="Px"
autocmd Syntax * syntax region textorange start="xO" end="Ox"

hi textgreen ctermfg=green
hi textblue ctermfg=74
hi textred ctermfg=red
hi textyellow ctermfg=yellow
hi textpink ctermfg=98
hi textorange ctermfg=166
hi textgrey ctermfg=grey

"Coloring in wimwiki
vnoremap <leader>tr d<Esc>i>R <ESC>pa R<<esc>
vnoremap <leader>tb d<Esc>i>B <ESC>pa B<<esc>
vnoremap <leader>tg d<Esc>i>G <ESC>pa G<<esc>
vnoremap <leader>ty d<Esc>i>Y <ESC>pa Y<<esc>
vnoremap <leader>tp d<Esc>i>P <ESC>pa P<<esc>
vnoremap <leader>to d<Esc>i>O <ESC>pa O<<esc>
vnoremap <leader>ts d<Esc>i>S <ESC>pa S<<esc>

vnoremap <leader>tR d<Esc>ixR <ESC>pa Rx<esc>
vnoremap <leader>tB d<Esc>ixB <ESC>pa Bx<esc>
vnoremap <leader>tG d<Esc>ixG <ESC>pa Gx<esc>
vnoremap <leader>tY d<Esc>ixY <ESC>pa Yx<esc>
vnoremap <leader>tP d<Esc>ixP <ESC>pa Px<esc>
vnoremap <leader>tO d<Esc>ixO <ESC>pa Ox<esc>
vnoremap <leader>tS d<Esc>ixS <ESC>pa Sx<esc>

vnoremap <leader>bb d<Esc>i<b> <ESC>pa </b><esc>
vnoremap <leader>aa d<Esc>i<a href="#"> <ESC>pa </a><esc>
vnoremap <leader>uu d<Esc>i<u><ESC>pa</u><esc>

nnoremap <leader>u :w<Home>silent <End> !urlview<CR>

" }}}
" przeglądanie plików NETRW {{{
let g:netrw_banner=0
let g:netrw_browse_split=4
" }}}
" Airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
"let g:airline_solarized_bg='dark'
let g:airline#extensions#whitespace#enabled = 0
" let g:airline#extensions#tabline#enabled = 1
"}}}
" Vimwiki {{{
"let g:vimwiki_list = [{'path': '$HOME/encfs/notes/wiki'}]
set foldenable
"let g:vimwiki_folding='expr:quick'
let g:vimwiki_hl_headers=1
let g:vimwiki_hl_cb_checked=2
let g:vimwiki_text_ignore_newline=0
let g:vimwiki_list_ignore_newline=0
let g:vimwiki_table_mappings=1
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown', }
"let g:vimwiki_list = [{'path': '~/vimwiki/',
                      "\ 'syntax': 'markdown', 'ext': 'md'}]
"}}}

imap <C-J> <Plug>snipMateNextOrTrigger

" vimmarkdown {{{
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_auto_insert_bullets = 1
set conceallevel=2

nmap <leader>fl ;FZFBLines<CR>
nmap <leader>fh ;FZFHistory<CR>
nmap <leader>fg ;FZFGrep<CR>
nmap <leader>fw ;FZFWindow<CR>
nnoremap <leader><Space> za
"}}}
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

" FZF  {{{
" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
"
" Preview window on the upper side of the window with 40% height,
" hidden by default, ctrl-/ to toggle
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']
"
" Empty value to disable preview window altogether
let g:fzf_preview_window = []
"
nmap <leader>o ;FZF<CR>
nmap <leader>O ;tabnew<CR>;FZF<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>e :History<CR>
"}}}
" GOYO {{{

let g:goyo_width = 80
let g:goyo_height = 30
let g:goyo_liner = 0

nnoremap <silent> <leader>gy :Goyo<CR> 

" }}}
" Matematyka  {{{

" == [ HowMuch ] =============================================================
" calculate in line
nmap <leader>ile <Esc>0v$h<space>?=
"}}}
" Pickachu {{{
let g:pickachu_default_date_format = "%A %d.%m.%Y"
" odpowiednio alt + k f i 
imap … <ESC>;Pickachu date<CR>
imap æ <ESC>;Pickachu file<CR>
imap → <ESC>;Pickachu color<CR>
" }}}

" YCM - AutocompleteMe {{{
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_key_list_select_completion = []
" }}}

" multiplesearch {{{
" https://github.com/vim-scripts/MultipleSearch
let g:MultipleSearchMaxColors = 16

" }}}
" autocomplete {{{
let g:acp_enableAtStartup = 0
"}}}

" mutt ranger att {{{
" mutt: insert attachment with ranger
fun! RangerMuttAttach()
    if filereadable('/tmp/chosendir')
        silent !ranger --choosefiles=/tmp/chosenfiles --choosedir=/tmp/chosendir "$(cat /tmp/chosendir)"
    else
        silent !ranger --choosefiles=/tmp/chosenfiles --choosedir=/tmp/chosendir
    endif
    if filereadable('/tmp/chosenfiles')
        call append('.', map(readfile('/tmp/chosenfiles'), '"Attach: ".substitute(v:val," ",''\\ '',"g")'))
        call system('rm /tmp/chosenfiles')
    endif
    redraw!
endfun
imap <C-a> <ESC>gg/Reply-To<CR><ESC>;call RangerMuttAttach()<CR>}
" }}}

"{{{ markdown preview
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = '/usr/bin/firefox'

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = '/home/pstyczewski/.vim/markdown.css'

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '${name}'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
" let g:mkdp_theme = 'dark'

" normal/insert
" <Plug>MarkdownPreview
" <Plug>MarkdownPreviewStop
" <Plug>MarkdownPreviewToggle

" example
" nmap <C-s> <Plug>MarkdownPreview
" nmap <M-s> <Plug>MarkdownPreviewStop
"nmap <C-p> <Plug>MarkdownPreviewToggle


" }}}

"{{{ Commands

command! -nargs=1 -bang GrepBuffer
 \ :execute printf(':Capture! global%s/%s/print',
 \ expand('<bang>'),
 \ <q-args>)

"searching vimgrep
command! -nargs=1 Ngrep noautocmd vimgrep "<args>" **/*.*
nnoremap <leader>[ :Ngrep 
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

"}}}

command CurLineYellow :highlight CursorLine ctermfg=233 ctermbg=192
command CurLineRed :highlight CursorLine ctermfg=233 ctermbg=203
command CurLineGreen :highlight CursorLine ctermfg=233 ctermbg=46
command CurLineBlue :highlight CursorLine ctermfg=233 ctermbg=87
command CurLineBlack :highlight CursorLine ctermfg=252 ctermbg=236

" functions for file extension '.pdf'.
function! NFH_pdf(f)
    execute '!zathura' a:f
endfunction

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set nonumber
        set norelativenumber
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set number
        set relativenumber
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <S-h> :call ToggleHiddenAll()<CR>

":source ~/Dropbox/vim/abbreviations.vim
"nmap <leader>ab ;e ~/Dropbox/vim/abbreviations.vim<cr>
:source ~/Dokumenty/doku/abbreviations_ksiegi.vim
:source ~/Dokumenty/doku/abbreviations_osoby.vim
nmap <leader>ab ;e ~/Dokumenty/doku/abbreviations_osoby.vim<cr>

" vim:foldmethod=marker:foldlevel=0
