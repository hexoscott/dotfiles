#!/bin/sh

COUNT=$(tmux ls | grep dev | wc -l)

if [ $COUNT -eq 1 ] ; then
	tmux attach -t dev
else
	tmux new-session -s 'dev' -d
	tmux split-window -h
	tmux split-window -v
	tmux -2 attach-session -d
fi

