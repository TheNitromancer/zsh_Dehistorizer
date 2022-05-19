#!/bin/sh

history=./.zsh_history
currentLines=$(grep -c '^' $history)
wordToBeSearched=""
currentWord=""
contrastor=0
searchdex=""

echo "Currently handling a grand total of: $currentLines lines. Please stand by..."
while (( $currentLines - $contrastor > 0 ))
do
	searchdex=1
	wordToBeSearched=$(awk "NR==$currentLines - $contrastor" $history | cut -d ";" -f 2)
#	echo "$wordToBeSearched A BUSCAR"
	while (( $currentLines - $contrastor - $searchdex > 0 ))
	do
		currentWord=$(awk "NR==$currentLines - $contrastor - $searchdex" $history | cut -d ";" -f 2)
#		echo $currentWord
		if test "$currentWord" == "$wordToBeSearched"
		then
			sed -i .bak "$((currentLines - $contrastor - $searchdex)) d" $history
			currentLines=$(grep -c '^' $history)
			echo "Line deleted. New number of lines: $currentLines"
			let "searchdex--"
		fi
		let "searchdex++"
	done
	let "contrastor++"
done
echo "Lines after cleanup: $currentLines"
