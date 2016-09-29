#!/bin/bash
#### BEGIN INIT INFO
# Info script e set variabili
  Author="Giuseppe Mangiameli @ IT9ARZ"
# Data di rilascio: 16/09/2016 
  Date="27/09/2016" #Revision
  Version="2.2.4"
  TitleScript="cpserver"
# Description: Copia un file da/verso Server a sistema Locale. Possibile scegliere se LAN o WAN
# Required:	Credenziali presenti in parametri-server.conf
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
su -c "cp $scriptname /usr/bin/$TitleScript" root && e_success "Script Installato, esegui ora il Comando $TitleScript" || e_error "Errore nella fase di Installazione di $TitleScript"
}
fi

if [[ ! -z $vopt ]]
then
{
e_header_1 "$TitleScript versione: $Version   Revision: $Date"
e_txt "Designed by $Author"
e_txt "copia files da server e verso server"
e_warning "Inserire Argomento "-i" per installare lo script"
e_warning "Inserire Argomento "-v" per vedere questa info"
e_warning "Inserire Argomento "-r" per rimuovere lo script"
}
fi

if [[ ! -z $ropt ]]
then
{
su -c "rm /usr/bin/$TitleScript" root && e_success "$TitleScript rimosso con successo" || e_error "Errore nella rimozione di $TitleScript"
}
fi

if [[ $# -eq 0 ]]
then
{

#domando il tipo di server da interrogare                                          
echo "   ___ _ __  ___  ___ _ ____   _____ _ __  "
echo "  / __| '_ \/ __|/ _ \ '__\ \ / / _ \ '__| "
echo " | (__| |_) \__ \  __/ |   \ V /  __/ |    "
echo "  \___| .__/|___/\___|_|    \_/ \___|_|    "
echo "      | |                                  "
echo "      |_|                                  "
echo "by $Author"      
e_header "trasferimenti files SSH su server"
e_txt "Scegliere su quale server collegarti per iniziare il trasferimento di dati"
e_txt "per annullare il comando, lasciare vuoto e premere invio"
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
e_txt "scegli se copiare file da:"
e_warning "Locale > Remoto <r>"
e_warning "Remoto > Locale <l>"
echo -n "scegli: "

#Recupero la risposta
read Z_Risposta

if [ ${Z_Risposta:-u} = "l" ];
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
echo -n "Inserisci Posizione Locale: "
#Recupero la risposta
read Z_POS_LOCALE
echo -n "Inserisci Posizione Remota: "
#Recupero la risposta
read Z_POS_REMOTA
#Avvio Connessione verso Server
scp -P $Z_Porta -rpC $Z_Utente@$Z_Host:$Z_POS_REMOTA $Z_POS_LOCALE
exit
}
fi

if [ ${Z_Risposta:-u} = "r" ];
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
echo -n "Inserisci Posizione Locale: "
#Recupero la risposta
read Z_POS_LOCALE
echo -n "Inserisci Posizione Remota: "
#Recupero la risposta
read Z_POS_REMOTA
#Avvio Connessione verso Server
scp -P $Z_Porta -rpC $Z_POS_LOCALE $Z_Utente@$Z_Host:$Z_POS_REMOTA
exit
}
fi

#Comando annullato
if [ ${Z_Risposta:-u} = "u" ];
then
{
	e_error "comando annullato"
	exit
}
else
{
   e_error "Comando errato  -  $USER devi scrivere l oppure r"
   exit
}
fi
}


elif [ ${ES:-y} = "y" ];
then
{
e_error "comando annullato"
exit
}
else
{
   e_error "Comando errato  -  $USER devi scegliere i server in elenco"
   exit
}
fi

#domando il tipo di connessione da stabilire
e_txt "Scegli il tipo di connessione per connetterti al Server: <"$SERVER">"
e_txt "per annullare il comando, lasciare vuoto e premere invio"
e_warning "LAN <l>"
e_warning "WAN <w>"
echo -n "scegli: "

#Recupero la risposta
read CONNECT

