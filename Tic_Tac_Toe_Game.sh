#!/bin/bash -x

echo "-------------------------------------------------WELL COME TO TIC TAC TOE GAME------------------------------------------"

#DECLEAR DICTIONARY
declare -a gameBoard

#CONSTANT
POSITION=9
PLAYER_LETTER="X"
COMPUTER_LETTER="O"
RESET_LETTER="_"

#VARIABLES
chance=0
valid=true
stop=false

#DECLEAR GAME BOARD
declare -a gameBoard
	for (( index=1; index<=$POSITION; index++))
	do
	   gameBoard[$index]=$RESET_LETTER
	done

#CHECK TO PLAY FIRST
function toss(){
	toss=$((RANDOM%2))
	if [[ $toss -eq 1 ]]
	then
		echo "player"
	else
		echo  "computer"
	fi
}

#TO DISPLAY GAME BOARD
function displayBoard(){
	for (( index=1; index<=$POSITION; index=$(($index+3)) ))
	do
		echo  "${gameBoard[index]} |  ${gameBoard[index+1]} | ${gameBoard[index+2]}"
	done
}

#TO PLAYER MOVE
function playerMove(){
	read -p "Player where you want to put mark :" playerMarkPosition
	if [[ ${gameBoard[$playerMarkPosition]} == $RESET_LETTER ]]
	then
		gameBoard[$playerMarkPosition]=$PLAYER_LETTER
	else
		echo  "already filled"
	fi
}

#TO COMPUTER MOVE
function computerMove(){
	read -p "Computer Where you want to put mark :" compMarkPosition
	if [[ ${gameBoard[$compMarkPosition]} == $RESET_LETTER ]]
	then
		gameBoard[$compMarkPosition]=$COMPUTER_LETTER
	else
		echo "already filled"
	fi
		checkRow $COMPUTER_LETTER
	}

#TO ROW FUNCTION
function checkRow(){
	for (( index=1; index<=9; index=index+3 ))
	do
		if [[ ${gameBoard[$index]} == ${gameBoard[$index+1]} ]] && [[ ${gameBoard[$index+1]} == ${gameBoard[$index+2]} ]] && [[ ${gameBoard[$index+2]} == $playerSymbol ]]	
		then
			displayBoard
			echo "Game Win"
			exit
		fi
	done
}

#TO COLUMN FUNCTION
function checkColumn(){
		for (( index=1; index<=3; index++ ))
		do
		if [[ ${gameBoard[$index]} == ${gameBoard[$index+3]} ]] && [[ ${gameBoard[$index+3]} == ${gameBoard[$index+6]} ]] && [[ ${gameBoard[$index+6]} == $playerSymbol ]]
		then
			displayBoard
			echo "Game win"
			exit
		fi
		done
}

#TO CHECK DIAGONAL 
function checkDiagonal(){
	for (( index=1; index<2; index++ ))
	do
		if [[ ${gameBoard[$index]} == ${gameBoard[$index+4]} ]] && [[ ${gameBoard[$index+4]} == ${gameBoard[$index+8]} ]] && [[ ${gameBoard[$index+8]} == $playerSymbol ]]
		then
			displayBoard
			printf "Game Win"
			exit
		elif [[ ${gameBoard[$index+2]} == ${gameBoard[$index+4]} ]] && [[ ${gameBoard[$index+4]} == ${gameBoard[$index+6]} ]] && [[ ${gameBoard[$index+6]} == $playerSymbol ]]
		then
			displayBoard
			printf "Game Win"
			exit
			fi
		done
}

#TO CHECK TO WIN
function finalWin(){
	count=1
	while [ ${gameBoard[$count]} != '-' ]
	do
		if [ $count -eq 9 ]
		then
		displayBoard
		printf "Game Is tie"
		stop=true
		break
		else
		count=$($count+1)
		fi
		done
	}

#TO CHECK CHANCE AND MAIN FUNCTION CALL
function main(){
	while [ $stop == false ]
	do
		displayBoard
		if [[ $(($chance%2)) -eq 0 ]]
		then
			playerMove
			chance=$(($chance+1))
		else
			computerMove
			chance=$(($chance+1))
		fi
done
}
main

