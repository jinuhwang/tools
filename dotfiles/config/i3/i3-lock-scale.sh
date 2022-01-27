#Scales image to fit horizontal size of the screen while keeping the aspect ratio
convert -resize $(xdpyinfo | grep dimensions | cut -d\  -f7 | cut -dx -f1) source-image.jpg lockscreen.png

