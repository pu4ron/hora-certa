#! /bin/bash

echo ""
echo ""
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
echo ""

read -p "* V4 - Continuar e adicionar servidores NTP-BR? (S/N) " -n 1 -r

case "$REPLY" in 

  s|S ) echo "" ;;
  n|N ) exit 0 ;;
    * ) exit 0 ;;
esac


sudo mount -o remount,rw /


arq="/etc/ntp.conf"
loc="/etc/timezone"
scp="/home/pi-star/hora-certa"
tab="/etc/crontab"
atp="/boot/LOCALTIME"
fw="/root/ipv4.fw"
hs="/etc/hosts"
sp="/usr/share/zoneinfo/right/America/Sao_Paulo" 


daystamp(){
   date +"%d.%m.%y"
}

timestamp(){
   date +"%T"
}


sleep 1


if [ -f "$atp" ]; then

   sudo mount -o remount,rw /
   sudo rm /boot/LOCALTIME
   echo " "
   echo "* Remodelando LocalTime."

else

   sudo mount -o remount,rw /
   sudo cp /usr/share/zoneinfo/right/America/Sao_Paulo /boot/LOCALTIME
   echo " "
   echo "* Arquivo LocalTime - OK."

fi



sleep 1


if [ -f "$hs" ]; then

   sudo mount -o remount,rw /
   echo "127.0.0.1       NTP-server-host" >> "$hs"
   echo "* Arquivo NTP-server-host - OK."


else

   echo "*"

fi



sleep 1


if [ -f "$fw" ]; then

   sudo mount -o remount,rw /

   echo "iptables -A INPUT   -p udp --dport 123 -j ACCEPT" >> "$fw"
   echo "iptables -A FORWARD -p udp --dport 123 -j ACCEPT" >> "$fw"
   echo "iptables -A OUTPUT  -p udp --dport 123 -j ACCEPT" >> "$fw"
   echo ""
   echo "iptables -A INPUT   -p tcp --dport 123 -j ACCEPT" >> "$fw"
   echo "iptables -A FORWARD -p tcp --dport 123 -j ACCEPT" >> "$fw"
   echo "iptables -A OUTPUT  -p tcp --dport 123 -j ACCEPT" >> "$fw"

   sudo pistar-firewall 
   echo " "
   echo "* Add regras Fw dport - OK."
   sudo mount -o remount,rw /


else  

   sudo mount -o remount,rw /

   sudo touch "$fw"

   echo "iptables -A INPUT   -p udp --dport 123 -j ACCEPT" >> "$fw"
   echo "iptables -A FORWARD -p udp --dport 123 -j ACCEPT" >> "$fw"
   echo "iptables -A OUTPUT  -p udp --dport 123 -j ACCEPT" >> "$fw"
   echo ""
   echo "iptables -A INPUT   -p tcp --dport 123 -j ACCEPT" >> "$fw"
   echo "iptables -A FORWARD -p tcp --dport 123 -j ACCEPT" >> "$fw"
   echo "iptables -A OUTPUT  -p tcp --dport 123 -j ACCEPT" >> "$fw"

   sudo pistar-firewall 
   echo " "
   echo "* Criado e add regras Fw dport - OK."
   sudo mount -o remount,rw /

fi


sleep 1

   sudo mount -o remount,rw /

   echo "10 * * * *	root  /usr/sbin/ntpdate a.ntp.br > /dev/null 2>&1 &" >> "$tab"
   echo "30 * * * *	root  /usr/sbin/ntpdate b.ntp.br > /dev/null 2>&1 &" >> "$tab"
   echo "60 * * * *	root  /usr/sbin/ntpdate c.ntp.br > /dev/null 2>&1 &" >> "$tab"
   echo "@reboot  /usr/sbin/ntpdate a.ntp.br" >> "$tab"
   echo "@reboot  /usr/sbin/ntpdate c.ntp.br" >> "$tab"

   echo " "
   echo "* Add agendamento Cron - OK."



