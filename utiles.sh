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

function cambia_contra(){
    echo $1:$2 | chpasswd
}

function descargar_logosvf(){
if [ ! -f /usr/share/backgrounds/Logo.jpg ];
then
    sudo wget https://www.dropbox.com/s/8dca3e83fl7xq6b/logo3.png -O /usr/share/backgrounds/logo3.png
    sudo chmod 755 /usr/share/backgrounds/logo3.png
    sudo wget https://www.dropbox.com/s/p2bzjph16bt06b7/Logo.jpg -O /usr/share/backgrounds/Logo.jpg
    sudo chmod 755 /usr/share/backgrounds/Logo.jpg
fi
}

function crea_autoejecutablevf(){
if [ ! -f /etc/xdg/autostart/$1.desktop ];
then
    echo "Escribiendo el archivo: $1.desktop"
    echo "[Desktop Entry]" >> /etc/xdg/autostart/$1.desktop
    echo "Type=Application" >> /etc/xdg/autostart/$1.desktop
    echo "Exec=$2" >> /etc/xdg/autostart/$1.desktop
    echo "X-MATE-Autostart-enabled=true" >> /etc/xdg/autostart/$1.desktop
    echo "Name[es_AR]=$1" >> /etc/xdg/autostart/$1.desktop
    echo "Name=$1" >> /etc/xdg/autostart/$1.desktop
	echo "Comment[es_AR]=$1" >> /etc/xdg/autostart/$1.desktop
	echo "Comment=$1" >> /etc/xdg/autostart/$1.desktop
    sudo chown root /etc/xdg/autostart/$1.desktop
    sudo chmod 644 /etc/xdg/autostart/$1.desktop
fi
}

function protector_pantallavf(){
if [ ! -f /usr/share/pixmaps/UNAHUR-logo.svg ];
then
    sudo wget https://www.dropbox.com/s/x2cnfldgj8jovu3/UNAHUR-logo.svg -O /usr/share/pixmaps/UNAHUR-logo.svg
    sudo wget https://www.dropbox.com/s/kvqpark2i5f06tm/footlogo-floaters.desktop -O /usr/share/applications/screensavers/footlogo-floaters.desktop
fi
}

function montar_fstabvf(){
if [ ! -f /media/$3 ];
then
    if [ -f /dev/$1 ];
    then
        sudo mkdir /media/$3
        sudo chmod 777 /media/$3
        sudo echo "" >> /etc/fstab
        sudo echo "# Montar partición $3.  santiago.maydana@unahur.edu.ar" >> /etc/fstab
        sudo echo "/dev/$1 /media/$3 $2 users,permissions,auto 0 0" >> /etc/fstab
    fi
fi
}

function elusuario(){
	sudo userdel -r $1
}
