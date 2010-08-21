xmodmap -e 'clear Lock'
xmodmap -e 'keysym Caps_Lock = Escape'
feh --bg-scale $XDG_CONFIG_HOME/wallpaper
urxvtd -q -o -f
skype &
