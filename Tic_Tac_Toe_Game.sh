#!/bin/bash -x

echo "-------------------------------------------------WELL COME TO TIC TAC TOE GAME------------------------------------------"

#DECLEAR DICTIONARY
declare -a gameBoard

#VARIABLE
playerSymbol=0
computerSymbol=0

#TO GAME BOARD SIZE
function resettingBoard(){
	for(( index=1; index<=9; index++ ))
	do
			gameBoard[$index]="$index"
	done
}

#TO GAME USE THE SYMBOL
function assignLatter(){
	assignLatter=$((RANDOM%2))
	if [ $assignLatter -eq 1 ]
	then
			playerSymbol=X
	else
			computerSymbol=O
	fi
}

#TO DISPLAY BOARD
function displayBoard(){
	local index=1
	for (( indexOne=0; indexOne<3; indexOne++ ))
	do
			echo "|---|---|---|"
			echo "| "${gameBoard[$index]}" | "${gameBoard[$index+1]}" | "${gameBoard[$index+2]}" |"
			index=$(($index+3))
	done

}

#TO CHECK FOR DIAGONAL
function checkForDiagonal(){
	for (( index=1; index<2; index++ ))
			do
			if [[ ${gameBoard[$index]} == ${gameBoard[$index+4]} ]] && [[ ${gameBoard[$index+4]} == ${gameBoard[$index+8]} ]] && [[ ${gameBoard[$index+8]} == $playerSymbol ]]
			then
				displayBoard
				echo "Game Win"
				exit
			elif [[ ${gameBoard[$index+2]} == ${gameBoard[$index+4]} ]] && [[ ${gameBoard[$index+4]} == ${gameBoard[$index+6]} ]] && [[ ${gameBoard[$index+6]} == $playerSymbol ]]
			then
				displayBoard
				echo "Game Win"
				exit
			fi
		done
}

#TO CHECK FOW ROW
function checkForRow(){
		for (( row=1; row<=9; row=row+3 ))
		do
			if [[ ${gameBoard[$row]} == ${gameBoard[$row+1]} ]] && [[ ${gameBoard[$row+1]} == ${gameBoard[$row+2]} ]] && [[ ${gameBoard[$row+2]} == $playerSymbol ]]	
			then
				displayBoard
				echo "Game Win"
				exit
			fi
		done

	}
#TO CHECK FOR COLUMN
function checkForColumn(){
		for (( column=1; column<=3; column++ ))
		do
			if [[ ${gameBoard[$column]} == ${gameBoard[$column+3]} ]] && [[ ${gameBoard[$column+3]} == ${gameBoard[$column+6]} ]] && [[ ${gameBoard[$column+6]} == $playerSymbol ]]
			then
				displayBoard
				echo "Game win"
				exit
			fi
		done
}

#TO FUNCTION CALL
function checkForWin(){
		checkForDiagonal
		checkForRow
		checkForColumn
}

#TO FUNCTION PLAY
function startPlaying(){
local index=1
local minValue=0
local maxValue=9
local player="Player"

while [[ $index -gt $minValue && $index -le $maxValue ]]
do
	if [ $turn == $player ]
	then
		displayBoard
		echo "Enter the cell number to put your symbol"
		read index
					if [ ${gameBoard[$index]} -eq $index ]
					then
							gameBoard[$index]=$playerSymbol
							checkForWin
					else
							echo "check for empty cell"
					fi
	fi
done
}

#TO FUNCTION CALL
function main(){
	resettingBoard
	assignLatter
	displayBoard
	checkForWin
	startPlaying
}
main
