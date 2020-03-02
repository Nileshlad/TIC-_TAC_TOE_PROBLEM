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

#TO VARIABLES
chance=0
valid=true
stop=false
playOnce=0

#TO DECLARE GAME BOARD AND BOARD CORNER
declare -a gameBoard
declare -a boardCorner=( 1 3 7 9 )

for (( index=1; index<=$POSITION; index++))
do
	   gameBoard[$index]=$RESET_LETTER
done

#TO CHECK TOSS
function toss(){
		local headOrTail=$((RANDOM%2))
		if [[ $headOrTail -eq $PLAYER_CALL ]]
		then
			echo "player"
		else
			echo "computer"
		fi
}

#TO DISPLAY BOARD
function displayBoard(){
		for (( index=1; index<=$POSITION; index=$(($index+3)) ))
		do
			echo "${gameBoard[index]} |  ${gameBoard[index+1]} | ${gameBoard[index+2]}"
		done
}

#TO CHECK ROE POSITION
function rowPosition(){
	   local index
		for (( index=1; index<=$POSITION; index=$(($index+3)) ))
		do
			if [[ ${gameBoard[$index]} == ${gameBoard[$index+1]} ]] &&  [[ ${gameBoard[$index+1]} == $1 ]]
			then
				if [[ ${gameBoard[$index+2]} == $RESET_LETTER ]]
				then
	         	 echo "$(($index+2))"
				break
				fi
	   	elif [[ ${gameBoard[$index]} == ${gameBoard[$index+2]} ]] &&  [[ ${gameBoard[$index+2]} == $1  ]]
			then
				if [[ ${gameBoard[$index+1]} == $RESET_LETTER ]]
				then
					echo "$(( $index+1 ))"
					break
				fi
			elif [[ ${gameBoard[$index+1]} == ${gameBoard[$index+2]} ]] &&  [[ ${gameBoard[$index+2]} == $1  ]]
			then
				if [[ ${gameBoard[$index+1]} == $RESET_LETTER ]]
				then
					echo "$(( $index ))"
				break
				fi
	   	fi
	  	done
}

#TO CHECK POSITION
function columnPosition(){
		local index
		for (( index=1; index<=$POSITION; index=$(($index+1)) ))
		do
			if [[ ${gameBoard[$index]} == ${gameBoard[$index+3]} ]] &&  [[ ${gameBoard[$index+3]} == $1 ]]
			then
				if [[ ${gameBoard[$index+6]} == $RESET_LETTER ]]
				then
					echo " $(($index+6))"
					break
	         fi
	    	elif [[ ${gameBoard[$index]} == ${gameBoard[$index+6]} ]] &&  [[ ${gameBoard[$index+6]} == $1  ]]
	    	then
				if [[ ${gameBoard[$index+3]} == $RESET_LETTER ]]
	         then
					echo "$(( $index+3 ))"
					break
	         fi
	    	elif [[ ${gameBoard[$index+3]} == ${gameBoard[$index+6]} ]] &&  [[ ${gameBoard[$index+6]} == $1  ]]
	    	then
				if [[ ${gameBoard[$index]} == $RESET_LETTER ]]
	         then
	        		echo "$(( $index ))"
					break
	         fi
	    	fi
	   done
}

function diagonalPosition(){
		if [ ${gameBoard[1]} == ${gameBoard[5]} ] && [ ${gameBoard[5]} == $1 ]
	   then
			if [ ${gameBoard[9]} == $RESET_LETTER ]
	      then
				echo "9"
	      fi
		elif [ ${gameBoard[1]} == ${gameBoard[9]} ] && [ ${gameBoard[9]} == $1 ]
	   then
			if [ ${gameBoard[5]} == $RESET_LETTER ]
			then
				echo "5"
			fi
		elif [ ${gameBoard[5]} == ${gameBoard[9]} ] && [ ${gameBoard[9]} == $1 ]
	   then
			if [ ${gameBoard[1]} == $RESET_LETTER ]
	      then
				echo "1"
			fi
		elif [ ${gameBoard[3]} == ${gameBoard[5]} ] && [ ${gameBoard[5]} == $1 ]
		then
	      if [ ${gameBoard[7]} == $RESET_LETTER ]
	      then
	         echo "7"
				gameBoard[7]=$1
	      fi
		elif [ ${gameBoard[7]} == ${gameBoard[5]} ] && [ ${gameBoard[5]} == $1 ]
	   then
	      if [ ${gameBoard[3]} == $RESET_LETTER ]
	      then
	         echo "3"
	      fi
	   elif [ ${gameBoard[3]} == ${gameBoard[7]} ] && [ ${gameBoard[7]} == $1 ]
	   then
	      if [ ${gameBoard[5]} == $RESET_LETTER ]
	      then
	         echo "5"
	      fi
	   fi
}

