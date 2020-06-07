# Does not work at the moement
tail /proc/$(ps -ef | grep '[X]session' | head -n 2 | awk '{ print $2 }' )/fd/2 --follow

# Might need to enable logging https://i3wm.org/docs/debugging-release-version.html
