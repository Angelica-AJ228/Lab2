#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Uso: $0 comando"
	exit 1
fi

comando=$@
log="consumo.log"

rm -f $log
echo "Tiempo,CPU(%),Memoria(%)" > $log

$comando &
pid=$!

echo "Procesando..."

while ps -p $pid; do
	tiempo=$(date +"%H:%M:%S")
	memoria=$(ps -p $pid -o %cpu,%mem --no-headers)
	echo "$tiempo,$memoria" >> $log
	sleep 6
done

gnuplot <<-EOF

	set datafile separator ","
	set terminal png size 800,600
	set output "$HOME/consumo.png"
	set title "Memoria y consumo CPU"
	set xlabel "Tiempo"
	set ylabel "Uso, %"
	set key outside
	plot "$log" using 0:2 with lines title "CPU", \
	     "$log" using 0:3 with lines title "Memoria"

EOF

echo "Imagen descargada en $HOME/consumo.png"



