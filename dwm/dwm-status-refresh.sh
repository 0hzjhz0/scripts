#!/bin/bash

# Dependencies: 
# - https://pictogrammers.github.io/@mdi/font/5.4.55/
# - ttf-material-design-icons-git


# A dwm_bar function to show the master volume of ALSA
# Joe Standring <git@joestandring.com>
# GNU GPLv3
# Dependencies: alsa-utils

dwm_alsa () {
	STATUS=$(amixer sget Master | tail -n1 | sed -r "s/.*\[(.*)\]/\1/")
    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    printf "%s" "$SEP1"
    #if [ "$IDENTIFIER" = "unicode" ]; then
    if [ "$STATUS" = "off" ]; then
            printf "󰸈"
    else
      #removed this line becuase it may get confusing
        if [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf "󰕿 %s%%" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf "󰖀 %s%%" "$VOL"
        else
            printf "󰕾 %s%%" "$VOL"
        fi
    fi
    printf "%s\n" "$SEP2"
}



show_net() {
  if [ -f "/sys/class/net/enp0s3/carrier" ]; then
    echo "LAN connected"
  elif [ -f "sys/class/net/lo/carrier" ]; then
    echo "$(nmcli -t -f active,ssid, dev wifi | egrep '^yes' | cut -d\' -f2 | cut -d ':' -f2)"
  else 
    echo "No network"
  fi
}

show_bat() {
  if [ -f "/sys/class/power_supply/BAT0/capacity" ];then
    echo $(cat /sys/class/power_supply/BAT0/capacity)%
  else
    echo 100%
  fi
}

show_date() {
  date '+%b %d, %Y'
}

show_time() {
  date '+%R'
}

xsetroot -name " 󰤨 $(show_net) 󰇙 󰋑 $(show_bat) 󰇙 $(dwm_alsa) 󰇙 󰃭 $(show_date) 󰇙 󰥔 $(show_time) "

exit 0