#Connessione tipo LAN
if [ ${CONNECT:-x} = "l" ];
then
{
#domando il tipo di connessione da stabilire
e_success "inizio connessione SSH verso <"$SERVER"> su rete LAN"
e_txt "per annullare il comando, lasciare vuoto e premere invio"
e_txt "scegli se copiare file da:"
e_warning "Locale > Remoto <r>"
e_warning "Remoto > Locale <l>"
echo -n "scegli: "

#Recupero la risposta
read RISPOSTA

#converto la risposta digitata in un indirizzo host corretto
#":-"x viene usata come risposta di default, in questo caso sarebbe "x"
if [ ${RISPOSTA:-x} = "l" ];
then
{
#domando la posizione remota del file
e_txt "Copia File da Server <"$SERVER"> > verso questo Sistema"
echo -n "Digita la posizione remota del file: "

#Recupero la risposta
read POS_REMOTA

#domando la posizione locale dove si intendere copiare il file
echo -n "Digita la posizione locale: "

#Recupero la risposta
read POS_LOCALE

if [ ${ES:-x} = "a" ];
then
{
scp -P $A_ldoor -rpC $A_user@$A_lhost:$POS_REMOTA $POS_LOCALE
}

elif [ ${ES:-x} = "b" ];
then
{
scp -P $B_ldoor -rpC $B_user@$B_lhost:$POS_REMOTA $POS_LOCALE
}

elif [ ${ES:-x} = "c" ];
then
{
scp -P $C_ldoor -rpC $C_user@$C_lhost:$POS_REMOTA $POS_LOCALE
}

elif [ ${ES:-x} = "d" ];
then
{
scp -P $D_ldoor -rpC $D_user@$D_lhost:$POS_REMOTA $POS_LOCALE
}

elif [ ${ES:-x} = "e" ];
then
{
scp -P $E_ldoor -rpC $E_user@$E_lhost:$POS_REMOTA $POS_LOCALE
}
fi
}
fi

if [ ${RISPOSTA:-x} = "r" ];
then
{
#domando la posizione remota del file
e_txt "Copia File da questo Sistema verso > Server <"$SERVER">"
echo -n "Digita la posizione locale del file da copiare: "

#Recupero la risposta
read POS_LOCALE

#domando la posizione locale dove si intendere copiare il file
echo -n "Digita la posizione remota dove salvare il file: "

#Recupero la risposta
read POS_REMOTA

if [ ${ES:-x} = "a" ];
then
{
scp -P $A_ldoor -rpC $POS_LOCALE $A_user@$A_lhost:$POS_REMOTA
}

elif [ ${ES:-x} = "b" ];
then
{
scp -P $B_ldoor -rpC $POS_LOCALE $B_user@$B_lhost:$POS_REMOTA
}

elif [ ${ES:-x} = "c" ];
then
{
scp -P $C_ldoor -rpC $POS_LOCALE $C_user@$C_lhost:$POS_REMOTA
}

elif [ ${ES:-x} = "d" ];
then
{
scp -P $D_ldoor -rpC $POS_LOCALE $D_user@$D_lhost:$POS_REMOTA
}

elif [ ${ES:-x} = "e" ];
then
{
scp -P $E_ldoor -rpC $POS_LOCALE $E_user@$E_lhost:$POS_REMOTA
}
fi
}
fi

#Comando annullato
if [ ${RISPOSTA:-x} = "x" ];
then
{
	e_error "comando annullato"
	exit
}
else
{
   e_error "Comando errato  -  $USER devi scrivere l oppure r"
   exit
}
fi

}
fi

#Connessione tipo WAN
if [ ${CONNECT:-x} = "w" ];
then
{
#domando il tipo di connessione da stabilire
e_success "inizio connessione SSH verso <"$SERVER"> su rete WAN"
e_txt "per annullare il comando, lasciare vuoto e premere invio"
e_txt "scegli se copiare file da:"
e_warning "Locale > Remoto <r>"
e_warning "Remoto > Locale <l>"
echo -n "scegli: "

#Recupero la risposta
read RISPOSTA

#converto la risposta digitata in un indirizzo host corretto
#":-"x viene usata come risposta di default, in questo caso sarebbe "x"
if [ ${RISPOSTA:-x} = "l" ];
then
{
#domando la posizione remota del file
e_txt "Copia File da Server <"$SERVER"> > verso questo Sistema"
echo -n "Digita la posizione remota del file: "

#Recupero la risposta
read POS_REMOTA

#domando la posizione locale dove si intendere copiare il file
echo -n "Digita la posizione locale: "

#Recupero la risposta
read POS_LOCALE

if [ ${ES:-x} = "a" ];
then
{
scp -P $A_door -rpC $A_user@$A_rhost:$POS_REMOTA $POS_LOCALE
}

elif [ ${ES:-x} = "b" ];
then
{
scp -P $B_door -rpC $B_user@$B_rhost:$POS_REMOTA $POS_LOCALE
}

elif [ ${ES:-x} = "c" ];
then
{
scp -P $C_door -rpC $C_user@$C_rhost:$POS_REMOTA $POS_LOCALE
}

elif [ ${ES:-x} = "d" ];
then
{
scp -P $D_door -rpC $D_user@$D_rhost:$POS_REMOTA $POS_LOCALE
}

elif [ ${ES:-x} = "e" ];
then
{
scp -P $E_door -rpC $E_user@$E_rhost:$POS_REMOTA $POS_LOCALE
}
fi
}
fi

if [ ${RISPOSTA:-x} = "r" ];
then
{
#domando la posizione remota del file
e_txt "Copia File da questo Sistema verso > Server <"$SERVER">"
echo -n "Digita la posizione locale del file: "

#Recupero la risposta
read POS_LOCALE

#domando la posizione locale dove si intendere copiare il file
echo -n "Digita la posizione remota dove salvare il file: "

#Recupero la risposta
read POS_REMOTA

if [ ${ES:-x} = "a" ];
then
{
scp -P $A_door -rpC $POS_LOCALE $A_user@$A_rhost:$POS_REMOTA
}

elif [ ${ES:-x} = "b" ];
then
{
scp -P $B_door -rpC $POS_LOCALE $B_user@$B_rhost:$POS_REMOTA
}

elif [ ${ES:-x} = "c" ];
then
{
scp -P $C_door -rpC $POS_LOCALE $C_user@$C_rhost:$POS_REMOTA
}

elif [ ${ES:-x} = "d" ];
then
{
scp -P $D_door -rpC $POS_LOCALE $D_user@$D_rhost:$POS_REMOTA
}

elif [ ${ES:-x} = "e" ];
then
{
scp -P $E_door -rpC $POS_LOCALE $E_user@$E_rhost:$POS_REMOTA
}
fi
}
fi

#Comando annullato
if [ ${RISPOSTA:-x} = "x" ];
then
{
	e_error "comando annullato"
	exit
}
else
{
   e_error "Comando errato  -  $USER devi scrivere l oppure r"
   exit
}
fi

}
fi

#Comando annullato
if [ ${CONNECT:-x} = "x" ];
then
{
	e_error "comando annullato"
	exit
}
else
{
   e_error "Comando errato  -  $USER devi scrivere l oppure w"
   exit
}
fi
}
fi
shift $(($OPTIND -1))
