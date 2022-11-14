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
    --output HDMI-0 --auto --noprimary --scale 1.184x1.184 --pos 0x317 --panning 2273x1279+0+317 \
    --output DP-2 --auto --primary --pos 2273x317 --panning 3840x1600+2274+317 \
    --output DP-4 --auto --noprimary --scale 1.164x1.164 --rotate right --pos 6114x0
