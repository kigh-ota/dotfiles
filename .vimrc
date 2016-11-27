set encoding=utf-8 " Vim内部で使われるエンコーディング
if !&compatible
    set nocompatible  " 挙動をviでなくVimデフォルトにする
endif
filetype off " ファイル形式の検出を無効に

" MEMO: 変数のスコープ
" s: スクリプト内
" b: バッファ内
" w: ウィンドウ内
" g: グローバル
" v: エディタが定義/設定
" l: 関数内
" a: 関数引数用

" MEMO: アンパサンド
" set設定の頭に&を付けると、変数のように扱える

if has('win32') || has('win64')
  let s:cache_home = expand('~/vimfiles')
  let s:toml = '~/_dein.toml'
  " let s:lazy_toml = '~/_dein_lazy.toml'
else
  let s:cache_home = expand('~/.vim')
  let s:toml = '~/.dein.toml'
  " let s:lazy_toml = '~/.dein_lazy.toml'
endif

" dein settings {{{
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir
call dein#begin(s:dein_dir)

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  call dein#load_toml(s:toml, {'lazy': 0})
  " call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
" プラグインの追加・削除やtomlファイルの設定を変更した後は
" 適宜 call dein#update や call dein#clear_state を呼んでください。
" そもそもキャッシュしなくて良いならload_state/save_stateを呼ばないようにしてください。

" vimprocだけは最初にインストールしてほしい
if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif
" その他インストールしていないものはこちらに入れる
if dein#check_install()
  call dein#install()
endif
" }}}

let g:SimpleJsIndenter_BriefMode = 1 " この設定入れるとshiftwidthを1にしてインデントしてくれる

filetype plugin on " ファイル形式別プラグインの有効化
filetype indent on " ファイル形式別インデントのロードを有効化

" options {{{
" 既存ファイル編集時に考慮される文字コードのリスト
" 順に試して，はじめにマッチしたものがfileencodingに設定される
"set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
set fileformats=unix,dos,mac " 改行(EOL)の種類
set ignorecase " 検索でcase無視
set smartcase " 検索で大文字があったらcase無視しない
set hlsearch    " search hilighting
set showmatch   " 対応するカッコのハイライト
set matchtime=5 " ハイライト秒数
set noincsearch " 検索の入力途中で飛ばない
set nowrapscan " 検索でラップしない
set laststatus=2 " 画面下部のステータス行を常に表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
let &statusline .= '%{&bomb ? "[BOM]" : ""}'
set tabstop=4 " タブ文字表示幅
set softtabstop=0 " Tabキーで挿入される空白数
set shiftwidth=4  " 挿入するインデントの幅
set shiftround  " <や>でインデントする際にshiftwidthの倍数に丸める
set expandtab " タブ→空白
set smartindent " 行を追加したときの高度な自動インデント
set autoindent " 新しい行のインデントを現在業と同じに
set backspace=indent,eol,start " BS時がautoindent,改行,挿入区間を超える
set ruler " カーソル座標表示
set showcmd " コマンドを最下行に表示
set number " 行番号
set ambiwidth=double " East Asian Width Class Ambiguous文字をどう扱うか
set wrap " 折り返し
set textwidth=0 " 自動改行を無効化
autocmd FileType text setlocal textwidth=0 " Kaoriya版で折り返しを抑制
set colorcolumn=80 " ラインを入れる
set whichwrap=b,s,[,],<,>,~ " BS,Space,Left,Right,~で行を超えられる
set mouse=
"set nowritebackup " ファイル上書き前の一時的バックアップをしない
set nobackup " 上書き時のバックアップを取っておく
"set noswapfile " スワップファイルを作らない
set list " 不可視文字の可視化 
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set wildmenu " コマンドラインでTab補完
set matchpairs& matchpairs+=<:> " 対応カッコを追加
"set cursorline
set background=dark
"set foldmethod=indent
" }}}

syntax on " 構文ごとに文字色を変化

" MEMO: マップコマンド
" nmap ノーマル
" vmap ビジュアル、選択
" http://vim-jp.org/vimdoc-ja/map.html#map-overview

