#!/bin/sh

history=./.zsh_history
currentLines=$(grep -c '^' $history)
wordtobesearched=""
contrastor=1
searchdex=0

echo "Currently handling a grand total of: $currentLines lines. Please stand by..."
#while [$currentLines - $contrastor -gt 0]
#do
	wordtobesearched=$(awk "NR==$currentLines - $contrastor" $history | cut -d ";" -f 2)
	echo $wordtobesearched
#done
#sed "$currentLines d" $history #Currently successful at removing the last line. -i will change the history file.

