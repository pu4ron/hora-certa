# RONUALDO - PU4RON

# Script-V3 para ajuste de horário PT-BR no pi-star.

# Para excluir versões antigas do script.

rpi-rw

sudo rm -R /home/pi-star/hora-certa

# Comandos para executar script.

rpi-rw

sudo git clone https://github.com/pu4ron/hora-certa.git

cd hora-certa

sudo chmod +x ntp.sh

sudo chmod 777 ntp.sh

sudo ./ntp.sh
