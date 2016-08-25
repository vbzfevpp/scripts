#!/bin/bash

adb wait-for-device

for apk in "$search_dir" *.apk 
do
  echo "Install $apk now..."
  adb install $apk
done
