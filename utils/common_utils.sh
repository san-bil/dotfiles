#!/bin/bash

function count_csv_cols(){
	head $1 |  awk -F',' ' { print NF }' | head -1
}

function fill_filename_spaces(){
	find $1 -depth -name "* *" -execdir rename 's/ /_/g' "{}" \;
}

function find_dup_filenames(){

	root_dirname=$1
	tempfile=/tmp/file_dup_finder_tmp_file
	find $root_dirname -type f  > $tempfile
	cat $tempfile | sed 's_.*/__' | sort |  uniq -d| 
	while read fileName
	do
	 grep "$fileName" $tempfile
	done
	rm -f $tempfile
}

function gsrec() {
    find $1 -name .git -type d -exec sh -c '(cd $(dirname {}) && echo "$(pwd):\n" && git status && echo "\n--------------------------------------------------\n")' ';'
}


function gsrecs() {
    find $1 -name .git -type d -exec sh -c '(cd $(dirname {}) && echo "$(pwd):\n" && git status -s && echo "\n--------------------------------------------------\n")' ';'
}

function glrec() {
    find $1 -name .git -type d -exec sh -c '(echo $(dirname {})  && echo "\n--------------------------------------------------\n")' ';'
}

function generate_hash(){
    python -c "import hashlib;print hashlib.sha512(\"$1\").hexdigest()[0:$2]"
}

function mfiles(){
	if [ "$1" == "hide" ]; then
	    find $1 -type f -exec mv {} {}~ \;
	fi

	if [ "$1" == "show" ]; then
	    for file in $(find $2 -type f)
	    do 
	          mv $file `echo $file | sed s/~//g`
	    done
	fi
}

function ff_sort(){
    find $1 -maxdepth 1 -type f -printf "%T@ %Tc %p\n" | sort -n
}

function ff_sort_s(){
    find $1 -maxdepth 1 -type f -printf "%T@ %Tc %p\n" | sort -n | grep -oP '\ [^ ]*\/.+' | cut -c 2-
}


