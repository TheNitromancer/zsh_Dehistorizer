#!/bin/sh

# history=./.zsh_history
# newFile=./tempHist
# numOlines=$(grep -c "^" $history)
# lineOffset=0
# currentWord=""
# ocurrences=0
#
# # Delete spureus lines
# #sed '/^:/!d' $history
#
# # Get words from the bottom up
# currentWord=$(awk "NR==$numOlines-$lineOffset" $history | cut -d ";" -f2-)
#
# # Count how many ocurrences it has
# ocurrences=$(grep -c ":0;$currentWord$" $newFile)

# If the command isn't already in the new file, append it


#!/bin/sh

history=./prueba
temp=./temp_zsh_history
newFile=./new_zsh_history

currentLine=""
currentCommand=""

numOlines=""
counter=1

# Remove spureus lines, flip the file and store it into a temp
# sed '/^:/!d' $history | tail -r | cat > temp_zsh_history 
tail -r $history | cat > $temp
# Store the amount of lines of the file
numOlines=$(grep -c "^" $temp)

# Create the output file
echo "" | cat > $newFile

# Cicle each line
while [[ "$counter" -le "$numOlines" ]]
do
	currentLine=$(awk "NR==$counter" $temp)
	currentWord=$(echo $currentLine | cut -d ";" -f2-)
	if [[ $(grep -c ":0;$currentWord ºªºªº " $newFile) -eq 0 ]]
	then
		sed -i '' "s/^/$currentLine ºªºªº /" $newFile
	fi
	((counter += 1))
done

# Substitute the weird marker for a newline
sed -i '' 's/ ºªºªº /\
/g' $newFile

# Delete empty lines
sed -i '' "/^$/d" $newFile
