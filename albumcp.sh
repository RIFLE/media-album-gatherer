#!/bin/bash

# Move media albums from unclean directories.
# Script automatically finds everything it needs to copy according to provided data.
# Script prompts for data so no args need being passed.

# Locate this script in the source directory.

echo "Info: script will execute from current directory. ($(pwd))";

read -p "Prompt for destination (path to output dir): " DIR_DEST;

read -p "Prompt for mediafile extension (only extension): " FILE_EXT;

read -p "Prompt for mediafile album name (substring): " MEDIA_ALBUM;


if [ ! -e $DIR_DEST ]; then
	
	echo "stdwrn: Specified object '${DIR_DEST}' does not exist." >&2;

	read -p "(Try create 'y' / Cancel 'n'): " CHOICE;

	if [[ ${CHOICE,,} != 'y' ]]; then
		echo "Aborting.." && exit 0;
	fi

	mkdir -p $DIR_DEST;

	if (( $? != 0 )); then
		echo "stderr: Impossible to create specified path." >&2 && exit 1;
	fi

elif [ ! -d $DIR_DEST ]; then
	echo "stderr: Incorrect type of '${DIR_DEST}': not a directory." >&2 && exit 2;
elif [ ! -r $DIR_DEST ]; then
	echo "stderr: No rights to operate the object '${DIR_DEST}' as $(whoami)" >&2 && exit 3;
fi


FILE_QUANTITY=$(find . | wc -l)

FILE_NAMES_STR=$(find ./*.${FILE_EXT} -maxdepth 1 | tr '\n' "%" )

ALBUMS_STR=$(find ./*.${FILE_EXT} -maxdepth 1 -exec mediainfo {} + | grep -w --regex='Album ' | awk -F':' '{ $1=""; print}' | tr '\n' "%")

for ((i=1; i<=$FILE_QUANTITY; i++ )); do
	ALBUMS[$i]=$(echo $ALBUMS_STR | cut -d% -f$i);
	FILE_NAMES[$i]=$(echo $FILE_NAMES_STR | cut -d% -f$i);
done

INDEX=0

for ((i=1; i<=$FILE_QUANTITY; i++ )); do
	if [[ ${ALBUMS[$i]} == *"$MEDIA_ALBUM"* ]]; then
		
		mv -v "./${FILE_NAMES[$i]}" "${DIR_DEST}/${FILE_NAMES[$i]}"  
		
		if (( $? != 0 )); then
			echo "stderr: Impossible to move ${FILE_NAMES[$i]}" >&2;
			continue;
		else
			((INDEX++));
		fi
	fi
done

echo "stdinf: Done moving ${INDEX} files.";

exit 0;