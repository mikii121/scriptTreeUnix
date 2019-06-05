#!/bin/bash
#*********************************************************************************
# Nombre del shell script: tree.sh
# Descripcion: Devuelve un arbol con todos los archivos del directorio y subdirectorios
# Parametros: 
# Autor: Miguel Andrés (mac_121@hotmail.com)

#*********************************************************************************

#funciones
function comprobarDirectorio 
{
	ELEMENTOS_RUTA=$( ls -C1 $1 )
	
	for i in $ELEMENTOS_RUTA
	do
		NUMERO_TABULACIONES=$(echo $1/$i | tr -cd / | wc -c)
		ECHO_TABS=""
		while [  $NUMERO_TABULACIONES -gt 1 ]; do
             ECHO_TABS="${ECHO_TABS}"$'\t'""
             let NUMERO_TABULACIONES=NUMERO_TABULACIONES-1 
         done
			
		if [ -d $1/$i ];
		then			
			
			echo -e "${ECHO_TABS} \e[0;31m$i (Directorio)\e[0m "
			
			comprobarDirectorio $1/$i 
		else	
			if [ -f $1/$i ];
			then
				if [ -x $1/$i ];
				then
					echo -e "${ECHO_TABS} \e[1;32m$i\e[0m"
				else	
					echo "${ECHO_TABS} $i"
				fi
				
			fi
		fi
		
	done
}

function ayuda {
	echo ""
	echo "Programa que permite ver un arbol del directorio."
	echo ""
	echo "Usage:"
	echo $'\t'"./tree.sh [PARAMS]"
	echo ""
	echo "Options:"
	echo $'\t'"[-h|--help] "$'\t'""$'\t'" Muestra el siguiente mensaje de ayuda."
	echo $'\t'"[-d|--dir directorio] "$'\t'" Directorio del cual queremos generar el arbol."
	echo ""
}


# Mientras el número de argumentos NO SEA 0
while [ $# -ne 0 ]
do
    case "$1" in
    -h|--help)
        ayuda	
		exit 2
        ;;
	-d|--dir)
        DIRECTORIO=$2	
		shift
        ;;
    *)
        echo "tree: illegal option -- $1."
		ayuda
        exit 2
        ;;
    esac
    shift
done

#condiciones
if [ -z "$DIRECTORIO" ]
then
    RUTA_ACTUAL=.
else
	RUTA_ACTUAL=$DIRECTORIO
fi

#ejecucion del programa
comprobarDirectorio $RUTA_ACTUAL

