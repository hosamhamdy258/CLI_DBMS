#!/bin/bash
clear
echo "################################################################################"
echo "#                        Welcome to H.H DBMS Project                           #"
echo "#                                                                              #"
echo "#                 ########     ################      ########                  #"
echo "#                   ####           ########            ####                    #"
echo "#                    ##               ##                ##                     #"
echo "#                    ##               ##                ##                     #"
echo "#                    ##               ##                ##                     #"
echo "#                    ##               ##                ##                     #"
echo "#                    ##               ##                ##                     #"
echo "#                    ##               ##                ##                     #"
echo "#                   ####              ##               ####                    #"
echo "#                 ########            ##             ########                  #"
echo "#                                                                              #"
echo "################################################################################"
sleep 3
function main {
	mainMenu
}

if [ ! -d "./.dbms" ]; then
	mkdir .dbms
fi
clear
function mainMenu {
	while true; do
		clear
		echo "################################################################################"
		mainListArr=("Create Database" "List Databases" "Connect To Databases" "Drop Database" "Exit")

		echo "# choose one of the blow :"
		mainListIndex=0
		while [ $mainListIndex -lt ${#mainListArr[*]} ]; do
			echo "# $(($mainListIndex + 1)) ) ${mainListArr[$mainListIndex]}"
			let mainListIndex=$mainListIndex+1
		done
		echo "################################################################################"
		read -p "# > "
		if [ $? != 0 ]; then
			break
		fi
		echo "################################################################################"
		case $REPLY in
		1) #createDatabase
			createDB
			;;
		2) #listDatabase
			listDB
			;;
		3) #connect DB
			connectDB
			;;
		4) #drop DB
			dropDB
			;;
		5)
			echo "################################################################################"
			echo "#                        Thanks For Using H.H DBMS                             #"
			echo "################################################################################"
			exit
			;;
		*)
			echo "# wrong choice please try again"
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			;;
		esac
	done
}
####################################
function createDB {
	while true; do
		dblist=()
		read -p "# Enter DB name > "
		if [ $? != 0 ]; then
			break
		fi
		dblist+=($(ls ./.dbms))
		if [[ " ${dblist[*]} " =~ " ${REPLY} " ]]; then
			echo "# DB name exist"
			echo "# Enter another name"
			#read -p "Press enter key to resume ... "
			continue
		fi
		clear
		mkdir ./.dbms/$REPLY
		echo "# DB Created successfuly"
		selectDB $REPLY
		break
	done
}
##################################
function listDB {

	while true; do
		index=0
		dblist=()
		arIndex=()

		dblist+=($(ls ./.dbms))

		for name in ${dblist[*]}; do
			arIndex+=($(($index + 1)))
			echo "# $(($index + 1)) - $name"
			let index=$index+1
		done

		if [ ${#dblist[*]} -eq 0 ]; then
			echo "# There's no DB to show go to create DB"
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			break
		fi

		read -p "# choose DB number from list > "
		if [ $? != 0 ]; then
			break
		fi

		if [[ ! " ${arIndex[*]} " =~ " ${REPLY} " ]]; then
			echo "# choose correct number from the list"
			continue
		fi
		clear
		selectDB ${dblist[($REPLY - 1)]}

		break
	done
}
########################################3

function connectDB {
	while true; do
		dbchecker=$(ls ./.dbms/ | wc -l)
		# echo $maxlines
		if [ $dbchecker -eq 0 ]; then
			echo "# There's no DBs exist go to create DB"
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			break
		fi

		dblist=()
		read -p "# Enter DB name > "
		if [ $? != 0 ]; then
			break
		fi
		dblist+=($(ls ./.dbms))
		if [[ " ${dblist[*]} " =~ " ${REPLY} " ]]; then
			clear
			selectDB $REPLY
			break
		else
			echo "# invalid DB name"
			#read -p "invalid DB name Press enter key to try again ... "
			continue

		fi

		break
	done
}

#######################################
function selectDB {
	selectedDB=$1
	echo "# DB $selectedDB is now selected"
	subMainMenu
}
#####################################
function dropDB {
	while true; do
		dbchecker=$(ls ./.dbms/ | wc -l)
		# echo $maxlines
		if [ $dbchecker -eq 0 ]; then
			echo "# There's no DBs exist go to create DB"
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			break
		fi
		dblist=()
		read -p "# Enter DB name > " answer
		if [ $? != 0 ]; then
			break
		fi
		dblist+=($(ls ./.dbms))
		if [[ " ${dblist[*]} " =~ " ${answer} " ]]; then
			read -p "# DB name exist do you want to delete it ? y/n > "
			if [ $? != 0 ]; then
				break
			fi

			if [[ $REPLY =~ [yY] ]]; then
				rm -r ./.dbms/$answer
				echo '# DB deleted Back to main menu'
				read -p "# Press enter key to resume ... "
				if [ $? != 0 ]; then
					break
				fi

			elif [[ $REPLY =~ [nN] ]]; then
				echo '# DB not deleted Back to main menu'
				read -p "# Press enter key to resume ... "
				if [ $? != 0 ]; then
					break
				fi

			else
				echo '# Answer is not valid Back to main menu'
				read -p "# Press enter key to resume ... "
				if [ $? != 0 ]; then
					break
				fi
			fi
		else
			echo "# DB name not exist"
			continue
		fi
		clear
		break
	done
}
################################################

#################################################

function subMainMenu {

	while true; do
		clear
		subListArr=("Create Table" "List Tables" "Select Table" "Drop Table" "back to DB Menu")
		echo "################################################################################"

		echo "# choose one of the blow :"
		subListIndex=0
		while [ $subListIndex -lt ${#subListArr[*]} ]; do
			echo "# $(($subListIndex + 1)) ) ${subListArr[$subListIndex]}"
			let subListIndex=$subListIndex+1
		done
		echo "################################################################################"
		read -p "# > "
		if [ $? != 0 ]; then
			break
		fi
		echo "################################################################################"
		case $REPLY in
		1) #Create Table
			createTable
			;;
		2) #List Tables
			listTables
			;;
		3) #select Table
			connectTable
			;;
		4) #Drop Table
			dropTable
			;;
		5)
			break
			;;
		*)
			echo "# wrong choice please try again"
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			;;
		esac
	done
}

