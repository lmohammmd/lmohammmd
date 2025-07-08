#!/usr/bin/bash

if [ "$1" = "launch" ]; then
    tmux new-session -d -s RB-Api-1 "./apiauto.sh"
    tmux new-session -d -s RB-Bot-1 "./cliauto.sh"
    tmux new-session -d -s RB-Cli-1 "./helperauto.sh"
    echo "Bot is running"
    
#------stopbot-----------
elif [ "$1" = "stop" ]; then
    tmux kill-session -t RB-Api-1
    tmux kill-session -t RB-Bot-1
    tmux kill-session -t RB-Cli-1
    echo "Bot is stopping"
fi
