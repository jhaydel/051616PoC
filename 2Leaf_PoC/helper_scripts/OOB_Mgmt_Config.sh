#!/bin/bash
#This file is transferred to a Debian/Ubuntu Host and executed to re-map interfaces
#Extra config COULD be added here but I would recommend against that to keep this file standard.
echo "#################################"
echo "  Running OOB_Mgmt_Config.sh"
echo "#################################"
sudo su
#Test for Debian-Based Host
which apt &> /dev/null
if [ "$?" == "0" ]; then
    #These lines will be used when booting on a debian-based box
    echo -e "note: ubuntu device detected"
    #remove cloud-init software
    #apt-get purge cloud-init -y
    #Replace existing network interfaces file
    echo -e "auto lo" > /etc/network/interfaces
    echo -e "iface lo inet loopback\n\n" >> /etc/network/interfaces
    echo -e  "source /etc/network/interfaces.d/*.cfg\n" >> /etc/network/interfaces
    #Add vagrant interface
    echo -e "\n\nauto vagrant" > /etc/network/interfaces.d/vagrant.cfg
    echo -e "iface vagrant inet dhcp\n\n" >> /etc/network/interfaces.d/vagrant.cfg
    echo -e "\n\nauto eth1" > /etc/network/interfaces.d/eth1.cfg
    echo -e "iface eth1 inet static" >> /etc/network/interfaces.d/eth1.cfg
    echo -e "address 10.2.0.254/24\n\n" >> /etc/network/interfaces.d/eth1.cfg
    #Installations
    apt-get update -y
    apt-get install software-properties-common -qy
    apt-add-repository ppa:ansible/ansible -y
    apt-get update -y
    apt-get install -y isc-dhcp-server dnsmasq apache2 python-pip shedskin libyaml-dev sshpass git ansible
fi
#Test for Fedora-Based Host
which yum &> /dev/null
if [ "$?" == "0" ]; then
    echo -e "note: fedora-based device detected"
    /usr/bin/dnf install python -y
    echo -e "DEVICE=vagrant\nBOOTPROTO=dhcp\nONBOOT=yes" > /etc/sysconfig/network-scripts/ifcfg-vagrant
fi




echo "Generating SSH Key..."
/usr/bin/ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
echo "Copying Key into /var/www/..."
cp /root/.ssh/id_rsa.pub /var/www/authorized_keys

REPOSITORY="https://github.com/jhaydel/051616PoC"
dir=051616PoC

#rest of turnup
echo "git clone $REPOSITORY" > /home/vagrant/turnup.sh
echo "cat /home/vagrant/$dir/etc/hosts | tee /etc/hosts" >> /home/vagrant/turnup.sh
echo "cp /home/vagrant/$dir/etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf" >> /home/vagrant/turnup.sh
echo "/etc/init.d/isc-dhcp-server restart" >> /home/vagrant/turnup.sh
echo "cp /home/vagrant/$dir/var/www/* /var/www/" >> /home/vagrant/turnup.sh

echo "#################################"
echo "   Finished"
echo "#################################"