" 検索でジャンプした際画面中央に
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
nmap gr :vim <C-R><C-W> * \| cw<CR>
" ESC2回でハイライト消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk
" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>
" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" Plugin settings {{{

" cawプラグイン用の設定
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)

" Vim-LaTeX用の設定
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

let g:Tex_CompileRule_dvi='platex -src-specials -interaction=nonstopmode $*'
" let g:Tex_CompileRule_dvi='latex -src-specials -interaction=nonstopmode $*'
" Macで使うための設定：http://vim.g.hatena.ne.jp/y_yanbe/20080918/1221724545 を参考
let g:Tex_CompileRule_pdf='dvipdfmx $*.dvi'
let g:Tex_ViewRule_pdf = 'open -a /Applications/Preview.app'
let g:Tex_FormatDependency_pdf='dvi,pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
" let g:Tex_ViewRule_dvi='c:/tex/dviout/dviout.exe'

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Tex_IgnoredWarnings =
            \'Underfull'."\n".
            \'Overfull'."\n".
            \'specifier changed to'."\n".
            \'You have requested'."\n".
            \'Missing number, treated as zero.'."\n".
            \'There were undefined references'."\n".
            \'Citation %.%# undefined'."\n".
            \'A float is stuck'."\n".
            \"Font shape \`JT1/gt/m/it\' undefined"."\n".
            \"Font shape \`JY1/gt/m/it\' undefined"."\n".
            \"Font shape \`JT1/mc/m/it\' undefined"."\n".
            \"Font shape \`JY1/mc/m/it\' undefined"."\n".
            \"Font shape \`JT1/mc/bx/it\' undefined"."\n".
            \"Font shape \`JY1/mc/bx/it\' undefined"."\n".
            \"Font shape \`JT1/mc/m/sc\' undefined"."\n".
            \"Font shape \`JY1/mc/m/sc\' undefined"."\n".
            \"Font shape \`OMS/cmss/m/n\' undefined"."\n".
            \"Font shape \`OMS/txss/m/n' undefined"."\n".
            \"Font shape \`OMS/cmtt/m/n' undefined"."\n".
            \"Font shape \`JT1/mc/m/sl' undefined"."\n".
            \"Font shape \`JY1/mc/m/sl' undefined"."\n".
            \'LaTeX Font Warning: Some font shapes were not available, defaults substituted.'."\n".
            \"Font shape \`OML/cmm/m/it\' in size"."\n".
            \"Font shape \`OMS/cmsy/m/n\' in size"."\n".
            \"Font shape \`OML/cmm/b/it\' in size"."\n".
            \"Font shape \`OMS/cmsy/b/n\' in size"."\n".
            \"Font shape \`OT1/cmss/m/n\' in size <4> not available"."\n".
            \"Font shape \`OT1/cmss/bx/n\' in size <4> not available"."\n".
            \"Size substitutions with differences"
" 最後の5つはIEICEクラスファイル用
let g:Tex_IgnoreLevel = 29

" }}}

set path=.,/usr/include/,$HOME/include

" 見た目の設定
if has('gui_macvim')
    set transparency=5
    set guifont=Menlo:h12
    set lines=60 columns=90
    colorscheme koehler
    set clipboard=unnamed

    " noremap! ¥ \
    " noremap! \ ¥

    set visualbell
endif

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ }

" MEMO
" au[tocmd] [group] {event} {pat} [nested] {cmd}
au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*}  setlocal filetype=markdown " md as markdown, instead of modula2
au BufNewFile,BufRead *.md  setlocal tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.erb  setlocal tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.rb   setlocal tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.coffee  setlocal tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.html  setlocal tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.js  setlocal tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.py  setlocal tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.scala setf scala

if has('win32') || has('win64')
    if filereadable(expand('~/_vimrc_local'))
        source ~/_vimrc_local
    endif
else
    if filereadable(expand('~/.vimrc.local'))
        source ~/.vimrc.local
    endif
endif

" 引数なしならNERDTreeを起動
let file_name = expand('%')
if has('vim_starting') && file_name == ''
    au VimEnter * NERDTree ./
endif

