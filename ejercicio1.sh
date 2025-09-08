#!/bin/bash

if [ "id -u" -ne 0 ]; then
	echo "Error: se debe utilizar root para la ejecucion del programa"
	exit 1
fi

if [ $# -ne 3 ]; then
	echo "Uso: $0 usuario grupo ruta"
	exit 1
fi

usu=$1
grp=$2
arch=$3

if [ ! e "$arch" ]; then
	echo "Error: el archivo no existe"
	exit 1
fi



