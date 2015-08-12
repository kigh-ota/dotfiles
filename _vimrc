set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/vimfiles/bundle/neobundle.vim/
	call neobundle#begin(expand('~/vimfiles/bundle/'))
endif
NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tyru/caw.vim.git'
if has('vim_starting')
	call neobundle#end()
endif
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" fileencodingsを前から順に試して，はじめにマッチしたものが採用される
set encoding=utf-8
"set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
set fileformats=unix,dos,mac

set ignorecase
set smartcase
set hlsearch	"search hilighting
set showmatch	"bracket
set noincsearch
set nowrapscan
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
let &statusline .= '%{&bomb ? "[BOM]" : ""}'

filetype plugin indent on
syntax on

set tabstop=4
set shiftwidth=4

set backspace=indent,eol,start
set ruler
set showcmd
set number
set ambiwidth=double
set whichwrap=b,s,[,],<,>,~
set mouse=
"set cursorline

set background=dark

nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

"set foldmethod=indent

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

" For screen
"function SetScreenTabName(name)
"	let arg = 'k' . a:name . '\\'
"	silent! exe '!echo -n "' . arg . "\""
"endfunction
"
"autocmd VimLeave * call SetScreenTabName('(zsh)')
"autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | call SetScreenTabName("(vim %)") | endif 

" srcexpl.vim用設定
let g:SrcExpl_RefreshTime=1	" 自動的にプレビュー表示
let g:SrcExpl_UpdateTags=1	" 自動でtagsを生成

set path=.,/usr/include/,$HOME/include

if has('gui_macvim')
	set transparency=5
	set guifont=Menlo:h12
	set lines=60 columns=80
	colorscheme koehler
	set clipboard=unnamed

	"noremap! \ \
	"noremap! \ \

	set visualbell
endif

autocmd FileType text setlocal textwidth=0

set nobackup
set noundofile
