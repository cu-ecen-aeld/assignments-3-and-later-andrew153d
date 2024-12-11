#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Error: Script requires <path_to_directory> <search_string>"
  exit 1
fi

filesdir=$1
searchstr=$2

if [ ! -d "$filesdir" ]; then
  echo "Error: $filesdir is not a valid directory."
  exit 1
fi

totalfiles=0
linesmatch=0

function SearchForString() {
        if [ -d $1 ]
        then
                for subfile in $1/*
                do
                        SearchForString $subfile
                done
        elif [ -f $1 ]
        then
                match=$(grep -c $searchstr $1)
		if [ $match -gt 0 ]
		then
			((totalfiles=totalfiles+1))
		fi
                (( linesmatch=linesmatch+match))
        fi
}

SearchForString $filesdir

printf "The number of files are %d and the number of matching lines are %d\n" ${totalfiles} ${linesmatch}
