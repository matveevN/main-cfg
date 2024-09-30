
xrandr --dpi 144
feh --bg-scale /home/nikita/wallpaper/baby-groot-4k-2019_1559764124.jpg
setxkbmap -layout "us,ru" -option "grp:rshift_toggle"

slstatus &
redshift -O 4500 &
exec dbus-launch --sh-syntax --exit-with-session dwm 
