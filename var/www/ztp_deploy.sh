#!/bin/bash

function error() {
  echo -e "\e[0;33mERROR: The Zero Touch Provisioning script failed while running the command $BASH_COMMAND at line $BASH_LINENO.\e[0m" >&2
}
trap error ERR

SSH_URL="http://10.2.0.254/authorized_keys"
LIC_URL="http://10.2.0.254/license.txt"

#Install license
wget -q -O /root/license.txt $LIC_URL
/usr/cumulus/bin/cl-license -i /root/license.txt

#Setup SSH key authentication for Ansible
mkdir -p /root/.ssh
wget -O /root/.ssh/authorized_keys $SSH_URL
mkdir -p /home/cumulus/.ssh
wget -O /home/cumulus/.ssh/authorized_keys $SSH_URL
chown -R cumulus:cumulus /home/cumulus/.ssh

exit 0
#CUMULUS-AUTOPROVISIONING

