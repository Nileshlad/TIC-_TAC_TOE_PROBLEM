#!/bin/bash -x

echo "-------------------------------------------------WELL COME TO TIC TAC TOE GAME------------------------------------------"

# CONSTANTS
BOARD_POSITION=9
ROWS=3
COLUMNS=3
HEAD=1
TAIL=0

# VARIABLES
playerTurn=false
winner=false
turn=0
player1=0
player2=0
nonEmptyCount=1

# STORE IN ARRAY
declare -a board

# FUNCTION FOR BOARD INITAILISE
function boardInitialize(){
	for (( index=1 ; index<=$BOARD_POSITION; index++ ))
	do
		board[$index]=0
	done
}

# DISPLAY BOARD
function  displayBoard(){
	echo " ------------- "
	echo " | "${board[1]}" | "${board[2]}" | "${board[3]}" | "
	echo " ------------- "
	echo " | "${board[4]}" | "${board[5]}" | "${board[6]}" | "
	echo " ------------- "
	echo " | "${board[7]}" | "${board[8]}" | "${board[9]}" | "
	echo " ------------- "
}

# HORIZONTAL CHECK
function checkHorizontal(){
	local position=1
	counter=1
	while [ $counter -le $ROWS ]
	do
		if [[ ${board[$position]} == ${board[$position+1]} ]] && [[ ${board[$position+1]} == ${board[$position+2]} ]] && [[ ${board[$position+2]} == $1 ]]
		then
			displayBoard
			echo "$1 wins"
			winner=true
			break
		else
			position=$(( $position+$ROWS ))
		fi
			counter=$(( $counter+1 ))
	done
}

# VERTICAL CHECK
function checkVertical(){
	position=1
	counter=1
	while [ $counter -le $ROWS ]
	do
		if [[ ${board[$position]} == ${board[$position+3]} ]] && [[ ${board[$position+3]}  ==  ${board[$position+6]} ]] && [[ ${board[$position+6]} == $1 ]]
		then
			displayBoard
			echo "$1 Wins"
			winner=true
			break
		else
			position=$(( $position+1 ))
		fi
			counter=$(( $counter+1 ))
	done
}

# DIAGONAL CHECK
function checkDiagonal(){
	position=1
	counter=1
	while [ $counter -le 2 ]
	do
		if [[ ${board[$position]} == ${board[$position+4]} ]] && [[ ${board[$position+4]}  ==  ${board[$position+8]} ]] && [[ ${board[$position+8]} == $1 ]]
		then
			displayBoard
			echo " $1 wins "
			winner=true
			break
		elif [[ ${board[$position+2]} == ${board[$position+4]} ]] && [[  ${board[$position+4]}  ==  ${board[$position+6]} ]] && [[ ${board[$position+6]} == $1 ]]
		then
			displayBoard
			echo " $1 wins "
			winner=true
			break
		fi
			counter=$(($counter+1))
	done
}

# CHECK TIE CASE
function checkTie(){
	while [[ ${board[$nonEmptyCount]} -ne 0 ]]
	do
		if [ $nonEmptyCount -eq $BOARD_POSITION ]
		then
			displayBoard
			echo "Game is tie"
			winner=true
			break
		else
			nonEmptyCount=$(($nonEmptyCount+1))
		fi
	done
}

# USER INPUT1
function userInput1() {
	row=1
	column=3
	winMovePlayer1=false
	read -p "Enter player1 in between 1 to 9: " POSITION
	if [ $winMovePlayer1 == false ]
	then
		if [ ${board[$POSITION]} -eq $TAIL ]
		then
			echo "Player turn"
			board[$POSITION]=$player1
			displayBoard
			turn=$(( $turn + 1 ))
		else
			echo "Invalid input"
         userInput1
		fi
	fi
	playerTurn=false
}

# USER INPUT2
function userInput2() {
	row=1
	column=3
	winMovePlayer2=false
	POSITION=$((RANDOM%9))
	if [ $winMovePlayer2 == false ]
	then
		if [ ${board[$POSITION]} -eq $TAIL ]
		then
			echo "Player turn"
			board[$POSITION]=$player2
			displayBoard
			turn=$(( $turn + 1 ))
		else
			echo "Invalid input"
         userInput2
		fi
	fi
			playerTurn=true
}

# FUNCTION FOR TIC TAC TOE
function ticTacToe(){
	checkingToss=$((RANDOM%2))
	if [[ $checkingToss -eq $HEAD ]]
	then
		playerTurn=true
		player1='X'
		player2='O'
			echo "Player1 will play first"
		displayBoard
	else
		player2='X'
		player1='O'
			echo "Player2 will play first"
	fi
}

# FUNCTION CALL
boardInitialize
ticTacToe

# CHECK WHO WINS
while [ $winner == false ]
do
	displayBoard
	if [ $playerTurn == true ]
	then
		userInput1 $player1
		checkHorizontal $player1
		checkVertical $player1
		checkDiagonal $player1
		checkTie $player1
	else
		userInput2 $player2
		checkHorizontal $player2
		checkVertical $player2
		checkDiagonal $player2
		checkTie $player2
	fi
done
