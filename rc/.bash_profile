#
# ~/.bash_profile
#

[[ -f ~/.config/myrc/profile ]] && . ~/.config/myrc/profile

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
