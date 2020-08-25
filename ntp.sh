#! /bin/bash
echo "################################################"
echo "#                                              #"
echo "#        Por: Ronualdo JSA - PU4RON            #"
echo "#                                              #"
echo "#                Janauba/MG                    #"
echo "#                                              #"
echo "################################################"
echo ""
echo ""


echo -e "\033[01;37m* \033[04;32mOs ponteiros apontam para o infinito!\033[00;37m"
echo ""
echo ""
sleep 1

read -p "* Continuar e adicionar servidores NTP-BR? (S/N) " -n 1 -r

case "$REPLY" in 

  s|S ) echo "" ;;
  n|N ) exit 0 ;;
    * ) exit 0 ;;
     
esac

daystamp(){
        date +"%d.%m.%y"
}
timestamp(){
        date +"%T"
}

arq="/etc/ntp.conf"
loc="/etc/timezone"

sudo mount -o remount,rw /

echo ""
echo ""

sudo pistar-update && sudo apt-get install ntp ntpdate -y

sudo mount -o remount,rw /

if [ -f "$arq" ]

then
 
    echo ""
    echo ""
    echo "* Verificando arquivo NTP..."
    echo "" 
    sleep 2
    echo "* Arquivo NTP existente."
    echo ""
    sleep 2
    echo "* Backup do arquivo."
    sudo cp  -p "$arq"    "$arq"-$(daystamp)_$(timestamp)
    sudo cp  -p "$loc"    "$loc"-$(daystamp)_$(timestamp)
    echo ""
    sleep 2
    echo "* Estruturando arquivo..."
    sudo rm -R "$arq"
    sudo rm -R "$loc"
    echo ""
    sleep 2
    echo "* Adicionando regras..."
    echo ""
    sleep 2
    sudo touch "$arq"

    echo "driftfile /var/lib/ntp/ntp.drift" >> "$arq"                       
    echo " " >> "$arq"
    echo "statsdir /var/log/ntpstats/"  >> "$arq"
    echo "statistics loopstats peerstats clockstats" >> "$arq"
    echo "filegen loopstats file loopstats type day enable" >> "$arq"
    echo "filegen peerstats file peerstats type day enable" >> "$arq"
    echo "filegen clockstats file clockstats type day enable" >> "$arq"
    echo " " >> "$arq"
    echo "server a.st1.ntp.br iburst" >> "$arq"
    echo "server b.st1.ntp.br iburst" >> "$arq"
    echo "server c.st1.ntp.br iburst" >> "$arq"
    echo "server d.st1.ntp.br iburst" >> "$arq"
    echo "server gps.ntp.br iburst" >> "$arq"
    echo "server a.ntp.br iburst" >> "$arq"
    echo "server b.ntp.br iburst" >> "$arq"
    echo "server c.ntp.br iburst" >> "$arq"
    echo "server 0.pool.ntp.org iburst" >> "$arq"
    echo "server 1.pool.ntp.org iburst" >> "$arq"
    echo "server 2.pool.ntp.org iburst" >> "$arq"
    echo "server 3.pool.ntp.org iburst" >> "$arq"
    echo " " >> "$arq"
    echo "restrict -4 default kod notrap nomodify nopeer noquery limited" >> "$arq"
    echo "restrict -6 default kod notrap nomodify nopeer noquery limited" >> "$arq"
    echo "restrict 127.0.0.1" >> "$arq"
    echo "restrict ::1" >> "$arq"
    echo " " >> "$arq"
	
    sudo touch "$loc"
    echo "America/Sao_Paulo" >> "$loc"
    echo " " >> "$loc"

    echo "* Regras adicionadas."
    echo ""
    echo ""
    sleep 2


else
    
    echo ""
    echo ""
    echo "* Verificando arquivo NTP..."
    echo "" 
    sleep 2
    echo "* Arquivo NTP inexistente."
    echo ""
    sleep 2
    echo "* Backup do arquivo."
    cp  -p "$arq" "$arq"-$(daystamp)_$(timestamp)
    cp  -p "$loc" "$loc"-$(daystamp)_$(timestamp)
    echo ""
    sleep 2
    echo "* Estruturando arquivo..."
    sudo rm -R "$arq"
    sudo rm -R "$loc"
    echo ""
    sleep 2
    echo "* Adicionando regras..."
    echo ""
    sleep 2
    sudo touch "$arq"
	
    echo "driftfile /var/lib/ntp/ntp.drift" >> "$arq"                       
    echo " " >> "$arq"
    echo "statsdir /var/log/ntpstats/"  >> "$arq"
    echo "statistics loopstats peerstats clockstats" >> "$arq"
    echo "filegen loopstats file loopstats type day enable" >> "$arq"
    echo "filegen peerstats file peerstats type day enable" >> "$arq"
    echo "filegen clockstats file clockstats type day enable" >> "$arq"
    echo " " >> "$arq"
    echo "server a.st1.ntp.br iburst" >> "$arq"
    echo "server b.st1.ntp.br iburst" >> "$arq"
    echo "server c.st1.ntp.br iburst" >> "$arq"
    echo "server d.st1.ntp.br iburst" >> "$arq"
    echo "server gps.ntp.br iburst" >> "$arq"
    echo "server a.ntp.br iburst" >> "$arq"
    echo "server b.ntp.br iburst" >> "$arq"
    echo "server c.ntp.br iburst" >> "$arq"
    echo "server 0.pool.ntp.org iburst" >> "$arq"
    echo "server 1.pool.ntp.org iburst" >> "$arq"
    echo "server 2.pool.ntp.org iburst" >> "$arq"
    echo "server 3.pool.ntp.org iburst" >> "$arq"
    echo " " >> "$arq"
    echo "restrict -4 default kod notrap nomodify nopeer noquery limited" >> "$arq"
    echo "restrict -6 default kod notrap nomodify nopeer noquery limited" >> "$arq"
    echo "restrict 127.0.0.1" >> "$arq"
    echo "restrict ::1" >> "$arq"
    echo " " >> "$arq"
	
    sudo touch "$loc"
    echo "America/Sao_Paulo" >> "$loc"
    echo " " >> "$loc"

    echo "* Regras adicionadas."
    echo ""
    echo ""
    sleep 2
    echo ""
    echo ""


fi 

   sudo systemctl restart ntp
   echo ""
   sudo service ntp restart
   echo ""
   sudo  /etc/init.d/ntp restart
   echo ""
   
   echo ""
   echo -e "* Aguarde... [\033[01;36m5\033[01;37m]"
   echo ""
   sleep 5
   echo -e "* Aguarde... [\033[01;36m4\033[01;37m]"
   echo ""
   sleep 4
   echo -e "* Aguarde... [\033[01;36m3\033[01;37m]"
   echo ""
   sleep 3
   echo -e "* Aguarde... [\033[01;36m2\033[01;37m]"
   echo ""
   sleep 2
   echo -e "* Aguarde... [\033[01;36m1\033[01;37m]"
   echo ""
   sleep 1
   echo -e "* Aguarde... [\033[01;36m0\033[01;37m]"
   echo ""
   echo ""

   sudo /usr/sbin/ntpdate -q b.st1.ntp.br
   echo ""
   echo ""
   sudo mount -o remount,ro /
   
   echo ""
   echo ""
   echo -e "* \033[01;32mFinalizado! \033[01;37m"
   echo ""
   echo ""
   echo -e "* \033[01;32mVerifique no Pi-star sua regiao em "Horario do Sistema"! \033[01;37m"
   echo ""
   echo ""
   echo -e "* \033[01;32mReinicie Raspberry Pi! \033[01;37m"
   sleep 3
   echo ""
   echo ""
