############################################################
# .bashrc
############################################################

#Ibus settings if you need them
#type ibus-setup in terminal to change settings and start the daemon
#delete the hashtags of the next lines and restart
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=dbus
#export QT_IM_MODULE=ibus

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups

#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases

#PS1='[\u@\h \W]\$ '
#PS1='[\W]\$ '

# load personal configs
[[ -f ${XDG_CONFIG_HOME}/myrc/mybashrc ]] && . ${XDG_CONFIG_HOME}/myrc/mybashrc

[[ -f /usr/bin/starship ]] && eval "$(starship init bash)" # initialize starship
source <(COMPLETE=bash jj) # auto complete for jujutsu
