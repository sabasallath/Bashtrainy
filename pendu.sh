#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

ABC=$(echo {a..z})
#vare="testvar"
#echo ${vare%var}

WORD=$(compgen -ab | shuf -n 1̀)
WORDLEFT="${WORD}"

echo "${WORD}"
echo "${ABC}"
PS3=">>"
prompt="sqs"
echo -n "2/3 : "
read LETTER
echo "$LETTER"
WORDLEFT="${WORD//$LETTER}"
echo "$WORDLEFT"