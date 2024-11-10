feh --bg-scale ~/Pictures/waal/gruvbox-light-rainbow.png &
./.sbar.sh &
picom --config .config/picom/picom.conf  --frame-opacity=0.1 --inactive-opacity=0.93 --active-opacity=0.93 --backend glx -f &

exec dwm
