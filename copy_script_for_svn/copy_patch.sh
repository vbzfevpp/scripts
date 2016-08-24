#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ $SOURCE == /* ]]; then
    echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'"
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')"
    SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done
echo "SOURCE is '$SOURCE'"
RDIR="$( dirname "$SOURCE" )"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
if [ "$DIR" != "$RDIR" ]; then
  echo "DIR '$RDIR' resolves to '$DIR'"
fi
echo "DIR is '$DIR'"

filename='path.log'
exec < $filename

while read line
do
    #echo $line # 一行一行印出內容
    DEST="./patch/$( dirname "$line" )/"
    #echo 'a' $DIR/$line # 印出 "a $line" 此行的內容, 可另外作特別處理.
    SOUR="$DIR/$line"

    if [ -d "$DEST" ]; then
        # 目錄 /path/to/dir 存在
        echo "Copy $SOUR to $DEST."
        cp $SOUR $DEST
    else
        # 目錄 /path/to/dir 不存在
        echo "Directory $DEST creation."
        echo "Copy $SOUR to $DEST."		
		mkdir -p $DEST
        cp $SOUR $DEST
    fi
done


