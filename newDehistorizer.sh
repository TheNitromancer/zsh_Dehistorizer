#!/bin/sh

history=./.zsh_history
numOlines=$(grep -c "^" $history)
lineOffset=0
currentWord=""
ocurrences=0

# Delete spureus lines
#sed '/^:/!d' $history

# Get words from the bottom up
currentWord=$(awk "NR==$numOlines-$lineOffset" $history | cut -d ";" -f2-)

# Count how many ocurrences it has
ocurrences=$(grep -c ":0;$currentWord$" $history)

# Delete all of them except the last one
sed "//$((ocurrences-1))d"