#TO PLAYER MOVE
function playerMove(){
		read -p "Player where you want to put mark :" playerMarkPosition
		if [[ ${gameBoard[$playerMarkPosition]} == $RESET_LETTER ]]
		then
			gameBoard[$playerMarkPosition]=$PLAYER_LETTER
		else
			echo "already filled"
		fi
}

#TO CHECK POSSIBLE POSITION
function possiblePosition(){
	local row=$( rowPosition $1 )
	   if [[ $row -eq ' ' ]]
	   then
	      local column=$( columnPosition $1)
	         if [[ $column -eq ' ' ]]
	         then
	            local diagonal=$( diagonalPosition $1)
	            if [[ $diagonal -eq ' ' ]]
	            then
						echo "0"
	            else
	               echo "$diagonal"
	            fi
	         else
	               echo "$column"
	         fi
	   else
	      echo "$row"
	   fi
}

#TO POSSIBLE CORNER
function possibleCorner(){
	for (( index=1; index<=4; index++ ))
	do
		index=${boardCorner[$index]}
		if [[ ${gameBoard[$index]} == $RESET_LETTER ]]
		then
			echo "$index"
		break
		fi
	done
}

#TO COMPUTER MOVE
function computerMove(){
		local winValue=$( possiblePosition $COMPUTER_LETTER )
		echo "possible winning position is $winValue"
		local blockValue=$( possiblePosition $PLAYER_LETTER )
		echo "possible blocking position is $blockValue"
		local checkCorner=$( possibleCorner )
		echo "possible corner $checkCorner"
		if [[ $playOnce == 0 ]]
		then
			if [[ ${gameBoard[$checkCorner]} == $RESET_LETTER ]]
			then
				gameBoard[$checkCorner]=$COMPUTER_LETTER
			else
				echo "already filled"
			fi
				playOnce=$(($playOnce+1))
		else
				gameBoard[$blockValue]=$COMPUTER_LETTER
		fi
		checkRow $COMPUTER_LETTER
}

#TO CHECK ROW
function checkRow(){
	for (( index=1; index<=9; index=index+3 ))
	do
		if [[ ${gameBoard[$index]} == ${gameBoard[$index+1]} ]] && [[  ${gameBoard[$index+1]}  ==  ${gameBoard[$index+2]} ]] && [[ ${gameBoard[$index +2]} == $1 ]]
		then
			displayBoard
			echo "PlayerWin"
			stop=true
			break
		fi
	done
}

#TO CHECK COLUMN
function checkColumn(){
	for (( index=1; index<=3; index++ ))
	do
		if [[ ${gameBoard[$index]} == ${gameBoard[$index+1]} ]] && [[  ${gameBoard[$index+1]}  ==  ${gameBoard[$index+2]} ]] && [[ ${gameBoard[$index+2]} == $1 ]]
		then
			displayBoard
			echo " player wins "
			stop=true
			break
		fi
	done
}

#TO CHECK DIAGONAL
function checkDiagonal(){
	for (( index=1; index<2; index++ ))
	do
		if [[ ${gameBoard[$index]} == ${gameBoard[$index+4]} ]] && [[  ${gameBoard[$index+4]}  ==  ${gameBoard[$index+8]} ]] && [[ ${gameBoard[$index+8]} == $1 ]]
		then
			displayBoard
			echo " player  wins "
			stop=true
			break
		elif [[ ${gameBoard[$index+2]} == ${gameBoard[$index+4]} ]] && [[  ${gameBoard[$index+4]}  ==  ${gameBoard[$index+6]} ]] && [[ ${gameBoard[$index+6]} == $1 ]]
		then
			displayBoard
			echo " player wins "
			stop=true
			break
		fi
	done
}

#TO CHECK WIN
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
			rowPosition
			chance=$(($chance+1))
		fi
	done
}

#TO FUNCTION CALL
toss
main
