## Environment variable configuration

# PATH追加
export PATH=/usr/local/bin:${PATH}

# LANG
#文字コード設定
export LANG=ja_JP.UTF-8

## Command History configration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
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

PROMPT="%/%% "
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]:] "

#ls色付け
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

#cdとlsの省略
# setopt auto_cd
# function chpwd() { ls }

# alias
alias ac='pyenv activate'
alias deac='pyenv deactivate'
alias cl='clear'
alias sed='gsed'
alias grep='ggrep'
alias crontab='crontab -i'
alias time='/usr/bin/time'
alias socks_on='sudo networksetup -setsocksfirewallproxystate Wi-Fi on'
alias socks_off='sudo networksetup -setsocksfirewallproxystate Wi-Fi off'
alias g='git'
alias cdr='cd-gitroot'

# npmパス設定
export PATH="/usr/local/share/npm/bin:$PATH"

# Golangパス設定
export GOPATH=$HOME/workspace_golang
export PATH=$PATH:$GOPATH/bin

# adbのパス
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools

# AWSパス設定
export PATH=~/.local/bin:$PATH

# Javaの設定
export JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "1.8"`
PATH=${JAVA_HOME}/bin:${PATH}

# tmux自動起動設定
PERCOL=peco
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

setopt nonomatch
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f $HOME/.anyenv/envs/ndenv/versions/v9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . $HOME/.anyenv/envs/ndenv/versions/v9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "k4rthik/git-cal", as:command
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
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
