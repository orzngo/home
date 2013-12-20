# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
#export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
export PATH=$PATH:$HOME/bin
export JAVA_HOME=/Library/Java/Home

#setopt correct           # コマンドのスペルを訂正する
#setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt auto_pushd							# ディレクトリ
#setopt list_packed             # 補完候補をできるだけ詰めて表示する
#setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
setopt auto_cd								#cd省略

#autoload predict-on;			predict-on			#先方予測


# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
#プロンプトに色を付ける
autoload -U colors; colors

tmp_prompt="%{${fg[cyan]}%}%n%{${reset_color}%}[%{${fg_bold[cyan]}%}INS%{$reset_color%}]# "
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
    tmp_prompt="%B%U${tmp_prompt}%u%b"
    tmp_prompt2="%B%U${tmp_prompt2}%u%b"
    tmp_rprompt="%B%U${tmp_rprompt}%u%b"
    tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi
function zle-line-init zle-keymap-select {
	case $KEYMAP in
		vicmd)
			PROMPT="%{${fg[cyan]}%}%n%{${reset_color}%}[%{${fg_bold[red]}%}NOR%{$reset_color%}]# "
			;;
		main|viins)
			PROMPT="%{${fg[cyan]}%}%n%{${reset_color}%}[%{${fg_bold[cyan]}%}INS%{$reset_color%}]# "
			;;
	esac
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

#コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
#setopt share_history        # share command history data
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


[ -f ~/.zshrc.include ] && source ~/.zshrc.include # include