sleep 1


   echo ""
   echo -e "* Aguarde... [\033[01;36m*\033[01;37m]"
   sleep 1

   echo ""
   sudo mount -o remount,rw /
   sudo systemctl stop systemd-timesyncd

   sleep 1
   sudo mount -o remount,rw /
   sudo systemctl disable systemd-timesyncd
   sleep 1

   sudo mount -o remount,rw /
   sudo /etc/init.d/ntp stop
   sleep 1

   echo ""
   sudo mount -o remount,rw /
   sudo pistar-update && sudo apt-get install ntpdate -y
   sleep 1

   echo ""
   sudo mount -o remount,rw /
   sudo apt-get remove ntp -y
   sleep 1

   echo ""
   sudo mount -o remount,rw /
   sudo pistar-expand
   sleep 1

   echo ""
   sudo mount -o remount,rw /


   sudo /usr/sbin/ntpdate a.ntp.br
   echo ""
   sudo /usr/sbin/ntpdate b.ntp.br
   echo ""
   sudo /usr/sbin/ntpdate c.ntp.br


   echo ""
   sudo mount -o remount,rw /
 

if [ -f "$arq" ]; then
 
    echo ""
    echo ""
    echo "* Verificando arquivo NTP..."
    echo "" 
    sleep 2
    echo "* Arquivo NTP existente."
    echo ""
    sleep 2
    echo "* Backup do arquivo."
    sudo mount -o remount,rw /
    sudo cp  -p "$arq"    "$arq"-$(daystamp)_$(timestamp)
    sudo cp  -p "$loc"    "$loc"-$(daystamp)_$(timestamp)
    echo ""
    sleep 2
    echo "* Estruturando arquivo..."
    sudo mount -o remount,rw /
    sudo rm -R "$arq"
    sudo rm -R "$loc"
    echo ""
    sleep 2
    echo "* Adicionando regras..."
    echo ""
    sleep 2
    sudo mount -o remount,rw /
    sudo touch "$arq"
	
    echo "driftfile /tmp/ntp.drift" >> "$arq"
    echo " " >> "$arq"
    echo "leapfile /usr/share/zoneinfo/leap-seconds.list" >> "$arq"
    echo " " >> "$arq"
    echo "filegen loopstats file loopstats type day enable" >> "$arq"
    echo "filegen peerstats file peerstats type day enable" >> "$arq"
    echo "filegen clockstats file clockstats type day enable" >> "$arq"
    echo " " >> "$arq"
    echo "server a.ntp.br" >> "$arq"
    echo "server b.ntp.br" >> "$arq"
    echo "server c.ntp.br" >> "$arq"
    echo " " >> "$arq"
    echo "server 0.br.pool.ntp.org" >> "$arq"
    echo "server 1.br.pool.ntp.org" >> "$arq"
    echo "server 2.br.pool.ntp.org" >> "$arq"
    echo "server 3.br.pool.ntp.org" >> "$arq"
    echo " " >> "$arq"
    echo "pool 0.debian.pool.ntp.org iburst" >> "$arq"
    echo "pool 1.debian.pool.ntp.org iburst" >> "$arq"
    echo "pool 2.debian.pool.ntp.org iburst" >> "$arq"
    echo "pool 3.debian.pool.ntp.org iburst" >> "$arq"
    echo " " >> "$arq"
    echo "server c.st1.ntp.br prefer iburst" >> "$arq"
    echo "server NTP-server-host prefer iburst" >> "$arq"
    echo "server a.st1.ntp.br iburst" >> "$arq"
    echo "server b.st1.ntp.br iburst" >> "$arq"
    echo "server c.st1.ntp.br iburst" >> "$arq"
    echo "server d.st1.ntp.br iburst" >> "$arq"
    echo " " >> "$arq"
    echo "server gps.ntp.br iburst" >> "$arq"
    echo "server a.ntp.br iburst" >> "$arq"
    echo "server b.ntp.br iburst" >> "$arq"
    echo "server c.ntp.br iburst" >> "$arq"
    echo " " >> "$arq"
    echo "restrict -4 default kod notrap nomodify nopeer noquery limited" >> "$arq"
    echo "restrict -6 default kod notrap nomodify nopeer noquery limited" >> "$arq"
    echo " " >> "$arq"
    echo "restrict 127.0.0.1" >> "$arq"
    echo "restrict ::1" >> "$arq"
    echo "restrict source notrap nomodify noquery" >> "$arq"
    echo " " >> "$arq"
    echo "#restrict 192.168.0.23 mask 255.255.255.0 notrust" >> "$arq"
    echo "#broadcast 192.168.0.255" >> "$arq"
    echo "#disable auth" >> "$arq"
    echo "#broadcastclient" >> "$arq"
    echo " " >> "$arq"
	
	
    sudo mount -o remount,rw /	
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
    sudo mount -o remount,rw /
    cp  -p "$arq" "$arq"-$(daystamp)_$(timestamp)
    cp  -p "$loc" "$loc"-$(daystamp)_$(timestamp)
    echo ""
    sleep 2
    echo "* Estruturando arquivo..."
    sudo mount -o remount,rw /
    sudo rm -R "$arq"
    sudo rm -R "$loc"
    echo ""
    sleep 2
    echo "* Adicionando regras..."
    echo ""
    sleep 2
    sudo mount -o remount,rw /
    sudo touch "$arq"
	
	
    echo "driftfile /tmp/ntp.drift" >> "$arq"
    echo " " >> "$arq"
    echo "leapfile /usr/share/zoneinfo/leap-seconds.list" >> "$arq"
    echo " " >> "$arq"
    echo "filegen loopstats file loopstats type day enable" >> "$arq"
    echo "filegen peerstats file peerstats type day enable" >> "$arq"
    echo "filegen clockstats file clockstats type day enable" >> "$arq"
    echo " " >> "$arq"
    echo "server a.ntp.br" >> "$arq"
    echo "server b.ntp.br" >> "$arq"
    echo "server c.ntp.br" >> "$arq"
    echo " " >> "$arq"
    echo "server 0.br.pool.ntp.org" >> "$arq"
    echo "server 1.br.pool.ntp.org" >> "$arq"
    echo "server 2.br.pool.ntp.org" >> "$arq"
    echo "server 3.br.pool.ntp.org" >> "$arq"
    echo " " >> "$arq"
    echo "pool 0.debian.pool.ntp.org iburst" >> "$arq"
    echo "pool 1.debian.pool.ntp.org iburst" >> "$arq"
    echo "pool 2.debian.pool.ntp.org iburst" >> "$arq"
    echo "pool 3.debian.pool.ntp.org iburst" >> "$arq"
    echo " " >> "$arq"
    echo "server c.st1.ntp.br prefer iburst" >> "$arq"
    echo "server NTP-server-host prefer iburst" >> "$arq"
    echo "server a.st1.ntp.br iburst" >> "$arq"
    echo "server b.st1.ntp.br iburst" >> "$arq"
    echo "server c.st1.ntp.br iburst" >> "$arq"
    echo "server d.st1.ntp.br iburst" >> "$arq"
    echo " " >> "$arq"
    echo "server gps.ntp.br iburst" >> "$arq"
    echo "server a.ntp.br iburst" >> "$arq"
    echo "server b.ntp.br iburst" >> "$arq"
    echo "server c.ntp.br iburst" >> "$arq"
    echo " " >> "$arq"
    echo "restrict -4 default kod notrap nomodify nopeer noquery limited" >> "$arq"
    echo "restrict -6 default kod notrap nomodify nopeer noquery limited" >> "$arq"
    echo " " >> "$arq"
    echo "restrict 127.0.0.1" >> "$arq"
    echo "restrict ::1" >> "$arq"
    echo "restrict source notrap nomodify noquery" >> "$arq"
    echo " " >> "$arq"
    echo "#restrict 192.168.0.23 mask 255.255.255.0 notrust" >> "$arq"
    echo "#broadcast 192.168.0.255" >> "$arq"
    echo "#disable auth" >> "$arq"
    echo "#broadcastclient" >> "$arq"
    echo " " >> "$arq"
	
    sudo mount -o remount,rw /
    sudo touch "$loc"
    echo "America/Sao_Paulo" >> "$loc"
    echo " " >> "$loc"

    echo "* Regras adicionadas."
    echo ""
    echo ""
    sleep 2


fi 


   echo ""
   echo -e "* Aguarde... [\033[01;36mNtp-s1\033[01;37m]"
   sleep 2
   sudo /usr/sbin/ntpdate a.ntp.br
   echo ""
   echo ""
   echo -e "* Aguarde... [\033[01;36mNtp-s2\033[01;37m]"
   sleep 2
   sudo /usr/sbin/ntpdate b.ntp.br
   echo ""
   echo ""
   echo -e "* Aguarde... [\033[01;36mNtp-s3\033[01;37m]"
   sleep 2
   sudo /usr/sbin/ntpdate c.ntp.br
   echo ""
   echo ""
   echo -e "* Aguarde... [\033[01;36m*\033[01;37m]"
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
   sleep 2