############################################################
function breakChanges {
	rm ./.dbms/$selectedDB/$tbname
	rm ./.dbms/$selectedDB/.$tbname
}
#################################################

function createTable {
	while true; do
		tableList=()
		read -p "# Enter Table name > " tbname
		if [ $? != 0 ]; then
			break
		fi
		tableList+=($(ls ./.dbms/$selectedDB/))
		if [[ " ${tableList[*]} " =~ " ${tbname} " ]]; then
			echo "# Table name exist"
			echo "# Enter another name"
			#read -p "Press enter key to resume ... "
			continue
		fi
		touch ./.dbms/$selectedDB/$tbname
		touch ./.dbms/$selectedDB/.$tbname
		echo "# Table Created successfuly"

		autoPrimaryKey=0
		read -p "# Do you want set auto primary key ? y/n > "
		if [ $? != 0 ]; then
			breakChanges
			break
		fi

		if [[ $REPLY =~ [yY] ]]; then
			autoPrimaryKey=1
			echo autoPrimaryKey=1 >>./.dbms/$selectedDB/.$tbname
			echo id=0 >>./.dbms/$selectedDB/.$tbname

		elif [[ $REPLY =~ [nN] ]]; then
			autoPrimaryKey=0
			echo autoPrimaryKey=0 >>./.dbms/$selectedDB/.$tbname
			echo id=0 >>./.dbms/$selectedDB/.$tbname
		else
			echo '# Answer is not valid Back to main menu'
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				breakChanges
				break
			fi
			breakChanges
			break
		fi
		while true; do
			read -p "# how many column you need ? > " colNum
			if [ $? != 0 ]; then
				breakChanges
				break 2
			fi
			if [[ $colNum = +([[:digit:]]) ]]; then
				break
			else
				echo "# only Numbers Allowed Please Choose Correct Number"
			fi
		done
		colIndex=1
		if [ $autoPrimaryKey -eq 1 ]; then
			dataTypeArr=("2")
			colNameArr=("id")
			colNameArr2=("id")
			echo colNum=$(($colNum + 1)) >>./.dbms/$selectedDB/.$tbname

		else
			dataTypeArr=()
			colNameArr=()
			colNameArr2=()
			echo colNum=$colNum >>./.dbms/$selectedDB/.$tbname

		fi

		while [ $colIndex -le $colNum ]; do
			read -p "# Enter name of $colIndex column : > " colName
			if [ $? != 0 ]; then
				breakChanges
				break 2
			fi
			colNameArr+=(:)
			colNameArr+=($colName)
			colNameArr2+=($colName)
			while true; do
				read -p "# Data Type of $colIndex column : 1- string 2- number > " dataTypeNum
				if [ $? != 0 ]; then
					breakChanges
					break 3
				fi

				if [ $dataTypeNum = 1 ]; then

					dataTypeArr+=(:)
					dataTypeArr+=($dataTypeNum)
					break
				elif [ $dataTypeNum = 2 ]; then

					dataTypeArr+=(:)
					dataTypeArr+=($dataTypeNum)
					break

				else
					echo "# Please Choose Correct Number"
				fi
			done
			let colIndex=$colIndex+1
		done

		if [ $autoPrimaryKey -eq 0 ]; then

			while true; do
				echo "# Please set primary key for $tbname Table "
				echo "# choose column from list"
				while true; do
					index=0
					arIndex=()
					for name in ${colNameArr2[*]}; do
						arIndex+=($(($index + 1)))
						echo "# $(($index + 1)) - $name"
						let index=$index+1
					done

					read -p "# choose Column number from list > "
					if [ $? != 0 ]; then
						breakChanges
						break 3
					fi

					if [[ ! " ${arIndex[*]} " =~ " ${REPLY} " ]]; then
						echo "# choose correct number from the list"
						continue
					fi
					echo primaryKeyCol=${arIndex[$REPLY - 1]} >>./.dbms/$selectedDB/.$tbname
					break
				done
				break
			done
		fi

		if [ $autoPrimaryKey -eq 1 ]; then
			echo ${colNameArr[*]} >>./.dbms/$selectedDB/$tbname
			echo primaryKeyCol=1 >>./.dbms/$selectedDB/.$tbname
			echo ${dataTypeArr[*]} >>./.dbms/$selectedDB/.$tbname
		else
			echo ${colNameArr[*]:1} >>./.dbms/$selectedDB/$tbname
			echo ${dataTypeArr[*]:1} >>./.dbms/$selectedDB/.$tbname
		fi
		clear
		echo "# Table Created Successfuly"
		selectTable $tbname
		break
	done
}

