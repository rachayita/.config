# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were read by zsh-newuser-install.
# They were moved here as they could not be understood.
# Sat Feb  1 19:21:32 IST 2020
export ZSH=${HOME}/.config/ohmyzsh
# End of lines moved by zsh-newuser-install.
# The following lines were added by compinstall
setopt COMPLETE_ALIASES
zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions set
zstyle ':completion:*' glob set
zstyle ':completion:*' group-name ''
zstyle ':completion:*' max-errors 11 not-numeric
zstyle ':completion:*' substitute set
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/rakshas/.zshrc'

autoload -Uz compinit
compinit -D
# End of lines added by compinstall

# autoload -Uz promptinit
# promptinit
#prompt pws
#PROMPT='%b%f[~>]'
#PROMPT='[%F{blue}%B%~%b%f]$ '
#RPROMPT='[%F{blue}%B%~%b%f]'

#------------------------------
# ShellFuncs
#------------------------------
# -- coloured manuals
man() {
		env \
				LESS_TERMCAP_mb=$(printf "\e[1;31m") \
				LESS_TERMCAP_md=$(printf "\e[1;31m") \
				LESS_TERMCAP_me=$(printf "\e[0m") \
				LESS_TERMCAP_se=$(printf "\e[0m") \
				LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
				LESS_TERMCAP_ue=$(printf "\e[0m") \
				LESS_TERMCAP_us=$(printf "\e[1;32m") \
				man "$@"
		}

#------------------------------
# Keybindings
#------------------------------
bindkey -v
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

#Use Ctrl-Z to switch back to Vim
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

#------------------------------
# fzf
#------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

#------------------------------
# The ttyctl command can be used to "freeze/unfreeze" the terminal. 
# Many programs change the terminal state, and often do not restore 
# terminal settings on exiting abnormally. 
#------------------------------
ttyctl -f

#------------------------------
# starship
#------------------------------
 eval "$(starship init zsh)"

#------------------------------
# ohmyzsh plugins
#------------------------------
plugins=(
		git
		# git-prompt
		rsync
		catimg
	#	last-working-dir
		sudo
		z
		# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
		zsh-autosuggestions
)

#------------------------------
#ohmyzsh
#------------------------------
source $ZSH/oh-my-zsh.sh

#------------------------------
#loading personal configs
#------------------------------
[[ -f ~/.myrc ]] && . ~/.myrc

#------------------------------
#broot
#------------------------------
source /home/rakshas/.config/broot/launcher/bash/br

#------------------------------
#must be last
#------------------------------
source ~/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


