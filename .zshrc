# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM_PLUGINS=$ZSH/custom/plugins

ZSH_THEME="agnoster"
DEFAULT_USER="jonathan"

DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git git-extras fzf)

if [[ -d $ZSH_CUSTOM_PLUGINS/zsh-autosuggestions ]]; then
	zmodload zsh/zpty
	ZSH_AUTOSUGGEST_STRATEGY=(history completion)
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'
	plugins+=(zsh-autosuggestions)
fi

if [[ -d $ZSH_CUSTOM_PLUGINS/zsh-history-substring-search ]]; then
	plugins+=(zsh-history-substring-search)
fi

if [[ -d $ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting ]]; then
	plugins+=(zsh-syntax-highlighting)
fi


source $ZSH/oh-my-zsh.sh

# Various system configs for QoL improvements

export EDITOR='vim'
export LESS='-XFR'

if [[ $(uname -s) == "Linux" ]]; then
	alias open='xdg-open'
fi


case "$TERM" in
	"dumb")
		PS1="> "
		unset zle_bracketed_paste
		;;
esac

if [[ -n "$TMUX" ]]; then
	function refresh_ssh {
		auth_sock=$(tmux show-environment | grep "^SSH_AUTH_SOCK")
		if [[ -n "${auth_sock}" ]]; then
			export ${auth_sock}
		fi

		display=$(tmux show-environment | grep "^DISPLAY")
		if [[ -n "${display}" ]]; then
			export ${display}
		fi
	}
else
  function refresh_ssh { }
fi

function preexec {
	refresh_ssh
}


type bat >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
	alias cat=bat
fi

type rg >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
	function rg {
		grep -R "$@" *
	}
fi

if [[ -e ~/.zshrc.local ]]; then
	source ~/.zshrc.local
fi

alias vi=vim


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

prompt_context(){}

function hist {
	num=${1:-20}
	history | tail -n $num
}

