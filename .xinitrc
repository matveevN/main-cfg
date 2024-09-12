
xrandr --dpi 144
feh --bg-scale /home/nikita/wallpaper/1.jpg
setxkbmap -layout "us,ru" -option "grp:rshift_toggle"

slstatus &
exec dbus-launch --sh-syntax --exit-with-session dwm 

