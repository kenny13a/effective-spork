#!/bin/bash


##Lista de funciones
# function crea_enlace "USUARIO" "PROGRAMA"
# function crea_usuario "USUARIO" "CONTRASEÑA"
# function prueba(){
# function existeuservf(){ Esta funcion chequea si el usuario existe y si no, lo crea
# function existeuser solo dice si existe o no

function crea_enlace(){
    echo "Credor de enlaces"
    if [ -z "$1" ] && [ -z "$2" ]
        then
            echo "Incorrecto, intente:"
            echo "  sudo crea_enlace "usuario" "programa""
        else
            echo "usted eligió crear el enlace a $2"
  	        if [ ! -d /home/$1/Escritorio/ ];
                then
                    sudo mkdir /home/$1/Escritorio
                    sudo chown $1 /home/$1/Escritorio
                    sudo chgrp $1 /home/$1/Escritorio
            fi 
            sudo cp "$2.desktop" /home/$1/Escritorio
            sudo chmod 755 /home/$1/Escritorio/$2.desktop
            echo "Acceso directo de $2 copiado al escritorio de $1"
    fi
}

function crea_usuario(){
    echo "Creador de usuarios"
    if [ -z "$1" ] && [ -z "$2" ]
        then
            echo "Incorrecto, intente:"
            echo "  sudo crea_usuario "usuario" "contraseña""
        else
            echo "Hello $1"
    	    echo "Agregando usuario $1"
    	    sudo useradd -m -d /home/$1 $1 -s /bin/bash
    	    echo "usuario $1 y contraseña $2"
    	    echo $1:$2 | chpasswd
    	    sudo adduser $1 materias
            echo "+++Arreglando la seguridad de la carpeta compartida del usuario $1"
            sudo chmod -v 770 /home/$1
            if [ ! -d /home/$1/Escritorio/ ];
                then
                    sudo mkdir /home/$1/Escritorio
                    sudo chown $1 /home/$1/Escritorio
                    sudo chgrp $1 /home/$1/Escritorio
            fi
            sudo chmod -v 555 /home/$1/Escritorio
            echo "Eliminando: ubuntu-mate-welcome-autostart.desktop"
            sudo rm /etc/xdg/autostart/ubuntu-mate-welcome-autostart.desktop
            echo "Eliminando: update-notifier.desktop"
            sudo rm /etc/xdg/autostart/update-notifier.desktop
    fi
}

function prueba(){
    echo "funcionado"
}

function existeuservf(){
id -u "$1" >/dev/null 2>&1
if [ $? = 0 ]
    then
        echo "$1 OK"
#        pkexec bash /opt/conejo-blanco/effective-spork/Materias/$1
    else
        echo "crear usuario"
        sudo /opt/conejo-blanco/effective-spork/Sistema/usuarios/$1
fi
}

function existeuser(){
 if id -u "$1" >/dev/null 2>&1; then
	echo "├ usuario $1:  $(tput setaf 2)Existe$(tput sgr 0)"
else
    echo "├ usuario $1: $(tput setaf 1)NO existe$(tput sgr 0)"
fi
}

function cheq_mat_progs(){
    pkexec bash /opt/conejo-blanco/effective-sport/Materias/Programas/$1
}
