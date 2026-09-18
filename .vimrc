"  ____                    _ ____  _    _
" |  _ \ __ ___      _____| / ___|| |  | |
" | |_) / _` \ \ /\ / / _ \ \___ \| |/ / |
" |  __/ (_| |\ V  V /  __/ |___) |   <| |
" |_|   \__,_| \_/\_/ \___|_|____/|_|\_\_|
" Zoptymalizowana wersja: Nie, 13 Wrz 2026

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
Plug 'junegunn/fzf.vim'

" Narzędzia tekstowe i edycja
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring'
"Plug 'preservim/nerdcommenter'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'easymotion/vim-easymotion'
Plug 'kshenoy/vim-signature'
Plug 'navicore/vissort.vim'
Plug 'vim-scripts/visSum.vim'
Plug 'tpope/vim-speeddating'
Plug 'markonm/traces.vim' " Dynamiczne podglądanie search/replace (bardzo wydajne)
Plug 'bullets-vim/bullets.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'itchyny/calendar.vim'

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
set spelllang=pl,en
set background=dark
silent! colorscheme gruvbox8_hard
let g:goyo_width = 85


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
set textwidth=100
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

" Ustawia poziom otwarcia fałd na bardzo wysoki przy starcie
" Dzięki temu wszystkie sekcje będą rozwinięte
set foldlevelstart=99

" Wyłączenie automatycznego zwijania wtyczki vim-markdown
let g:vim_markdown_folding_disabled = 1

" Easy line wrapping
" inoremap gq <Esc>gw}0A
inoremap gq <Esc>:set ft=<CR>gw}:set ft=markdown<CR>0A
nnoremap <leader>gq vipgq

let g:bullets_enabled_filetypes = ['markdown', 'text', 'gitcommit']
let g:bullets_outline_levels = ['num', 'num', 'abc', 'std-', 'std*', 'std+']
let g:bullets_checkbox_markers = ' .)'
let g:bullets_renumber_on_change = 1 " 1 = włączone, 0 = wyłączone
let b:bullets_enabled = 0
let g:bullets_set_mappings = 1
let g:bullets_outline_levels = ['-']
silent! nunmap <buffer> >>
silent! nunmap <buffer> <<
silent! vunmap <buffer> >
silent! vunmap <buffer> <


" Nawigacja w treści markdown (po nagłówkach) {{{
" 1. Funkcja pomocnicza, która wykonuje skok do linii
function! s:toc_handler(line)
    " Wyciągamy numer linii (wszystko przed pierwszym dwukropkiem)
    let l:lineno = split(a:line, ':')[0]
    " Skaczemy do linii i centrujemy widok
    execute l:lineno
    normal! zt
endfunction

" 2. Główna funkcja wywołująca FZF
function! MarkdownFzfToc()
    call fzf#run(fzf#wrap({
        \ 'source': 'grep -nE "^#+" ' . shellescape(expand('%')),
        \ 'sink': function('s:toc_handler'),
        \ 'options': '--delimiter : --nth 2.. --prompt "TOC> " --reverse'
        \ }))
endfunction

" 3. Komenda i mapowanie
command! FToc call MarkdownFzfToc()
nnoremap <C-Space> :FToc<CR>
nmap <C-@> <C-Space>
" }}}

" Nawigacja w bash po funkcjach {{{
function! BashFzfToc()
  let l:lines = []
  let l:i = 1
  let l:max = line('$')

  " Elastyczny wzorzec dla funkcji w Bashu
  let l:pattern = '^\s*\(function\s\+\)\?[a-zA-Z0-9_#-]\+\s*(\s*)'

  while l:i <= l:max
    let l:line = getline(l:i)
    " Sprawdzenie czy linia pasuje do definicji funkcji
    if l:line =~# l:pattern || l:line =~# '^\s*function\s\+[a-zA-Z0-9_#-]\+'
      call add(l:lines, l:i . ':' . l:line)
    endif
    let l:i += 1
  endwhile

  if empty(l:lines)
    echo "Nie znaleziono funkcji w tym pliku."
    return
  endif

  " Wywołanie FZF z podglądem kodu
  call fzf#run(fzf#wrap({
        \ 'source': l:lines,
        \ 'sink': function('s:BashTocSink'),
        \ 'options': ['--prompt', 'Bash Functions> ', '--preview', 'bat --style=numbers --color=always --highlight-line {1} ' . shellescape(expand('%')) . ' 2>/dev/null || sed -n -e "{1}-5,{1}+15p" ' . shellescape(expand('%'))]
        \ }))
