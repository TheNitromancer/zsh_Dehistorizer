#!/bin/sh

history=./prueba
temp=./temp_zsh_history
newFile=./new_zsh_history

currentLine=""
currentCommand=""
sedSafeLine=""

numOlines=""
counter=1

# Define a function to process commands for characters that would mess with sed
function sedSaver {
	echo $1 | sed 's/\\/\\\\/g; s/\./\\\./g; s/\*/\\\*/g; s/\//\\\//g'
}

# Remove spureus lines, flip the file and store it into a temp
sed '/^:/!d' $history | tail -r | cat > $temp

# Store the amount of lines of the file
numOlines=$(grep -c "^" $temp)

# Create the output file
echo "" | cat > $newFile

# Cicle each line
while [[ "$counter" -le "$numOlines" ]]
do
	currentLine=$(awk "NR==$counter" $temp)
	currentCommand=$(echo $currentLine | cut -d ";" -f2-)
	if [[ $(grep -c ":0;$currentCommand ºªºªº " $newFile) -eq 0 ]]
	then
		sedSafeLine=$(sedSaver "$currentLine")
		sed -i '' "s/^/$sedSafeLine ºªºªº /" $newFile
	fi
	((counter += 1))
done

# Substitute the weird marker for a newline
sed -i '' 's/ ºªºªº /\
/g' $newFile

# Delete empty lines
sed -i '' "/^$/d" $newFile

# Remove temp file
#rm $temp
