#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
	echo "Error: script solo ejecutable por root."
	exit 1
fi

if [ $# -ne 3 ]; then
	echo "Uso: $0 usuario grupo ruta_archivo"
	exit 1
fi

usu=$1
grp=$2
arch=$3

if [ ! -e "$arch" ]; then
	echo "Error: El archivo $arch no existe."
	exit 1
fi

if groups | grep -w "$grp"; then
	echo "El grupo $grp ya existe."
else
	addgroup "$grp"
	echo "Grupo $grp creado."
fi

if id "$usu"; then
	echo "El usuario $usu ya existe. Se agregará al grupo $grp."
	adduser "$usu" "$grp"
else
	adduser --ingroup "$grp" "$usu"
	echo "Usuario $usu creado en el grupo $grp."
fi

chown "$usu:$grp" "$arch"
chmod 740 "$arch"

echo "El archivo $arch pertenece a $usu y al grupo $grp. El usuario tiene todos los permisos, el grupo solo de lectura. Importante: los demas usuarios no tienen ningun permiso."

