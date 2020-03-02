#!/bin/bash -x

echo "-------------------------------------------------WELL COME TO TIC TAC TOE GAME------------------------------------------"

#TO DECLARE DICTIONARY
declare -a gameBoard
	gameBord=(0,0,0,0,0,0,0,0,0)

#TO CHECK THE SYMBOL 'X' AND '0'
assingLatter=$((RANDOM%2))

if [ $assingLatter -eq 0 ]
then
		echo "The game symbol in 'X'"
else
		echo "The game symbol in '0'"
fi
