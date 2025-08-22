#
# ~/.bash_profile
#

[[ -f ~/.config/myrc/globals ]] && . ~/.config/myrc/globals
[[ -f ~/.config/rc/.bashrc ]] && . ~/.config/rc/.bashrc

# load xrc temporary configs
[[ -f ${XDG_DATA_HOME}/xrc ]] && . ${XDG_DATA_HOME}/xrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
