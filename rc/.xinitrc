source /etc/X11/xinit/xinitrc

if pgrep -x "bspwm" > /dev/null
then
    killall bspwm
fi

xsetroot -cursor_name left_ptr &

bspwm
