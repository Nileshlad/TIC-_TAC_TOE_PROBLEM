#!/bin/bash -x

echo "-------------------------------------------------WELL COME TO TIC TAC TOE GAME------------------------------------------"

#CONSTANT
POSITION=9
PLAYER_LETTER="X"
COMPUTER_LETTER="O"
HEAD=1
TAIL=0
COMPUTER_CALL=$TAIL
PLAYER_CALL=$HEAD
RESET_LETTER="_"

#VARIABLES
chance=0
valid=true
stop=false

#TO DECLARE
declare -a gameBoard

for (( index=1; index<=$POSITION; index++))
do
   gameBoard[$index]=$RESET_LETTER
done

function toss(){
	headOrTail=$((RANDOM%2))
	if [[ $headOrTail -eq $PLAYER_CALL ]]
	then
		echo "player"
	else
		echo "computer"
	fi
}

function displayBoard(){
	for (( index=1; index<=$POSITION; index=$(($index+3)) ))
	do
		echo "${gameBoard[index]} |  ${gameBoard[index+1]} | ${gameBoard[index+2]}"
	done
}

function rowPosition(){
   local index
	for (( index=1; index<=$POSITION; index=$(($index+3)) ))
   do
   	if [[ ${gameBoard[$index]} == ${gameBoard[$index+1]} ]] &&  [[ ${gameBoard[$index+1]} == $1 ]]
   	then
			if [[ ${gameBoard[$index+2]} == $RESET_LETTER ]]
			then
         	 echo "possible postion for winning is $(($index+2)) "
			fi
   	elif [[ ${gameBoard[$index]} == ${gameBoard[$index+2]} ]] &&  [[ ${gameBoard[$index+2]} == $1  ]]
   	then
			if [[ ${gameBoard[$index+1]} == $RESET_LETTER ]]
         then
				echo "possinle position for winning is $(($index+1))"
			fi
   	elif [[ ${gameBoard[$index+1]} == ${gameBoard[$index+2]} ]] &&  [[ ${gameBoard[$index+2]} == $1  ]]
   	then
			if [[ ${gameBoard[$index]} == $RESET_LETTER ]]
			then
				echo "possible position for winning is $(($index))"
			fi
   	fi
   done
}

function columnPosition(){
	local index
	for (( index=1; index<=$POSITION; index=$(($index+1)) ))
	do
   	if [[ ${gameBoard[$index]} == ${gameBoard[$index+3]} ]] &&  [[ ${gameBoard[$index+3]} == $1 ]]
   	then
			if [[ ${gameBoard[$index+6]} == $RESET_LETTER ]]
         then
				echo "possible postion for winning is $(($index+6))"
         fi
   	elif [[ ${gameBoard[$index]} == ${gameBoard[$index+6]} ]] &&  [[ ${gameBoard[$index+6]} == $1  ]]
   	then
         if [[ ${gameBoard[$index+3]} == $RESET_LETTER ]]
         then
         	echo "possinle position for winning is $(( $index+3 ))"
         fi
   	elif [[ ${gameBoard[$index+3]} == ${gameBoard[$index+6]} ]] &&  [[ ${gameBoard[$index+6]} == $1  ]]
   	then
         if [[ ${gameBoard[$index]} == $RESET_LETTER ]]
         then
      	   echo "possible position for winning is $(( $index ))"
         fi
   	fi
	done
}

