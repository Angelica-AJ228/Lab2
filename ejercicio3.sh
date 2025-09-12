#!/bin/bash

dir="/home/angelica/lab2/Lab2"
log="/home/angelica/lab2/Lab2/historial.log"

touch /home/angelica/lab2/Lab2/historial.log

if [ ! -d "/home/angelica/lab2/Lab2" ]; then
	echo "Error: carpeta no existe" >> /home/angelica/lab2/Lab2/historial.log
	exit 1
fi

echo "Analizando..."
echo "Terminado. Analisis registrado en $dir" > "$log"

inotifywait -m -r create -e modify -e delete "$dir" | tee -a "$log"