endfunction

function! s:BashTocSink(line)
  let l:lineNumber = split(a:line, ':')[0]
  execute l:lineNumber
  normal! zb
endfunction

" Rejestracja komendy i skrótu klawiszowego
command! BToc call BashFzfToc()

" Przypisanie skrótu pod Ctrl+Space w plikach sh/bash
autocmd FileType sh,bash nnoremap <buffer> <C-Space> :BToc<CR>
" }}}

" Ustawienie pierwszego wolnego markera dla burofu {{{
function! SetFirstFreeMark()
    " Iteruj przez kody ASCII dla liter od 'a' (97) do 'z' (122)
    for i in range(char2nr('a'), char2nr('z'))
        let l:char = nr2char(i)
        " Sprawdź pozycję markera. Jeśli linia wynosi 0, marker jest wolny
        if getpos("'" . l:char)[1] == 0
            execute 'mark ' . l:char
            echo "Marker ustawiony na: " . l:char
            return
        endif
    endfor
    echoerr "Wszystkie markery (a-z) są już zajęte!"
endfunction

function! CalendarInsertDate()
    let l:day_obj = b:calendar.day()
    if empty(l:day_obj) | return | endif

    try
        let l:day   = l:day_obj.get_day()
        let l:month = l:day_obj.get_month()
        let l:year  = l:day_obj.get_year()

        " Tabele nazw
        let l:days_names = ['Nie', 'Pon', 'Wto', 'Śro', 'Czw', 'Pią', 'Sob']
        let l:months_names = ['', 'Sty', 'Lut', 'Mar', 'Kwi', 'Maj', 'Cze', 'Lip', 'Sie', 'Wrz', 'Paź', 'Lis', 'Gru']

        " OBLICZANIE DNIA TYGODNIA (Algorytm Zellera / Vim script)
        " Zwraca 0 dla Niedzieli, 1 dla Poniedziałku itd.
        let l:a = (14 - l:month) / 12
        let l:y = l:year - l:a
        let l:m = l:month + 12 * l:a - 2
        let l:wd = (l:day + l:y + l:y/4 - l:y/100 + l:y/400 + (31*l:m)/12) % 7

        " Wybór formatu
        echo "Format: (1) 2026-02-02 (2) 02.02.2026 (3) 2 Lut 2026 (4) Pon, 2 Lut 2026"
        let l:choice = nr2char(getchar())

        if l:choice == '1'
            let l:date = printf('%04d-%02d-%02d', l:year, l:month, l:day)
        elseif l:choice == '2'
            let l:date = printf('%02d.%02d.%04d', l:day, l:month, l:year)
        elseif l:choice == '3'
            let l:date = printf('%d %s %d', l:day, l:months_names[l:month], l:year)
        elseif l:choice == '4'
            let l:date = printf('%s, %d %s %d', l:days_names[l:wd], l:day, l:months_names[l:month], l:year)
        else
            redraw | echo "Anulowano."
            return
        endif

        q
        execute "normal! a" . l:date
        redraw | echo "Wstawiono: " . l:date
    catch
        echo "Wystąpił błąd: " . v:exception
    endtry
endfunction

" To wywoła mapowanie za każdym razem, gdy otworzysz kalendarz
autocmd FileType calendar nnoremap <buffer> <CR> :call CalendarInsertDate()<CR>
autocmd FileType calendar nnoremap <buffer> H <Plug>(calendar_prev_month)
autocmd FileType calendar nnoremap <buffer> L <Plug>(calendar_next_month)
autocmd FileType calendar nnoremap <buffer> K <Plug>(calendar_up_large)
autocmd FileType calendar nnoremap <buffer> J <Plug>(calendar_down_large)

" Otwórz kalendarz w wąskim oknie po prawej
inoremap ;; <ESC>:Calendar<CR>