#####################################

function listTables {
	index=0
	tableList=()
	arIndex=()

	tableList+=($(ls ./.dbms/$selectedDB/))

	for name in ${tableList[*]}; do
		arIndex+=($(($index + 1)))
		echo "# $(($index + 1)) - $name"
		let index=$index+1
	done
	while true; do

		if [ ${#tableList[*]} -eq 0 ]; then
			echo "# There's no tables to show go to create tables"
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			break
		fi

		read -p "# choose Table number from list > "
		if [ $? != 0 ]; then
			break
		fi

		if [[ ! " ${arIndex[*]} " =~ " ${REPLY} " ]]; then
			echo "# choose correct number from the list"
			continue
		fi
		clear
		selectTable ${tableList[($REPLY - 1)]}
		break
	done
}
###############################################33
function dropTable {
	while true; do
		tableList=()
		read -p "# Enter Table name > " answer
		if [ $? != 0 ]; then
			break
		fi
		tableList+=($(ls ./.dbms/$selectedDB/))
		if [[ " ${tableList[*]} " =~ " ${answer} " ]]; then
			read -p "# Table name exist do you want to delete it ? y/n > "
			if [ $? != 0 ]; then
				break
			fi

			if [[ $REPLY =~ [yY] ]]; then
				rm ./.dbms/$selectedDB/$answer
				rm ./.dbms/$selectedDB/.$answer
				echo '# Table deleted Back to main menu'
				read -p "# Press enter key to resume ... "
				if [ $? != 0 ]; then
					break
				fi

			elif [[ $REPLY =~ [nN] ]]; then
				echo '# Table not deleted Back to main menu'
				read -p "# Press enter key to resume ... "
				if [ $? != 0 ]; then
					break
				fi

			else
				echo '# Answer is not valid Back to main menu'
				read -p "# Press enter key to resume ... "
				if [ $? != 0 ]; then
					break
				fi
			fi
		else
			echo "# Table name not exist"
			continue
		fi

		break
	done
}
###############################################
function connectTable {
	while true; do
		tableList=()
		read -p "# Enter Table name > "
		if [ $? != 0 ]; then
			break
		fi
		tableList+=($(ls ./.dbms/$selectedDB/))
		if [[ " ${tableList[*]} " =~ " ${REPLY} " ]]; then
			clear
			selectTable $REPLY
			break
		else
			echo "# invalid Table name"
			#read -p "invalid DB name Press enter key to try again ... "
			continue

		fi

		break
	done
}

#######################################
function selectTable {
	selectedTable=$1
	echo "# Table $selectedTable is now selected"

	subTableMenu
}
###########################################
function subTableMenu {

	while true; do
		clear
		subListArr=("Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Table Menu")
		echo "################################################################################"

		echo "# choose one of the blow :"
		subListIndex=0
		while [ $subListIndex -lt ${#subListArr[*]} ]; do
			echo "# $(($subListIndex + 1)) ) ${subListArr[$subListIndex]}"
			let subListIndex=$subListIndex+1
		done
		echo "################################################################################"
		read -p "# > "
		if [ $? != 0 ]; then
			break
		fi
		echo "################################################################################"
		case $REPLY in
		1) #Insert into Table
			insertData
			;;
		2) #Select From Table
			selectFromTable
			;;
		3) #Delete From Table
			deleteFromTable
			;;
		4) #Update Table
			updateTable
			;;
		5)

			break
			;;
		*)
			echo "# wrong choice please try again"
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			;;

		esac

	done

}
#######################################################

