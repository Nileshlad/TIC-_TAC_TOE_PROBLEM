#!/bin/bash -x

echo "-------------------------------------------------WELL COME TO TIC TAC TOE GAME------------------------------------------"

#CONSTANT
PLAYER=0
COMPUTER=0
POSSITION=9

#TO DECLARE DICTIONARY
declare -a gameBoard 

function resettingBoard(){
	for (( index=0; index<=$POSSITION; index++ ))
	do
		board[$index]=$index
	done
}
#TO FUNCTION CALL
resettingBoard

#TO CHECK THE SYMBOL 'X' AND '0'
assingLatter=$((RANDOM%2))

#TO CHECK WHO'S FIRST PLAY
function checkForFirst (){
   toss=$assingLatter
      if [ $toss -eq 1 ]
      then
			PLAYER="X"
      else
			PLAYER="O"
      fi
}
#TO FUNCTION CALL
checkForFirst

#TO DISPLAY GAME BORD
function displayBoard(){

	echo "--- --- ---"
	echo "| ${board[1]} | ${board[2]} | ${board[3]} |"

	echo "--- --- ---"
	echo "| ${board[4]} | ${board[5]} | ${board[6]} |"

	echo "--- --- ---"
	echo "| ${board[7]} | ${board[8]} | ${board[9]} |"
}

#TO VALIDATION
function validation (){
	displayBoard
	count=0
	read -p "Enter the number between 1 to 9 " POSSITION
	for (( index=0; index<=$POSSITION; index++ ))
	do
		if [ $POSSITION -eq $index ]
		then
			count=1
			break
		else
			count=0
		fi
	done
		if [ $count -eq 1 ]
		then
			board[$index]=X
			displayBoard ${board[$index]}
		else
			validation
		fi
}

#TO FUNCTION CALL
validation
