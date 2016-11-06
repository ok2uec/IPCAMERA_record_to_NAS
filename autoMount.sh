#!/bin/bash
# autoMount.sh
# ------------
# Note: Pokud nefunguje AutoMount, nastavit do cronu připojování k vzdalenemu ulozisti
#
# CRON: /etc/crontab -> */2 *   * * *   root    sh /root/autoMount.sh
#       Spousti se kazde 2 minuty, lze nastavit i vetsi freq. pokud je slozka existujici tak to preskoci..
# -----------
# Author: @smoce.net

# Remote SMB cifs NAS server
FOLDERremove='//192.168.99.160/camera'

# Local mount folder
FOLDERlocal='/media/camera'

# username for NAS storage space
USERSMB='username'
# password for NAS storage space
PASSSMB='cam22'

if [ ! -d /media/camera/record ]; then
	mount -t cifs $FOLDERremove $FOLDERlocal -o username=${USERSMB},password=${PASSSMB},domain=hack
fi;