function insertData {
	shopt -s extglob

	while true; do
		source ./.dbms/$selectedDB/.$selectedTable 2>/dev/null

		sed -n '1'p ./.dbms/$selectedDB/$selectedTable
		if [ $autoPrimaryKey -eq 1 ]; then
			index=2
			let id=$id+1
			insertArr=(: :)
			insertArr+=($id)
			echo "# id column is set to auto increment"
		else
			index=1
			insertArr=(:)
		fi

		while [ $index -le $colNum ]; do
			firstrow=$(sed -n '1p' ./.dbms/$selectedDB/$selectedTable | cut -d: -f$index)
			read -p "# Enter Value of $firstrow Column > " rowData
			if [ $? != 0 ]; then
				clear
				break 2
			fi
			if [ $index -eq $primaryKeyCol ]; then
				pKeyDataArr=($(cut -d: -f$primaryKeyCol ./.dbms/$selectedDB/$selectedTable))
				if [[ " ${pKeyDataArr[*]:1} " =~ " ${rowData} " ]]; then
					echo "# Primary Key exist please enter unique value"
					continue
				fi
			fi

			if [ $(sed -n '5p' ./.dbms/$selectedDB/.$selectedTable | cut -d: -f$index) -eq 2 ]; then
				if [[ $rowData = +([[:digit:]]) ]]; then
					insertArr+=(:)
					insertArr+=($rowData)
					let index=$index+1
				else
					echo "# only Numbers Allowed in this column"
				fi
			elif [ $(sed -n '5p' ./.dbms/$selectedDB/.$selectedTable | cut -d: -f$index) -eq 1 ]; then
				insertArr+=(:)
				insertArr+=($rowData)
				let index=$index+1

			fi

		done
		#sed -n '5p' ./.dbms/$selectedDB/.$selectedTable
		echo ${insertArr[*]:2}
		echo ${insertArr[*]:2} >>./.dbms/$selectedDB/$selectedTable
		if [ $autoPrimaryKey -eq 1 ]; then
			sed '2 c\id='$id'' ./.dbms/$selectedDB/.$selectedTable >./.dbms/$selectedDB/.tempfile
			mv ./.dbms/$selectedDB/.tempfile ./.dbms/$selectedDB/.$selectedTable

		fi
		read -p "# Press enter key to resume ... "

		if [ $? != 0 ]; then
			clear
			break
		fi
		clear
		break
	done
}

#######################################################

function selectFromTable {

	while true; do
		clear
		let maxlines=$(cat ./.dbms/$selectedDB/$selectedTable | wc -l)
		# echo $maxlines
		if [ $maxlines -le 1 ]; then
			echo "# there's no records in table try insert some records"
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			break
		fi

		selectListArr=("record number" "range of records" "column number" "Range of columns" "show all table" "Table Menu")
		echo "################################################################################"

		echo "# choose one of the blow :"
		selectListIndex=0
		while [ $selectListIndex -lt ${#selectListArr[*]} ]; do
			echo "# $(($selectListIndex + 1)) ) ${selectListArr[$selectListIndex]}"
			let selectListIndex=$selectListIndex+1
		done
		echo "################################################################################"
		read -p "# > "
		if [ $? != 0 ]; then
			break
		fi
		echo "################################################################################"
		case $REPLY in
		1) #recored Number
			recordNumber
			;;
		2) #range of records"
			rangeOfRecords
			;;
		3) #column number
			columnSelect
			;;
		4) #selected column numbers
			rangeOfColumns
			;;
		5) #show all table
			showAllTable
			;;
		6)
			# echo "back to Table Menu2"
			break
			;;
		*)
			echo "# wrong choice please try again"
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi

			;;

		esac

	done

}
####################################################

