#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

hang(){
	((FAILCOUNT+=1))
	echo "WRONG !!! $ATEMPTLEFT atempt left"
	ATEMPTLEFT=$(($MAXAPTEMPT-$FAILCOUNT))
}

# Parameters
MINWORDSIZE=4
MAXAPTEMPT=7

# Cloose the word
while : ; do
	WORD=$(compgen -ab | shuf -n 1̀)
	[ ${#WORD} -lt "$MINWORDSIZE" ] || break
done

# Init
FAILCOUNT=0
ATEMPTLEFT=$MAXAPTEMPT
ABC=$(echo {a..z})
WORDLEFT="${WORD}"

until [ "$WORDLEFT" == "" ] || [ "$FAILCOUNT" -gt "$MAXAPTEMPT" ]; do
	echo -n "$WORD" | tr "$WORDLEFT" .
	echo " ($((${#WORD}-${#WORDLEFT}))/${#WORD})"
	read L
	case ${#L} in 
		0)
			continue ;;
		1)
			case "$WORD" in
				*"$L"* )
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

if [ "$FAILCOUNT" -gt "$MAXAPTEMPT" ]; then
	echo "You Loose ! The word was $WORD"
else
	echo "You Win !"
fi 

