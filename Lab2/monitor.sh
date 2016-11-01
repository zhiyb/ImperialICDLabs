#!/bin/bash

old=$(stat . -c %Y)
while sleep 1; do
	new=$(stat . -c %Y)
	(($new == $old)) && continue
	echo "Modified: $old, $new"
	find -empty -delete
	until make clean && make acrord; do
		read -s
	done
	new=$(stat . -c %Y)
	old=$new
done
