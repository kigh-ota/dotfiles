echo Called $0

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

# 各種環境変数
export MYINCLUDE=$HOME/include
export MYSCRIPT=$HOME/script
export EDITOR=vim
export LSCOLORS=ExFxCxdxBxegedabagacad
export TERM=xterm-256color
typeset -U path cdpath fpath manpath
export PATH=$HOME/bin:$HOME/script:$PATH

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
alias j='jobs -l'
alias du='du -h'
alias df='df -h'
alias su='su -l'
# alias grep='grep --color'
alias cssh='cocot -t utf-8 -p EUC-JP ssh'
alias pd=popd
# alias -g G='| grep'
# alias -g L='| ${PAGER}'
alias -s eps=gv
alias lv='lv -c'
#alias -s rb=ruby
#ulimit -c unlimited

## Git関係エイリアス
alias gc='git commit -v'    # -v: verbose
alias gsw='git switch'
# alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'   # -a: リモート・ローカル両方
alias ga='git add'
alias gf='git fetch'
alias gup='git fetch && git rebase'
alias ggpush="git push origin"
alias grs='git restore --staged'  # unstage
alias gd='git diff'
alias gdc='git diff --cached'
alias gr='git rebase'
alias gri='git rebase -i'
alias gcp='git cherry-pick'
alias gs='git status --short --branch'
alias gst='git status'
alias gsh='git stash'
alias gshp='git stash pop'
alias gshl='git stash list'
alias gshd='git stash drop'
alias gl="git log --graph -n 20 --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(green)- %an, %cr%Creset'"  # -n: number of commits
alias gll='git log --stat --abbrev-commit'
alias gln="git log --graph -n 20 --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(green)- %an, %cr%Creset' --name-status"   # --name-status: author & file names
alias glp='git log --oneline -n 20 -p'  # -p: diffも
alias glfp="git log --first-parent --graph -n 20 --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(green)- %an, %cr%Creset'"

alias g='cd $(ghq root)/$(ghq list | peco)'

## Ruby関係
alias be='bundle exec'

# K8s
# source <(kubectl completion zsh)
# alias k=kubectl
# compdef __start_kubectl k

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

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '[%s][* %F{green}%b%f]'
zstyle ':vcs_info:*' actionformats '[%s][* %b(%F{red}%a%f)]'

function _update_vcs_info_msg() {
  LANG=en_US.UTC-8 vcs_info
  RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

# 各種オプション
setopt hist_ignore_dups	# 直前と同一なら登録しない
setopt share_history
#setopt correct # スペルチェック
setopt autopushd
setopt pushd_ignore_dups
setopt auto_cd  # ディレクトリ名だけでcdする
setopt noautoremoveslash
setopt extended_glob  # 高機能なワイルドカード展開
setopt long_list_jobs # jobsの表示を拡張
setopt list_types   # ファイル種別をマーク表示
setopt auto_menu  # 補完候補をtabで選択
setopt list_packed  # 補完候補を詰めて表示
setopt no_flow_control  # ^s, ^q を無効
setopt brace_ccl  # {a-c}で展開できるなど
# setopt complete_aliases # aliasを補完 -> ブランチ名展開を阻害するので無効化
setopt interactive_comments # '#'以降をコメント扱い

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

source ~/dotfiles/bd.zsh

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/kaiichiro/.nodebrew/node/v8.6.0/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/kaiichiro/.nodebrew/node/v8.6.0/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh


# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/kaiichiro/.lmstudio/bin"
# End of LM Studio CLI section


[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
