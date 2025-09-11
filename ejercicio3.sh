#!/bin/bash

dir="/home/angelica/lab2"
log="/home/angelica/lab2/Lab2/historial.log"

echo "Analizando..."
echo "Terminado. Analisis registrado en $dir" > "$log"

inotifywait -m -r create -e modify -e delete "$dir" | tee -a "$log"

