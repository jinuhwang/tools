# xrandr --output DP-0  --auto --output DP-2 --auto --panning 1354x2408+0+0 --rotate left --scale 0.627x0.627 
# xrandr \
#     --output DP-0  --primary --pos 1354x0 --mode 3840x2160 --fb 5194x2408 --panning 0x0+0+0 \
#     --output DP-2  --rotate left --scale 0.627x0.627 --pos 0x0 --panning 0x0+0+0 --fb 5194x2408

# xrandr --output DP-0 --primary
# xrandr --output DP-2 --rotate left
# xrandr --output DP-2 --left-of DP-0
# xrandr --output DP-2 --scale 0.627x0.627
# xrandr --output DP-0 --auto
# xrandr --output DP-0 --pos 1354x0

# xrandr --output DP-2 --rotate left --pos 0x0 --scale 0.627x0.627 \
#     --output DP-0 --auto --pos 1354x0 --primary

xrandr \
    --output DP-0 --off \
    --output DP-2 --noprimary --auto --scale 0.63x0.63 --rotate left  --panning 1361x2419+0+0 \
    --fb 5201x2419

xrandr \
    --output DP-0 --primary --scale 0.75x0.75 --mode 5120x2160 --pos 1361x390 --panning 3840x1620+1361+390
