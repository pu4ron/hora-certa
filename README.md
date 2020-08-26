# PU4RON - Ronualdo
# Script para ajuste de horário PT-BR no pi-star.

rpi-rw

# Para excluir versões antigas do script.
sudo rm -R /home/pi-star/hora-certa

# Comandos para executar script.

sudo git clone https://github.com/pu4ron/hora-certa.git

cd hora-certa

sudo chmod +x ntp.sh

sudo chmod 777 ntp.sh

sudo ./ntp.sh
