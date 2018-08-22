#!/bin/sh

echo "Source Code Analysis Utility 3.0"
echo "(c) 2007-2009 by Marc Ruef"
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

    echo "Starting analysis with the module $1 ..."
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
        grep -H -n -r $pattern *
    done
}

if [ $# -eq 2 ]; then
    case $1 in
	-la|--asp)
            analysis "asp"	;;
	-lc|--ansic)
            analysis "ansic"	;;
	-lj|--java)
            analysis "java"	;;
	-lp|--php)
            analysis "php"	;;
	-lp|--sql)
            analysis "sql"	;;
	*)
	    syntax		;;
    esac
else
    syntax
fi