function! ExportToWebHtml()
    " --- KONFIGURACJA ŚCIEŻEK ---
    let l:target_dir = "/var/www/html/notatki/"
    let l:sed_md     = "/storage/doku/adds/sed/md_prehtml.sed"
    let l:sed_html   = "/storage/doku/adds/sed/md_html.sed"
    " --- WYBÓR ARKUSZA STYLÓW ---
    let l:css_options = [
        \ "0. bez stylu 1. standardowy, 2. skondensowany",
        \ ""
        \ ]

    let l:choice = inputlist(["Wybierz styl CSS:", l:css_options[0], l:css_options[1]])

    if l:choice == 0
        let l:custom_css = ""
    elseif l:choice == 1
        let l:custom_css = "/storage/doku/adds/style2.css"
    elseif l:choice == 2
        let l:custom_css = "/storage/doku/adds/style3.css"
    else
        echo "\nAnulowano eksport."
        return
    endif

    let l:filename   = expand('%:t:r')
    let l:output_path = l:target_dir . l:filename . ".html"
    let l:temp_md    = tempname() . ".md"

    try
        " 1. Przygotowanie pliku tymczasowego i pierwszy SED
        let l:current_content = getline(1, '$')
        call writefile(l:current_content, l:temp_md)

        if filereadable(l:sed_md)
            call system("sed -i -f " . shellescape(l:sed_md) . " " . shellescape(l:temp_md))
        endif

        " 2. Konwersja Pandoc z WBUDOWANYM CSS
        " --embed-resources (dawniej --self-contained) sprawia, że CSS ląduje wewnątrz HTML
        " --css wskazuje plik, który ma zostać wbudowany
        let l:pandoc_cmd = "pandoc " . shellescape(l:temp_md) .
            \ " -s" .
            \ " --css=" . shellescape(l:custom_css) .
            \ " --embed-resources" .
            \ " --standalone" .
            \ " -o " . shellescape(l:output_path)

        let l:out_pandoc = system(l:pandoc_cmd)

        if v:shell_error
            " Jeśli Twoja wersja Pandoca jest starsza, spróbuj zamienić --embed-resources na --self-contained
            let l:pandoc_cmd_old = "pandoc " . shellescape(l:temp_md) . " -s --css=" . shellescape(l:custom_css) . " --self-contained -o " . shellescape(l:output_path)
            let l:out_pandoc = system(l:pandoc_cmd_old)
        endif

        " 3. Drugi SED (post-procesing gotowego HTML)
        if filereadable(l:output_path) && filereadable(l:sed_html)
            call system("sed -i -f " . shellescape(l:sed_html) . " " . shellescape(l:output_path))
        endif

        redraw | echo "✓ Eksport zakończony (CSS wbudowany)!"

    catch
        echoerr "Wystąpił błąd: " . v:exception
    finally
        if filereadable(l:temp_md) | call delete(l:temp_md) | endif
    endtry
endfunction

" Mapowanie pod klawisz lidera + p
autocmd FileType markdown nnoremap <buffer> <leader>p :call ExportToWebHtml()<CR>

" Mapowanie pod 'mm' (Mark Machine-gun / Mark Mine)
nnoremap mm :call SetFirstFreeMark()<CR>
nnoremap m<BS> :delmarks a-z<CR>:echo "Wyczyszczono markery a-z"<CR>
" }}}

" Autokomendy (Optymalizacja: użycie augroup) {{{
augroup MyCustomAutocmds
    autocmd!
    " PDF i DOC
    autocmd BufReadPost *.pdf silent set ro | silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
    autocmd BufReadPost *.doc set ro | %!antiword "%"
    
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

" Zmienna pomocnicza do śledzenia stanu
let g:cursorline_highvis = 0

function! ToggleCursorHighVis()
    if g:cursorline_highvis == 0
        " --- TRYB WYSOKIEJ WIDOCZNOŚCI ---
        " CursorLine - linia, na której stoi kursor
        " Visual - tekst zaznaczony myszką/klawiaturą
        " Czarny tekst (#000000), Zielone tło (Gruvbox Green #b8bb26)
        hi CursorLine ctermfg=0 ctermbg=142 guifg=#000000 guibg=#b8bb26 cterm=NONE gui=NONE
        hi Visual     ctermfg=0 ctermbg=142 guifg=#000000 guibg=#b8bb26
        
        let g:cursorline_highvis = 1
        echo "Tryb High-Vis: ON"
    else
        " --- POWRÓT DO DOMYŚLNYCH ---
        " Czyścimy nadpisane grupy, co przywraca ustawienia z colorscheme
        hi clear CursorLine
        hi clear Visual
        
        " Ponowne załadowanie schematu kolorów, aby przywrócić oryginalne wartości
        execute 'colorscheme ' . g:colors_name

function! s:ApplyColorscheme(choice)
  if !empty(a:choice)
    execute 'colorscheme ' . a:choice
  endif
endfunction

