#!/bin/bash

# if file does not exist timeout $TIMEOUT seconds 3 times
TRY=3
while [ ! -f opt/data.txt ] && [ ${TRY} -gt 0 ]; do
    sleep ${TIMEOUT};
    TRY=$((TRY-1));
done

# if file does not exist exit
if [ ! -f opt/data.txt ]; then
    echo "File not found";
    exit 1;
fi

while true; do cat opt/data.txt; sleep ${TIMEOUT}; done