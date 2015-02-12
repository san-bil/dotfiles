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


function find_ansible_role_vars(){
    roles_path=$(cat ~/.ansible.cfg | grep roles_path | sed 's/roles_path = //')
    arr=($(echo -e $roles_path | tr ";" "\n"))

    for x in $arr
    do
        if [ -d $x ]; then
            find $x/$1 -type f -exec cat {} \; | grep -oP "{{\s*[^\}]*\s*}}"
        fi 
    done
}

function find_all_latex_figures(){
    find $1 -name *.tex  | xargs cat | grep includegraphics | grep -oP "{[^}]*}"
}


function find_function_calls(){
    grep -RoP "[0-9a-zA-Z|_]+\([^\)]*\)(\.[^\)]*\)+)?" $1
}


function tmux_remote_list(){

    for host in "$@"; do echo "$host"; ssh -o ConnectTimeout=5  "$host" "tmux list-sessions" ; done

}

function get_line(){
    awk "NR == $1 {print; exit}"
}

function print_number_range(){
    python -c "print ' '.join([str(x) for x in range($1,$2)])"
}