function recordNumber {
	while true; do

		read -p "# enter record number up to $(($maxlines - 1)) > "
		if [ $? != 0 ]; then
			break
		fi

		if [ $REPLY -lt $maxlines -a ! $REPLY -eq 0 ]; then
			sed -n '1'p ./.dbms/$selectedDB/$selectedTable

			sed -n "$(($REPLY + 1))"p ./.dbms/$selectedDB/$selectedTable
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			break
		else
			echo "# record number out of range try again"
		fi
	done

}
##############################################################

function rangeOfRecords {
	while true; do

		read -p "# enter start record number up to $(($maxlines - 1)) > " startRecord
		if [ $? != 0 ]; then
			break
		fi
		read -p "# enter end record number up to $(($maxlines - 1)) > " endRecord
		if [ $? != 0 ]; then
			break
		fi
		if [ $startRecord -lt $maxlines -a $endRecord -lt $maxlines -a $startRecord -le $endRecord -a ! $startRecord -eq 0 ]; then
			sed -n '1'p ./.dbms/$selectedDB/$selectedTable

			sed -n "$(($startRecord + 1)),$(($endRecord + 1))"p ./.dbms/$selectedDB/$selectedTable
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			break
		else
			echo "# record number out of range try again"
			echo "# or start record is greater than end record"
		fi
	done
}

#########################################################
function columnSelect {
	while true; do
		source ./.dbms/$selectedDB/.$selectedTable 2>/dev/null

		read -p "# enter column number from 1 to $colNum > "
		if [ $? != 0 ]; then
			break
		fi
		if [ $REPLY -le $colNum -a ! $REPLY -eq 0 ]; then
			cut -d: -f$REPLY ./.dbms/$selectedDB/$selectedTable
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			break
		else
			echo "# column number out of range try again"
		fi
	done
}
################################################################

function rangeOfColumns {
	while true; do
		source ./.dbms/$selectedDB/.$selectedTable 2>/dev/null

		read -p "# enter start column number from 1 to $colNum > " startColumn
		if [ $? != 0 ]; then
			break
		fi
		read -p "# enter end column number from 1 to $colNum > " endColumn
		if [ $? != 0 ]; then
			break
		fi
		if [ $startColumn -le $colNum -a $endColumn -le $colNum -a $startColumn -le $endColumn -a ! $startColumn -eq 0 ]; then
			cut -d: -f$startColumn-$endColumn ./.dbms/$selectedDB/$selectedTable
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			break
		else
			echo "# try again columns numbers out of range "
			echo "# or start Column is greater than end Column"
		fi
	done
}

function showAllTable {
	while true; do
		cat ./.dbms/$selectedDB/$selectedTable
		read -p "# Press enter key to resume ... "
		if [ $? != 0 ]; then
			break
		fi
		break
	done
}

