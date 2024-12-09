#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Error: Script requires <path_to_file> <content>"
  exit 1
fi

filename=$1
folderpath=$(dirname "$filename" 2>&1)

mkdir -p $folderpath

if [ -e $1 ]; then
  echo "File $1 already exists!"
  exit 1
else
  echo $2 >> $1
fi
