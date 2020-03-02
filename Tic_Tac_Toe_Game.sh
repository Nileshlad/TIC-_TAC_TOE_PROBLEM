#!/bin/bash -x

echo "-------------------------------------------------WELL COME TO TIC TAC TOE GAME------------------------------------------"

#CONSTANT
PLAYER=0
COMPUTER=1

#TO DECLARE DICTIONARY
declare -a gameBord
   gameBord=(0,0,0,0,0,0,0,0,0)

#TO CHECK THE SYMBOL 'X' AND '0'
assingLatter=$((RANDOM%2))

#TO CHECK WHO'S FIRST PLAY
function CheckForFirst (){
	toss=$assingLatter
		if [ $toss -eq 0 ]
			then
				echo "The game symbol in 'X'"
				echo "The plays first in player :$PLAYER"
			else
				echo "The game symbol in '0'"
				echo "The plays first in computer :$COMPUTER"
		fi
}
CheckForFirst
