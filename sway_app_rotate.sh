#!/bin/sh
# Get the current focused application and write it into $WINDOWNAME then get the IDs of the focused application and write the next one into $WINDOWID and show the ID.
WINDOWNAME=$(swaymsg -r -t get_tree | jq '.nodes[].nodes[].floating_nodes|.[]|select(.focused==true)|.app_id'|sed 's/\"//g')
WINDOWID=$(swaymsg -t get_tree | jq -r -S '.nodes[].nodes[]|select(.floating_nodes[].focused==true)|.floating_nodes[]|select(.app_id=="'$WINDOWNAME'")|del(.|select(.focused==true))|.id' | head -n 1)
echo $WINDOWID

# sway config must include:
## bind Alt+` to exec swaymsg and focus the container id from above script.
# bindsym Mod1+grave exec swaymsg [con_id=$(/PATH/TO/SCRIPT.sh)] focus
