#!/bin/bash
#### BEGIN INIT INFO
# Info script e set variabili
  Author="Giuseppe Mangiameli @ IT9ARZ"
# Data di rilascio: 11/04/2016  
  Date="27/09/2016" #Revision
  Version="2.2.4"
  TitleScript="connectx"
# Description: Avvia connessione sicura verso Server via SSH
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
e_txt "Consente di collegarci in SSH ad un server"
e_warning "Inserire Argomento "-i" per installare lo script"
e_warning "Inserire Argomento "-v" per vedere questa info"
e_warning "Inserire Argomento "-r" per rimuovere lo script"
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
echo "                                 _         "
echo "                                | |        "
echo "  ___ ___  _ __  _ __   ___  ___| |___  __ "
echo " / __/ _ \| '_ \| '_ \ / _ \/ __| __\ \/ / "
echo "| (_| (_) | | | | | | |  __/ (__| |_ >  <  "
echo " \___\___/|_| |_|_| |_|\___|\___|\__/_/\_\ "
echo "by $Author"                                        
e_header "Connessioni SSH Server"
e_txt "Scegliere su quale server collegarti."
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
#Avvio Connessione verso Server
ssh $Z_Utente@$Z_Host -p $Z_Porta
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
ssh $A_user@$A_lhost -p $A_ldoor
}

elif [ ${ES:-x} = "b" ];
then
{
ssh $B_user@$B_lhost -p $B_ldoor
}

elif [ ${ES:-x} = "c" ];
then
{
ssh $C_user@$C_lhost -p $C_ldoor
}

elif [ ${ES:-x} = "d" ];
then
{
ssh $D_user@$D_lhost -p $D_ldoor
}
elif [ ${ES:-x} = "e" ];
then
{
ssh $E_user@$E_lhost -p $E_ldoor
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
ssh $A_user@$A_rhost -p $A_door
}

elif [ ${ES:-x} = "b" ];
then
{
ssh $B_user@$B_rhost -p $B_door
}

elif [ ${ES:-x} = "c" ];
then
{
ssh $C_user@$C_rhost -p $C_door
}

elif [ ${ES:-x} = "d" ];
then
{
ssh $D_user@$D_rhost -p $D_door
}

elif [ ${ES:-x} = "e" ];
then
{
ssh $E_user@$E_rhost -p $E_door
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