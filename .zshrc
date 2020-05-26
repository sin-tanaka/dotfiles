## Environment variable configuration

# PATH追加
export PATH=/usr/local/bin:${PATH}

# ユーザディレクトリ以下のbin
export PATH=${HOME}/bin:${PATH}
export FPATH="${HOME}/zsh/functions:${FPATH}"

# Poetry
export PATH=${HOME}/bin:${PATH}

# LANG
#文字コード設定
export LANG=ja_JP.UTF-8

## Command History configration
#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## Completion configuration
#
# 予測変換
# autoload predict-on
# predict-on

autoload -U compinit
compinit

# vcs_info setting (pureで設定するようにしたのでコメントアウト)
# autoload -Uz vcs_info
# setopt prompt_subst
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
# zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
# zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# precmd () { vcs_info }
# RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

PROMPT="%/%% "
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]:] "

# 補完メッセージを読みやすくする
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

#ls色付け
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

#cdとlsの省略
# setopt auto_cd
# function chpwd() { ls }

setopt nonomatch

# alias
alias ac='pyenv activate'
alias deac='pyenv deactivate'
alias cl='clear'
alias sed='gsed'
alias grep='ggrep'
# alias crontab='crontab -i'
alias time='/usr/bin/time'
alias socks_on='sudo networksetup -setsocksfirewallproxystate Wi-Fi on'
alias socks_off='sudo networksetup -setsocksfirewallproxystate Wi-Fi off'
alias g='git'
alias cdr='cd-gitroot'
alias ip="ipconfig getifaddr en0 | tr -d '\n'"
alias ipp="ip | pbcopy"
alias vz='nvim ~/.zshrc'
alias vg='nvim ~/.gitconfig'
alias ss='exec $SHELL -l'
alias vv='nvim ~/.config/nvim/init.vim'
alias tm='tmux'
alias tma='tmux attach'
alias resize='sips -Z 128'
alias v='nvim'
alias ls='exa'
alias n='npm'
alias nr='npm run'
alias nreinstall='rm -rf ./node_modules && npm i && npm audit fix'
alias y='yarn'
alias c='pbcopy'
alias r='ranger'
alias of='git branch -a | fzf | xargs git checkout'
alias addip="curl httpbin.org/ip | jq '.origin' -r | awk -F "[,:]" '{print $1}' | xargs -I GLOBAL_IP aws --profile jsl ec2 authorize-security-group-ingress --group-id sg-cde917aa --ip-permissions IpProtocol=tcp,FromPort=22,ToPort=22,IpRanges='[{CidrIp=GLOBAL_IP/32,Description="s.tanaka"}]'"
killp(){
	ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs -I PID  kill PID
}


function mdns () {
    open "https://developer.mozilla.org/ja/search?q=$1"
}

# npmパス設定
export PATH="/usr/local/share/npm/bin:$PATH"

# Golangパス設定
export GOPATH=$HOME/workspace_golang
export PATH=$PATH:$GOPATH/bin

export ANDROID_HOME=$HOME/Library/Android/sdk
# adbのパス
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools

# AWSパス設定
export PATH=~/.local/bin:$PATH

# GCPコマンドライン
export PATH=$HOME/google-cloud-sdk/bin:$PATH
# Javaの設定
export JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "1.8"`
PATH=${JAVA_HOME}/bin:${PATH}

# tmux自動起動設定
# PERCOL=peco
#if [[ ! -n $TMUX ]]; then
#  # get the IDs
#  ID="`tmux list-sessions`"
#  if [[ -z "$ID" ]]; then
#    tmux new-session
#  fi
#  create_new_session="Create New Session"
#  ID="$ID\n${create_new_session}:"
#  ID="`echo $ID | $PERCOL | cut -d: -f1`"
#  if [[ "$ID" = "${create_new_session}" ]]; then
#    tmux new-session
#  elif [[ -n "$ID" ]]; then
#    tmux attach-session -t "$ID"
#  else
#    :  # Start terminal normally
#  fi
#fi

if [ -d ${HOME}/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    for D in `ls $HOME/.anyenv/envs`
    do
        export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done

fi

# pipenvで.venv以下に仮想環境を作る環境変数
export PIPENV_VENV_IN_PROJECT=true
# pipenvで補完
eval "$(pipenv --completion)"

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
# zplug "k4rthik/git-cal", as:command
zplug "mollifier/cd-gitroot"
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*darwin*amd64*"
zplug "m4i/cdd", from:github, as:command
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug "b4b4r07/enhancd", use:init.sh
ENHANCD_FILTER=fzf; export ENHANCD_FILTER
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug load

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="
--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168
--height 40% --reverse --border --preview 'head -100 {}'
"


# https://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    # ls
    # ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

# poetry
export PATH=${HOME}/.poetry/bin:${PATH}


# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi
