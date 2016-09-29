#!/bin/bash
#### BEGIN INIT INFO
# Info script e set variabili
  Author="Giuseppe Mangiameli @ IT9ARZ"
# Data di rilascio: 20/09/2016 
  Date="27/09/2016" #Revision
  Version="1.0.5"
  TitleScript="mountx"
# Description: Connetti e monta unità di rete
# Required: Credenziali presenti in parametri-server.conf
#           richiesto script_util.sh
#### END INIT INFO

#carico i parametri
source ~/cmd/parametri-server.conf
source ~/cmd/script_util.sh

# clear the screen
clear

# Define Variable acmreset
acmreset=$(tput sgr0)

while getopts ivr name
do
        case $name in
          i)iopt=1;;
          v)vopt=1;;
          r)ropt=1;;
          *)echo "Argomento errato";;
        esac
done

if [[ ! -z $iopt ]]
then
{
wd=$(pwd)
basename "$(test -L "$0" && readlink "$0" || echo "$0")" > /tmp/scriptname
scriptname=$(echo -e -n $wd/ && cat /tmp/scriptname)
echo "Installazione in corso di $TitleScript"
su -c "cp $scriptname /usr/bin/$TitleScript" root && e_success "Script Installato! Esegui ora il Comando $TitleScript" || e_error "!! Errore nella fase di Installazione di $TitleScript"
}
fi

if [[ ! -z $vopt ]]
then
{
e_header_1 "$TitleScript versione: $Version   Revision: $Date"
e_txt "Designed by $Author"
e_txt "Monta Unità di rete sul sistema"
e_warning "Inserire Argomento "-i" per installare lo script"
e_warning "Inserire Argomento "-v" per vedere questa info"
e_warning "Inserire Argomento "-r" per rimuovere lo script"
e_warning "Si richiede l'installazione di <sshfs> - # apt-get install sshfs fuse "
}
fi

if [[ ! -z $ropt ]]
then
{
su -c "rm /usr/bin/$TitleScript" root && e_success "$TitleScript rimosso con successo!" || e_error "!! Errore nella rimozione di $TitleScript"
}
fi

if [[ $# -eq 0 ]]
then
{
#domando il tipo di server da interrogare
echo -e "                              _         "
echo -e "                             | |        "
echo -e "  _ __ ___   ___  _   _ _ __ | |___  __ "
echo -e " | '_ ' _ \ / _ \| | | | '_ \| __\ \/ / "
echo -e " | | | | | | (_) | |_| | | | | |_ >  <  "
echo -e " |_| |_| |_|\___/ \__,_|_| |_|\__/_/\_\ "
echo "by $Author"                                         
e_header "montaggio unità di rete"
e_txt "Scegli il server con l'unità da montare."
e_txt "per annullare il comando, lasciare vuoto e premere invio."
e_warning "z. Inserisci Server"
e_warning "$es1"
e_warning "$es2"
e_warning "$es3"
e_warning "$es4"
e_warning "$es5"
echo -n "Scegli: "

#Recupero la risposta
read ES

if [ ${ES:-y} = "a" ];
then
{
SERVER=$a
}
elif [ ${ES:-y} = "b" ];
then
{
SERVER=$b
}
elif [ ${ES:-y} = "c" ];
then
{
SERVER=$c
}
elif [ ${ES:-y} = "d" ];
then
{
SERVER=$d
}
elif [ ${ES:-y} = "e" ];
then
{
SERVER=$e
}
elif [ ${ES:-y} = "z" ];
then
{
echo -n "Inserisci Nome Utente: "
#Recupero la risposta
read Z_Utente
#echo -n "Inserisci Password: "
#Recupero la risposta
#read Z_Passwd
echo -n "Inserisci Host: "
#Recupero la risposta
read Z_Host
echo -n "Inserisci Porta: "
#Recupero la risposta
read Z_Porta
echo -n "Inserisci Posizione di montaggio: "
#Recupero la risposta
read Z_pos
echo -n "Inserisci Posizione Remota: "
#Recupero la risposta
read Z_root
#Avvio Connessione verso Server
sshfs $Z_Utente@$Z_Host:$Z_root $Z_pos -p $Z_Porta
exit
}
elif [ ${ES:-y} = "y" ];
then
{
e_error "comando annullato"
exit
}
else
{
   e_error "Comando errato  -  $USER devi scegliere i server in elenco."
   exit
}
fi

#domando il tipo di connessione da stabilire
e_txt "Scegli il tipo di connessione per connetterti al Server: <"$SERVER">."
e_txt "per annullare il comando, lasciare vuoto e premere invio."
e_warning "LAN <l>"
e_warning "WAN <w>"
echo -n "scegli: "

#Recupero la risposta
read CONNECT

#Connessione tipo LAN
if [ ${CONNECT:-x} = "l" ];
then
{
#Informo il tipo di connessione scelta
e_success "inizio connessione SSH verso <"$SERVER"> su rete LAN."

if [ ${ES:-x} = "a" ];
then
{
sshfs $A_user@$A_lhost:$A_root $A_pos -p $A_ldoor
}

elif [ ${ES:-x} = "b" ];
then
{
sshfs $B_user@$B_lhost:$B_root $B_pos -p $B_ldoor
}

elif [ ${ES:-x} = "c" ];
then
{
sshfs $C_user@$C_lhost:$C_root $C_pos -p $C_ldoor
}

elif [ ${ES:-x} = "d" ];
then
{
sshfs $D_user@$D_lhost:$D_root $D_pos -p $D_ldoor
}

elif [ ${ES:-x} = "e" ];
then
{
sshfs $E_user@$E_lhost:$E_root $E_pos -p $E_ldoor
}
fi
}
fi


#Connessione tipo WAN
if [ ${CONNECT:-x} = "w" ];
then
{
#Informo il tipo di connessione scelta
e_success "inizio connessione SSH verso <"$SERVER"> su rete WAN"

if [ ${ES:-x} = "a" ];
then
{
sshfs $A_user@$A_rhost:$A_root $A_pos -p $A_door
}

elif [ ${ES:-x} = "b" ];
then
{
sshfs $B_user@$B_rhost:$B_root $B_pos -p $B_door
}

elif [ ${ES:-x} = "c" ];
then
{
sshfs $C_user@$C_rhost:$C_root $C_pos -p $C_door
}

elif [ ${ES:-x} = "d" ];
then
{
sshfs $D_user@$D_rhost:$D_root $D_pos -p $D_door
}

elif [ ${ES:-x} = "e" ];
then
{
sshfs $E_user@$E_rhost:$E_root $E_pos -p $E_door
}
fi
}
fi

#Comando annullato
if [ ${CONNECT:-x} = "x" ];
then
	e_error "comando annullato"
fi

}
fi

shift $(($OPTIND -1))