function! SelectColorscheme()
  " Pobiera listę wszystkich dostępnych schematów kolorów
  let l:schemes = globpath(&rtp, 'colors/*.vim', 0, 1)
  let l:names = map(l:schemes, 'fnamemodify(v:val, ":t:r")')
  
  " Zapamiętujemy obecny motyw na wypadek anulowania (Esc)
  let l:current_theme = get(g:, 'colors_name', 'default')

  call fzf#run(fzf#wrap({
        \ 'source': uniq(sort(l:names)),
        \ 'sink': function('s:ApplyColorscheme'),
        \ 'options': [
        \   '--prompt', 'Colorscheme> ',
        \   '--bind', 'ctrl-j:down,ctrl-k:up',
        \   '--preview', 'vim --servername ' . v:servername . ' --remote-expr "execute(\"colorscheme {}\")" 2>/dev/null || true'
        \ ]
        \ }))
endfunction

" Komenda i skrót klawiszowy do wywołania podglądu
command! Colors call SelectColorscheme()

        let g:cursorline_highvis = 0
        echo "Tryb High-Vis: OFF"
    endif
endfunction

" zmiana kolorystyki lini kursora na czarno zielony
nnoremap <C-S-c> :call ToggleCursorHighVis()<CR>


" Otwieranie pliku pod kursorem w pionowym podziale (Vertical Split)
" nnoremap gv :vertical wincmd f<CR>

" Mapowania {{{
let mapleader = "\<Space>"

" Zamiana : i ; (szybszy dostęp do komend)
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
vnoremap . <ESC>v)
vnoremap , (<ESC>v(
vnoremap n j<ESC>V
vnoremap m k<ESC>V
inoremap UU <Esc>hviWgUe
inoremap Uu <Esc>bviwgu~ea
inoremap uu <Esc>bviwguea
inoremap ąą <Esc>[sz=

" Otwiera plik pod kursorem, a jeśli nie istnieje - tworzy nowy bufor
" nnoremap gf :tabedit <cfile><CR>

" cofanie porcjami, dzięki utworzeniu break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u

" Systemowy schowek (wymaga xsel)
nnoremap <c-p> :r !xsel -b<CR>
vmap <c-c> :w !xsel -i -b<CR><CR>

" Backup i ustawienia
nnoremap <C-S-b> :call WriteBackup()<CR>
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
let @k ="/akpztkjj}"
let @u ="?akpnk}"
let @q ="?akp*ztj}"
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
nnoremap <leader>l :Lines<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>o :FZF<CR>
" Szukaj słowa pod kursorem we wszystkich plikach pod Alt + f
nnoremap <leader>L :Rg <C-R><C-W><CR>

command! FZFRead call fzf#run(fzf#wrap({'sink': 'read'}))
nnoremap <leader>r :FZFRead<CR>

" Build a quickfix list when multiple files are selected
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'alt-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <leader>t :TableModeToggle<CR>

augroup MarkdownLists
    autocmd!
    " q - pozwala na formatowanie, j - usuwa komcie przy łączeniu, n - inteligentne wcięcie list
    autocmd FileType markdown,text setlocal formatoptions=qjn

    " Perfekcyjne rozpoznawanie punktora listy
    autocmd FileType markdown,text setlocal formatlistpat=^\s*\([0-9]\+\.\|[-*+]\)\s\+

    " Brak wizualnych przesunięć w locie
    autocmd FileType markdown,text setlocal breakindent
    autocmd FileType markdown,text setlocal breakindentopt=shift:0
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
    autocmd FileType markdown syntax region higreen matchgroup=Conceal start=";ramkazielona" end="ramkazielona;" containedin=ALL concealends
    autocmd FileType markdown syntax region hiblue matchgroup=Conceal start=";ramkaniebieska" end="ramkaniebieska;" containedin=ALL concealends
    autocmd FileType markdown syntax region hired matchgroup=Conceal start=";ramkaczerwona" end="ramkaczerwona;" containedin=ALL concealends

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

" EasyMotion {{{
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermfg=gray

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

let g:EasyMotion_do_mapping = 0 " Wyłączamy automatyczne mapy, by zdefiniować własne
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 1

" Mapowania z użyciem Twojego Leader (Spacja)
map <Leader>s <Plug>(easymotion-s)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>/ <Plug>(easymotion-sn)
map <Leader>w <Plug>(easymotion-bd-w)
vmap f <Plug>(easymotion-bd-f)
vmap s <Plug>(easymotion-bd-w)
vmap F <Plug>(easymotion-bd-2f)

" }}}

:source /storage/pawelkonfig/vim/abbreviations.vim
:source /storage/pawelkonfig/vim/abbreviations_osoby.vim

" vim:foldmethod=marker:foldlevel=0
