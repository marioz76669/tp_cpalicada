#/bin/bash

function menu(){
	clear
	echo "1-Generar Fibonacci"
	echo "2-Genrar un número en forma invertida"
	echo "3-Evaluar palíndromo"
	echo "4-Cantidad de lineas de un archivo"
	echo "5-Muestra 5 números de forma ordenada"
	echo "6-Muestra cuantos archivos de cada tipo tiene un directorio"
	echo "7-Salir"
	echo "---------------------------------------------------------------"

}


function fibonacci(){
	A=0
	B=1
	echo -n "Ingrese un número: "
	read VAR1
	echo "La serie de Fibonacci es: "
	for (( i=0; i<VAR1; i++ ))
	do
		echo -n "$A "
		FIB=$((A + B))
		A=$B
		B=$FIB
	done

	echo
}

function num_invertido(){
	echo -n "Ingrese un número: "
	read VAR1
	if echo "$VAR1"|egrep -q '^\-?[0-9]+$'; then
		echo "$VAR1"|rev
	else
		echo "No es un número"
	fi
}

function palindromo(){
	LEN=0
	I=1
	read -p "Ingrese texto: " STR
	LEN=`echo $STR | wc -m`
	LEN=`expr $LEN - 1`
	if [ ! $LEN -eq 0 ]; then
    	MITAD=`expr $LEN / 2`
    	while [ $I -le $MITAD ]; do
        	C1=`echo $STR|cut -c$I`
        	C2=`echo $STR|cut -c$LEN`
        	if [ $C1 != $C2 ]; then
            	echo "El texto no es capicua"
        	fi
        	I=`expr $I + 1`
        	LEN=`expr $LEN - 1`
    	done
    	echo "El texto es capicua"
	else
    	echo "El texto Ingresado es incorrecto"
	fi
}

function cant_lineas(){
	echo -n "ingrese nombre de archivo: "
	read NOMBRE_ARCH
	if test -f "$NOMBRE_ARCH"; then
		echo `wc -l $NOMBRE_ARCH|awk '{print $1}'`
	else
		echo "Archivo incorrecto"
	fi
	
}

function numeros_ordenados(){
	echo "Ingrese 5 números"
	for (( i=0; i<=4; i++ ))
	do
		read -p "Ingrese valor $((i+1)): " VALOR
		arreglo[$i]=${VALOR}
	done

	ordenado=($(for i in "${arreglo[@]}"; do echo $i; done | sort))
	echo "${ordenado[@]}"
}

function cant_a_tipo(){
	echo -n "Ingrese path directorio: "
	read NOMBRE_DIR
	if [ -d "$NOMBRE_DIR" ]; then
		cd "$NOMBRE_DIR"
		echo "Archivos regulares: " `find . -maxdepth 1 -type f|wc -l`
		echo "Directorios: " `find . -maxdepth 1 -type d|wc -l`
		echo "Synlinks: " `find . -maxdepth 1 -type l|wc -l`
		echo "Pipes: " `find . -maxdepth 1 -type p|wc -l`
		echo "Archivos de caracteres: " `find . -maxdepth 1 -type c|wc -l`
		echo "Archivos de bloque: " `find . -maxdepth 1 -type b|wc -l`
		echo "Sockets: " `find . -maxdepth 1 -type s|wc -l`
	else
		echo "No existe directorio"
	fi
}

function salir(){
	NOMBRE=$1
	echo "Adios $NOMBRE"
	sleep 2
}
 

OP=0

menu
while true; do
	read -p "Seleccione una opción: " OP
	case $OP in
		1) fibonacci;;
		2) num_invertido;;
		3) palindromo;;
		4) cant_lineas;;
		5) numeros_ordenados;;
		6) cant_a_tipo;;
		7) salir `mario`
			break;;
		*) echo "Opción incorrecta";;
	esac
done
exit 0
