#!/bin/bash

DIR="/home/$USER/graphite-api-docker"
cd $dir
[[ -d index ]] || mkdir index
[[ -d logs ]] || mkdir logs

tmux new -d -s graphite-api
tmux send-keys -t graphite-api "cd ${DIR}; singularity  run --bind /var/lib/graphite,${DIR}/index:/var/lib/graphite-api,${DIR}/logs:/var/log/graphite graphite-api.sif" C-m
tmux detach -s graphite-api