function diagonalPosition(){
	if [ ${gameBoard[1]} == ${gameBoard[5]} ] && [ ${gameBoard[5]} == $1 ]
   then
      if [ ${gameBoard[9]} == $RESET_LETTER ]
      then
			echo "possible position for winning is 9"
      fi
   elif [ ${gameBoard[1]} == ${gameBoard[9]} ] && [ ${gameBoard[9]} == $1 ]
   then
      if [ ${gameBoard[5]} == $RESET_LETTER ]
      then
			echo "possible position for winning is 5"
      fi
   elif [ ${gameBoard[5]} == ${gameBoard[9]} ] && [ ${gameBoard[9]} == $1 ]
   then
      if [ ${gameBoard[1]} == $RESET_LETTER ]
      then
			echo "possible position for winning is 1"
      fi
   elif [ ${gameBoard[3]} == ${gameBoard[5]} ] && [ ${gameBoard[5]} == $1 ]
   then
      if [ ${gameBoard[7]} == $RESET_LETTER ]
      then
         echo "possible position for winning is 7"
      fi
   elif [ ${gameBoard[7]} == ${gameBoard[5]} ] && [ ${gameBoard[5]} == $1 ]
   then
      if [ ${gameBoard[3]} == $RESET_LETTER ]
      then
         echo "possible position for winning is 3"
      fi
   elif [ ${gameBoard[3]} == ${gameBoard[7]} ] && [ ${gameBoard[7]} == $1 ]
   then
      if [ ${gameBoard[5]} == $RESET_LETTER ]
      then
         echo "possible position for winning is 5"
      fi
   fi
}

function playerMove(){
	read -p "Player where you want to put mark :" playerPosition
	if [[ ${gameBoard[$playerPosition]} == $RESET_LETTER ]]
	then
		gameBoard[$playerPosition]=$PLAYER_LETTER
	else
		echo "already filled"
	fi
}

function computerMove(){
	columnPosition $COMPUTER_LETTER
	rowPosition $COMPUTER_LETTER
	diagonalPosition $COMPUTER_LETTER
	read -p "Computer Where you want to put mark :" compPosition
	if [ $((${gameBoard[$compPosition]} == $RESET_LETTER )) ]
	then
		gameBoard[$compPosition]=$COMPUTER_LETTER
	else
		echo "already filled"
	fi
	checkRow $COMPUTER_LETTER
}

function checkRow(){
	max_number_rows=3
	position=1
	counter=1
	while [  $counter -le 3 ]
	do
		if [[ ${gameBoard[$position]} == ${gameBoard[$position+1]} ]] && [[  ${gameBoard[$position+1]}  ==  ${gameBoard[$position+2]} ]] && [[ ${gameBoard[$position+2]} == $1 ]]
		then
			displayBoard
			echo "PlayerWin"
			stop=true
			break
		else
			position=$(( $position+$max_number_rows ))
		fi
		counter=$(($counter+1))
	done
}

function checkColumn(){
	max_number_rows=3
	position=1
	counter=1
	while [  $counter -le 3 ]
	do
		if [[ ${gameBoard[$position]} == ${gameBoard[$position+1]} ]] && [[  ${gameBoard[$position+1]}  ==  ${gameBoard[$position+2]} ]] && [[ ${gameBoard[$position+2]} == $1 ]]
		then
			displayBoard
			echo " player wins "
			stop=true
			break
		else
			position=$(( $position+$max_number_rows ))
		fi
		counter=$(($counter+1))
	done
}

function checkDiagonal(){
	position=1
	counter=1
	while [ $counter -le 2 ]
	do
		if [[ ${gameBoard[$position]} == ${gameBoard[$position+4]} ]] && [[  ${gameBoard[$position+4]}  ==  ${gameBoard[$position+8]} ]] && [[ ${gameBoard[$position+8]} == $1 ]]
		then
			displayBoard
			echo " player  wins "
			stop=true
			break
		elif [[ ${gameBoard[$position+2]} == ${gameBoard[$position+4]} ]] && [[  ${gameBoard[$position+4]}  ==  ${gameBoard[$position+6]} ]] && [[ ${gameBoard[$position+6]} == $1 ]]
		then
			displayBoard
			echo " player wins "
			stop=true
			break
		fi
		counter=$(($counter+1))
	done
}

function finalWin(){
	count=1
	while [ ${gameBoard[$count]} != '-' ]
	do
		if [ $count -eq 9 ]
		then
			displayBoard
			echo "Game Is tie"
			stop=true
			break
		else
			count=$($count+1)
		fi
	done
}

toss
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
