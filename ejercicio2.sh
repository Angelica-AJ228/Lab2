#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Uso: $0 comando"
	exit 1
fi

comando=$@
log="monitor.log"

rm -f $log
echo "Tiempo,CPU(%),Memoria(%)" > $log

$comando &
pid=$!

echo "Procesando..."

while ps -p $pid; do
	tiempo=$(date +"%H:%M:%S")
	memoria=$(ps -p $pid -o %cpu,%mem --no-headers)
	echo "$tiempo,$memoria" >> $log
	sleep 2
done



