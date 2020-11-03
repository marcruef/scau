#!/bin/bash

echo "Source Code Analysis Utility 3.1"
echo "(c) 2007-2020 by Marc Ruef"
echo

syntax(){
	echo "Syntax of scau: ./scau <language> <files_to_test>"
	echo
	echo "language:"
	echo -e "-lc\t--ansic\t\tANSI C"
	echo -e "-la\t--asp\t\tASP"
	echo -e "-lj\t--java\t\tJava"
	echo -e "-lp\t--php\t\tPHP"
}

analysis(){
    if [ $1 = php ]; then
		search=( \$_GET \$_POST \$_SERVER \$_COOKIE \$_FILE )
    elif [ $1 = ansic ]; then
		search=( gets strcpy scanf printf )
    elif [ $1 = asp ]; then
		search=( Request.QueryString Request.Form Request.ServerVariables Request.Cookies Scripting.FileSystemObject )
    elif [ $1 = java ]; then
		search=( getParameter getResponseBody getCookies File )
    elif [ $1 = sql ]; then
		search=( SELECT UPDATE INSERT DELETE DROP ALTER WHERE )
    else
		echo "Error: Unknown analysis type"
		exit
    fi

    echo -en "Starting analysis with the module $1 ...\n\n"
    echo "Test patterns are:"
	
    c=0
    for pattern in ${search[@]}; do
		let c=$c+1
		echo -en "($c) $pattern\n"
    done    
    
    c=0
    for pattern in ${search[@]}; do
		let c=$c+1
		echo -en "\n[$c] Testing pattern\t'$pattern'\n\n"
        grep -H -n -r "$pattern" "$2"
    done
}

if [ $# -eq 2 ]; then
    case $1 in
	-la|--asp)
        analysis "asp" "$2"		;;
	-lc|--ansic)
        analysis "ansic" "$2"	;;
	-lj|--java)
        analysis "java" "$2"	;;
	-lp|--php)
        analysis "php" "$2"		;;
	-lp|--sql)
        analysis "sql" "$2"		;;
	*)
	    syntax					;;
    esac
else
    syntax
fi
