#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

HANGCOUNT=0
ATEMPT=7
hang(){
	((HANGCOUNT+=1))
	echo "WRONG !!! $HANGCOUNT/$ATEMPT left"
}

ABC=$(echo {a..z})

while : ; do
	WORD=$(compgen -ab | shuf -n 1̀)
	[ ${#WORD} -lt 5 ] || break
done

# For cheater only
# echo "word=$WORD"
WORDLEFT="${WORD}"

until [ "$WORDLEFT" == "" ] || [ "$HANGCOUNT" -gt "$ATEMPT" ]; do
	echo -n "$WORD" | tr "$WORDLEFT" .
	echo " ($((${#WORD}-${#WORDLEFT}))/${#WORD})"
	read L
	case ${#L} in 
		1)
			case "${WORD}" in
				*"${L}"* )
					WORDLEFT="${WORDLEFT//$L}";;
				*) hang ;;
			esac ;;
		*)																	
			if [ "$WORD" == "$L" ]; then
				break
			else 
				hang
			fi	;;
	esac
done

if [ "$HANGCOUNT" -gt "$ATEMPT" ]; then
	echo "You Loose ! The word was $WORD"
else
	echo "You Win !"
fi 