function deleteFromTable {
	source ./.dbms/$selectedDB/.$selectedTable 2>/dev/null

	while true; do
		let maxlines=$(cat ./.dbms/$selectedDB/$selectedTable | wc -l)
		# echo $maxlines
		if [ $maxlines -le 1 ]; then
			echo "# there's no records in table try insert some records"
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			break
		fi
		read -p "# Enter primary key value of record you want delete > "
		if [ $? != 0 ]; then
			break
		fi
		pKeyDataArr=($(cut -d: -f$primaryKeyCol ./.dbms/$selectedDB/$selectedTable))
		if [[ ! " ${pKeyDataArr[*]:1} " =~ " ${REPLY} " ]]; then
			echo "# Primary Key value not exist please enter correct value"
			continue
		fi

		elementindex=1
		while [ $elementindex -le ${#pKeyDataArr[*]} ]; do
			if [[ "${pKeyDataArr[$elementindex]}" = "${REPLY}" ]]; then
				#echo "$elementindex"
				break
			fi
			let elementindex=$elementindex+1
		done
		let elementindex=$elementindex+1
		sed -n ''$elementindex''p ./.dbms/$selectedDB/$selectedTable

		read -p "# Are you sure you want to delete this record ? y/n > "
		if [ $? != 0 ]; then
			break
		fi
		if [[ $REPLY =~ [yY] ]]; then
			#del
			sed ''$elementindex''d ./.dbms/$selectedDB/$selectedTable >./.dbms/$selectedDB/.tempfile
			mv ./.dbms/$selectedDB/.tempfile ./.dbms/$selectedDB/$selectedTable
			echo '# record deleted Back to menu'
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi

		elif [[ $REPLY =~ [nN] ]]; then
			echo '# record not deleted Back to menu'
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi

		else
			echo '# Answer is not valid Back to menu'
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
		fi

		break
	done

}

function updateTable {
	source ./.dbms/$selectedDB/.$selectedTable 2>/dev/null

	while true; do
		let maxlines=$(cat ./.dbms/$selectedDB/$selectedTable | wc -l)
		# echo $maxlines
		if [ $maxlines -le 1 ]; then
			echo "# there's no records in table try insert some records"
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
			break
		fi
		read -p "# Enter primary key value of record you want update > "
		if [ $? != 0 ]; then
			break
		fi
		pKeyDataArr=($(cut -d: -f$primaryKeyCol ./.dbms/$selectedDB/$selectedTable))
		if [[ ! " ${pKeyDataArr[*]:1} " =~ " ${REPLY} " ]]; then
			echo "# Primary Key value not exist please enter correct value"
			continue
		fi

		elementindex=1
		while [ $elementindex -le ${#pKeyDataArr[*]} ]; do
			if [[ "${pKeyDataArr[$elementindex]}" = "${REPLY}" ]]; then
				break
			fi
			let elementindex=$elementindex+1
		done
		let elementindex=$elementindex+1
		sed -n '1'p ./.dbms/$selectedDB/$selectedTable
		sed -n ''$elementindex''p ./.dbms/$selectedDB/$selectedTable

		###################################

		read -p "# Are you sure you want to update this record ? y/n > "
		if [ $? != 0 ]; then
			break
		fi
		if [[ $REPLY =~ [yY] ]]; then

			if [ $autoPrimaryKey -eq 1 ]; then
				index=2
				let id=$id+1
				insertArr=(: :)
				insertArr+=($id)
				#echo ${insertArr[*]}
			else
				index=1
				insertArr=(:)
			fi

			while [ $index -le $colNum ]; do
				firstrow=$(sed -n '1p' ./.dbms/$selectedDB/$selectedTable | cut -d: -f$index)
				read -p "# Enter Value of $firstrow Column > " rowData
				if [ $? != 0 ]; then
					break 2
				fi
				if [ $index -eq $primaryKeyCol ]; then
					pKeyDataArr=($(cut -d: -f$primaryKeyCol ./.dbms/$selectedDB/$selectedTable))
					if [[ " ${pKeyDataArr[*]:1} " =~ " ${rowData} " ]]; then
						echo "# Primary Key exist please enter unique value"
						continue
					fi
				fi

				if [ $(sed -n '5p' ./.dbms/$selectedDB/.$selectedTable | cut -d: -f$index) -eq 2 ]; then
					if [[ $rowData = +([[:digit:]]) ]]; then
						insertArr+=(:)
						insertArr+=($rowData)
						let index=$index+1
					else
						echo "# only Numbers Allowed in this column"
					fi
				elif [ $(sed -n '5p' ./.dbms/$selectedDB/.$selectedTable | cut -d: -f$index) -eq 1 ]; then
					insertArr+=(:)
					insertArr+=($rowData)
					let index=$index+1

				fi

			done
			#sed -n '5p' ./.dbms/$selectedDB/.$selectedTable
			sed ''$elementindex''d ./.dbms/$selectedDB/$selectedTable >./.dbms/$selectedDB/.tempfile
			mv ./.dbms/$selectedDB/.tempfile ./.dbms/$selectedDB/$selectedTable
			echo ${insertArr[*]:2}
			echo ${insertArr[*]:2} >>./.dbms/$selectedDB/$selectedTable
			if [ $autoPrimaryKey -eq 1 ]; then
				sed '2 c\id='$id'' ./.dbms/$selectedDB/.$selectedTable >./.dbms/$selectedDB/.tempfile
				mv ./.dbms/$selectedDB/.tempfile ./.dbms/$selectedDB/.$selectedTable

			fi

			echo '# record updated Back to menu'
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi

		elif [[ $REPLY =~ [nN] ]]; then
			echo '# record not updated Back to menu'
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi

		else
			echo '# Answer is not valid Back to menu'
			read -p "# Press enter key to resume ... "
			if [ $? != 0 ]; then
				break
			fi
		fi
		#####################################

		####################

		break
	done
}
main
