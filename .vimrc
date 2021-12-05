"  ____                    _ ____  _    _ 
" |  _ \ __ ___      _____| / ___|| | _(_)
" | |_) / _` \ \ /\ / / _ \ \___ \| |/ / |
" |  __/ (_| |\ V  V /  __/ |___) |   <| |
" |_|   \__,_| \_/\_/ \___|_|____/|_|\_\_|
"
" PawelSki - config vim - 2021-11-20

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
Plug 'vim-airline/vim-airline-themes' " Airline
Plug 'vimwiki/vimwiki'
Plug 'sk1418/HowMuch'
Plug 'nixon/vim-vmath'
Plug 'tyru/capture.vim'
Plug 'junegunn/fzf' , { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/VisIncr'
Plug 'wpug/vim-utl-calutil'
Plug 'itchyny/calendar.vim'
Plug 'tpope/vim-abolish'
Plug 'christoomey/vim-system-copy'
  let g:system_copy#copy_command='xclip -sel clipboard'
  let g:system_copy#paste_command='xclip -sel clipboard -o'
  let g:system_copy_silent = 1
Plug 'scrooloose/nerdtree' " Better file browser
Plug 'vim-airline/vim-airline' " Airline
Plug 'tpope/vim-surround' " Surround
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
  let g:snipMate = { 'snippet_version' : 1 }
Plug 't9md/vim-choosewin' " Window chooser
Plug 'godlygeek/tabular' "Tabularize
Plug 'plasticboy/vim-markdown'
Plug 'michaeljsmith/vim-indent-object' " Indent text object
Plug 'jeetsukumaran/vim-indentwise' " Indentation based movements
Plug 'motemen/git-vim' " Git integration
Plug 'scrooloose/nerdcommenter' " Code commenter
Plug 'arielrossanigo/dir-configs-override.vim' " Override configs by directory
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'kshenoy/vim-signature'
Plug 'lilydjwg/colorizer' " Paint css colors with the real color
Plug 'markonm/traces.vim'
Plug 'DougBeney/pickachu'
Plug 'junegunn/goyo.vim'
Plug 'vim-scripts/AutoComplPop'

" Plugins from vim-scripts repos:
Plug 'vim-scripts/IndexedSearch' " Search results counter
"+ Plug 'vim-scripts/matchit.zip' " XML/HTML tags navigation
"+ Plug 'vim-scripts/Wombat' " Gvim colorscheme
" Plug 'vim-scripts/YankRing.vim' " Yank history navigation

" colorscheme
let g:colors_name = "gruvbox8_hard"

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif
" }}}
" Colorscheme and Transparency {{{

colorscheme gruvbox8_soft
nnoremap <C-t> : hi Normal guibg=NONE ctermbg=NONE<CR>
nnoremap <S-t> : hi Normal guibg=NONE ctermbg=black<CR>

" toggle background - light and dark
nmap <C-b> ;let &background = ( &background == "dark"? "light" : "dark" )<CR>

"}}}
" Backup files after edit {{{
autocmd BufWritePost ~/.vimrc !/home/pstyczewski/bin/back-after-edit-vim.sh
autocmd BufWritePost ~/.zshrc !/home/pstyczewski/bin/back-after-edit-zsh.sh
autocmd BufWritePost ~/Dropbox/doku/doku !/home/pstyczewski/bin/back-after-edit-doku.sh
autocmd BufWritePost ~/.config/i3/config !/home/pstyczewski/bin/back-after-edit-i3.sh
autocmd BufWritePost ~/.config/ranger/rc.conf !/home/pstyczewski/bin/back-after-edit-ranger.sh
autocmd BufWritePost ~/.newsboat/urls !/home/pstyczewski/bin/back-after-edit-newsboat-urls.sh
"}}}
" Vim settings set... {{{
set nocompatible " no vi-compatible
set shortmess+=c
set nowrap
set hidden
set colorcolumn=80
set cm=blowfish2
set expandtab "tabs and spaces handling
set tabstop=2 "tabs and spaces handling
set softtabstop=2 "tabs and spaces handling
set shiftwidth=2 "tabs and spaces handling
set rtp+=~/.fzf "fuzzy finder
set ls=2 " always show status bar
set cursorline " Enable CursorLine
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
set lazyredraw
" }}}
" Vim other settings {{{
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

" Pretty soft break character.
let &showbreak='↳ '

autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=vimwiki
autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=vimwiki

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

" My own mappings {{{

let mapleader = "\<Space>"
"let mapleader = ","
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
vnoremap . <ESC>v)
vnoremap , (<ESC>v(
vnoremap n j<ESC>V
vnoremap m k<ESC>V
inoremap ;; <Esc>
inoremap UU <Esc>hviWgUA
nnoremap <leader>da :r! date<CR>
nmap <leader>wer ^v$hy;r! nwt 0zzvipojgq

" Autoclose
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap <C-l> <ESC>la

" save as sudo
ca w!! w !sudo tee "%"

" insert line number
nmap <leader>linia ;%s/^/\=printf('%02d-', line('.'))<cr>

"refocus folds; close any other fold except the one that you are on
nnoremap ,z zMzvzt

"moving line and adding empty line Ctrl+ ...
no <C-k> ddkP
no <C-j> ddp
no <C-l> o<ESC>k
no <C-h> O<ESC>j

"resizing split window
nnoremap <left>  :3wincmd <<cr>
nnoremap <right> :3wincmd ><cr>
nnoremap <up>    :3wincmd +<cr>
nnoremap <down>  :3wincmd -<cr>

"indent and format paragraph
vnoremap <left>  <vipgqgv
vnoremap <right> >vipgqgv

" tab navigation mappings
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>
nnoremap <leader>tm :tabm
nnoremap <leader>tt :tabnew<CR>
nnoremap <PageDown> :silent bn<CR> :redraw!<CR>
nnoremap <PageUp> :silent bp<CR> :redraw!<CR>

" paste from system clipboard
nnoremap <c-p> :r !xsel -b<CR>
imap <c-p> ;r !xsel -b<CR>

" map ts ;tab split<CR>
nnoremap <leader>ts :new<CR>
nnoremap <leader>tv :vnew<CR>

" NWT
nnoremap <leader>te :r !nwt<space>
nmap <F9> o;r !nwt<space>

imap <F9> 0v$hyddo;r !nwt 0

autocmd FileType markdown nnoremap <F10> :w<cr>:!pandoc % --pdf-engine=lualatex --toc -V toc-title:"Spis treści" -V mainfont="calibri.ttf" -V colorlinks -V urlcolor=NavyBlue -o %:r.pdf <cr>
nnoremap <F2> :w<cr>:Vimwiki2HTML<CR>:! vim -s/home/pstyczewski/bin/vimcolorvimwiki.vim /home/pstyczewski/encfs/notes/wiki_html/%:r.html<CR>:! weasyprint -s/home/pstyczewski/encfs/notes/wiki_html/style.css /home/pstyczewski/encfs/notes/wiki_html/%:r.html/home/pstyczewski/Dokumenty/%:r.pdf<CR>:! zathura /home/pstyczewski/Dokumenty/%:r.pdf&<CR>

" Open terminal in split
nnoremap <leader>st :terminal<CR>
nnoremap <leader>vt :vert terminal<CR>

" Change splits from vertical to horizontal and vice versa
" Horizontal to vertical
map <leader>th <C-w>t<C-w>H
" Vertical to horizontal
map <leader>tk <C-w>t<C-w>K

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

"select all
nnoremap <leader>a ggVG

" close buffer
nnoremap <leader>x :close<CR>

"change current directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

"Enable and disable auto comment
nnoremap <leader>c :setlocal formatoptions-=cro<CR>
nnoremap <leader>C :setlocal formatoptions=cro<CR>

"Enable and disable auto indentation
nnoremap <leader>i :setlocal autoindent<CR>
nnoremap <leader>I :setlocal noautoindent<CR>

" remove polish characters
nmap <leader>ą ;S/{ą,ż,ś,ź,ę,ć,ń,ó,ł,Ą,Ż,Ś,Ź,Ę,Ć,Ń,Ó,Ł}/{a,z,s,z,e,c,n,o,l,A,Z,S,Z,E,C,N,O,L}/g<CR>
nmap <leader>Ą ;%S/{ą,ż,ś,ź,ę,ć,ń,ó,ł,Ą,Ż,Ś,Ź,Ę,Ć,Ń,Ó,Ł}/{a,z,s,z,e,c,n,o,l,A,Z,S,Z,E,C,N,O,L}/g<CR>

"change space with -
nmap <leader>- ;s/\s\+/-/g<CR>
nmap <leader>_ ;%s/\s\+/-/g<CR>

"remove spaces on end of line
nmap <Leader>1 ;%s/\s\+$//e<cr>
"remove many empty lines and insert one
nmap <Leader>2 ;%s/\(\n\n\)\n\+/\1/<cr>

" search and replace
nnoremap <leader>f /\%V
nnoremap <leader>r yiw:%s/\<<C-r>"\>//<left>
nnoremap <leader>R yiw:%s/\<<C-r>"\>//gc<left><left><left>
vmap <leader>s ;s/\%V
nmap <leader>v 0v$h

" after search redirecting output to new tab
nnoremap <silent> <F3> :redir @a<CR>:g//<CR>:redir END<CR>:tabnew<CR>:put! a<CR>

nnoremap <leader>p :set list!<cr>
nnoremap <leader>s :setlocal spell!<CR>
nnoremap <leader>pl :setlocal spell spelllang=pl<CR>
nnoremap <leader>en :setlocal spell spelllang=en<CR>

" my extended gx - line must contains only filename
nnoremap goi :!nomacs <C-r><C-l>&<CR>
nnoremap gop :!zathura <C-r><C-l>&<CR>
nnoremap gob :!qutebrowser <C-r><C-l>&<CR>
nnoremap gom :!mpv <C-r><C-l>&<CR>
nnoremap gof :!feh <C-r><C-l>&<CR>

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
autocmd Syntax * syntax region textred start=">R" end="R<"
autocmd Syntax * syntax region textblue start=">B" end="B<"
autocmd Syntax * syntax region textgreen start=">G" end="G<"
autocmd Syntax * syntax region textyellow start=">Y" end="Y<"
autocmd Syntax * syntax region textpink start=">P" end="P<"
autocmd Syntax * syntax region textorange start=">O" end="O<"
hi textgreen ctermfg=green
hi textblue ctermfg=63
hi textred ctermfg=red
hi textyellow ctermfg=yellow
hi textpink ctermfg=98
hi textorange ctermfg=166

"Coloring in wimwiki
vnoremap <leader>tr d<Esc>i>R <ESC>pa R<<esc>
vnoremap <leader>tb d<Esc>i>B <ESC>pa B<<esc>
vnoremap <leader>tg d<Esc>i>G <ESC>pa G<<esc>
vnoremap <leader>ty d<Esc>i>Y <ESC>pa Y<<esc>
vnoremap <leader>tp d<Esc>i>P <ESC>pa P<<esc>
vnoremap <leader>to d<Esc>i>O <ESC>pa O<<esc>
vnoremap <leader>bb d<Esc>i<b> <ESC>pa </b><esc>
vnoremap <leader>uu d<Esc>i<u> <ESC>pa </u><esc>

nmap <F5> zm
nmap <F6> zr
nmap <F7> {zt
nmap <F8> }ztjzt
vmap <F5> <leader>tb
vmap <F6> <leader>tg
vmap <F7> <leader>to
vmap <F8> <leader>tr

nmap <leader>kk ;so ~/.vim/syntax/wiki.vim<cr>
" }}}

" Plugins settings and mappings ================================================
" NERDTree {{{
" toggle nerdtree display
map <F4> ;NERDTreeToggle<CR>
"}}}


" Window Chooser {{{
nmap  `  <Plug>(choosewin)
let g:choosewin_overlay_enable = 1
"}}}
" Airline {{{
let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
"}}}
" Vimwiki {{{
let g:vimwiki_list = [{'path': '$HOME/encfs/notes/wiki'}]
let g:vimwiki_folding='expr'
let g:vimwiki_hl_headers=1
let g:vimwiki_text_ignore_newline=0
let g:vimwiki_list_ignore_newline=0
let g:vimwiki_hl_cb_checked=1
let g:vimwiki_table_mappings=0
" let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown', }

nmap <tab> <Plug>VimwikiNextLink
nmap <s-tab> <Plug>VimwikiPrevLink
nmap <Leader>wd <Plug>VimwikiDeleteFile
nmap <Leader>wr <Plug>VimwikiRenameFile
nmap <Leader>vv <Plug>VimwikiVSplitLink
nmap <Leader>hh <Plug>VimwikiSplitLink
nmap <Leader>html <Plug>Vimwiki2HTML
nmap <leader>tab ;VimwikiTable 
nmap <leader>mcl ;VimwikiTableMoveColumnLeft<CR>
nmap <leader>mcr ;VimwikiTableMoveColumnRight<CR>
nmap <leader>dom <leader>wwgg/domoggddOdate<Tab>yiW/<c-r>0<CR>nnzt
nmap <leader>teo <leader>wwgg/zboroggddOdate<Tab>yiW/<c-r>0<CR>nnzt
nmap <leader>slu <leader>wwgg/sluzboggddOdate<Tab>yiW/<c-r>0<CR>nnzt
nnoremap <leader><Space> za
"}}}
" itchyny/calendar {{{
source ~/.cache/calendar.vim/credentials.vim
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
let g:calendar_task=0
let g:calendar_first_day = "monday"
nmap <leader>cal ;Calendar -view=year<CR>
" }}}
" Easymotion {{{
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" s{char} to move to {char}
map s <Plug>(easymotion-s)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

let g:EasyMotion_startofline = 1 " keep cursor column when JK motion
map  <leader>/ <Plug>(easymotion-sn)
omap <leader>/ <Plug>(easymotion-tn)
" }}}

" FZF  {{{
nmap <leader>o ;FZF<CR>
nmap <leader>O ;tabnew<CR>;FZF<CR>

" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Preview window on the upper side of the window with 40% height,
" hidden by default, ctrl-/ to toggle
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

" Empty value to disable preview window altogether
let g:fzf_preview_window = []

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

" Vim-match & calculate  {{{
" == [ vim-vmath ] ===========================================================
" github.com/nixon/vim-vmath - sum: 21   avg: 3.5   min: 1   max: 6   count: 6
xnoremap <expr> ++  VMATH_YankAndAnalyse()
nmap            ++  vip++

" == [ HowMuch ] =============================================================
" calculate in line
nmap <leader>ile <Esc>0v$h<space>?=
"}}}

" Pickachu {{{
let g:pickachu_default_date_format = "%A %d/%m/%Y"
imap <C-k> <ESC>;Pickachu date<CR>
imap <C-f> <ESC>;Pickachu file<CR>
" }}}

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

:source ~/Dropbox/vim/abbreviations.vim

" vim:foldmethod=marker:foldlevel=0
