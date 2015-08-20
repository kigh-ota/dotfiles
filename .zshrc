echo Called .zshrc

if [ -f ~/.zshrc.local.first ]; then
	source ~/.zshrc.local.first
fi

# root なら環境言語を英語に指定
case ${UID} in
	0)
	LANG=C
	;;
esac

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS	# 直前と同一なら登録しない
setopt SHARE_HISTORY

# 各種環境変数
export MYINCLUDE=$HOME/include
export MYSCRIPT=$HOME/script
export EDITOR=vim
export LSCOLORS=ExFxCxdxBxegedabagacad

#setopt correct
setopt list_packed

bindkey -v	# コマンドライン編集：vi挿入モード風キー割当

# 補完システム compsys を有効にする
# （環境によってはcompinitが見つからない時がある）
autoload -U compinit
compinit

compctl -g '*.plt' gnuplot
compctl -g '*.tex' platex
compctl -g '*.dvi' xdvi

# 00 標準色
# 01 明るく
# 04 下線
# 05 点滅
# 30-7 プロンプトと同じ（下記参照）
# no: nomral file
# di: directory
# li: symbolic link
# so: socket
# ex: executable
# bd: block device
# cd: character device
export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

# エイリアスの定義
case "${OSTYPE}" in
	freebsd*|darwin*)
	alias ls="ls -G -w"
	;;
	linux*)
	alias ls="ls --color"
	;;
esac
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias j="jobs -l"
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias cssh='cocot -t utf-8 -p EUC-JP ssh'
alias pd=popd
alias -g G='| grep'
alias -g L='| ${PAGER}'
alias -s eps=gv
#alias -s rb=ruby
#ulimit -c unlimited
setopt complete_aliases

## プロンプトの設定
# %B:太字開始 %b:太字終了
# %{...%}:エスケープシーケンスをくくる．
# ESC[3Ym: 文字色の変更(Y=0,1...7 = 黒赤緑黄青紫水白)
# %m: hostname
# %/: フルパス
# %(!.#.$): ユーザが特権ユーザなら"#",違えば"$"
PROMPT="%B%{[35m%}%m:%{[36m%}%/%(!.#.$)%{[m%}%b "
PROMPT2="%B%{[36m%}%(!.#.$)%{[m%}%b "
SPROMPT="%B%{[36m%}%r is correct? [n,y,a,e]:%{[m%}%b "
#[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#	PROMPT="%{37m%}${HOST%%.*} ${PROMPT}"

# vcs_infoロード    
autoload -Uz vcs_info    
# PROMPT変数内で変数参照する    
setopt prompt_subst    

# vcsの表示    
zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'    
zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'    
# プロンプト表示直前にvcs_info呼び出し    
precmd() { vcs_info }    
# プロンプト表示    
RPROMPT='%B[${vcs_info_msg_0_}]%b'

setopt autopushd
setopt PUSHD_IGNORE_DUPS
setopt auto_cd
setopt noautoremoveslash
setopt EXTENDED_GLOB

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end

#bindkey '^P' up-line-or-history
#bindkey '^N' down-line-or-history
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^D' delete-char-or-list
bindkey '^U' kill-whole-line
bindkey '^K' kill-line
bindkey -a 'q' push-line

export PATH=$PATH:$HOME/bin:$HOME/script

# for screen
#pwdname="~"
#echo -ne "k[${pwdname} >(zsh)]\\" 
#chpwd(){
#	pwdname=`basename $PWD`
#	if [ "$pwdname" = `basename $HOME` ]; then
#		pwdname="~"
#	fi
#}
#precmd() { 
#	echo -ne "k[${pwdname}]\\" 
#}

if [ -f ~/.zshrc.local ]; then
	source ~/.zshrc.local
fi
