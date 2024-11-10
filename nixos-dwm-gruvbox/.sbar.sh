#!/bin/sh
 
layout(){
    t=$(xset -q | grep LED)
    code=${t##*mask:  }
    if [[ $code -eq "00000002" ]]; then
            result="EN"
    else
            result="RU"
    fi
    echo $result
}


fdate(){
    date +"%H:%M"
}



cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  icon=" 󱇪 "
#  printf " ^c#7ca198^ %s %s \\n" "$icon""$cpu%"
  printf "%s %s \\n" "$icon ""$cpu%"
}

vol(){
vol="$(amixer get Master | grep 'Playback' | grep -o '...%' | sed 's/\[//' | sed 's/%//' | sed 's/ //'| awk '{print $1; exit}')"
icon="  "
#printf " ^c#e4b371^ %s %s \\n" "$icon""$vol%"  
printf "%s %s \\n" "$icon ""$vol%"  
}


generate_content(){
        echo " | $(cpu) | $(vol)|  $(layout)  |  $(fdate)  |"
}


while true; do
    xsetroot -name "$(generate_content)"
    sleep 1
done
