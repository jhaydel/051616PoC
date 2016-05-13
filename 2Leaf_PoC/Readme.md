Jeff Haydel and Sean Cavanaugh's Demo
===================
#Preface
- Use the Cumulus Linux Cheat Sheet as a reference:
https://community.cumulusnetworks.com/cumulus/topics/cumulus-linux-cheat-sheets

- Refresh on BGP Unnumbered
https://docs.cumulusnetworks.com/display/DOCS/Configuring+Border+Gateway+Protocol+-+BGP#ConfiguringBorderGatewayProtocol-BGP-unnumberedUsingBGPUnnumberedInterfaces

#Install Instructions
These steps will walk you through setting up your vagrant simulation environment 

#Setting up Laptop Environment

Clone this git repo to the laptop or server being used to run vagrant
```bash
$ git clone https://github.com/jhaydel/051616PoC.git
```
- The following must also be installed:
    - Virtualbox installed: https://www.virtualbox.org/wiki/Downloads 
    - Vagrant(v1.7+) installed: http://www.vagrantup.com/downloads 
    - Cumulus Plugin for Vagrant installed: 
    ```bash
    $ vagrant plugin install vagrant-cumulus 
    ```

- cd into the github directory on your laptop/server which was cloned, then into the Vagrant sub-directory
```bash
cd ~/051616PoC/2Leaf_PoC
```

- turn on the mgmt vm and the layer 2 oob switch connected to it
```bash
$ vagrant up oob-mgmt-server OOB01
```

- use the vagrant ssh mgmt command to connect to the mgmt vm
```bash
$ vagrant ssh oob-mgmt-server
Welcome to Ubuntu 14.04.4 LTS (GNU/Linux 4.2.0-27-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
----------------------------------------------------------------
  Ubuntu 14.04.4 LTS                          built 2016-02-20
----------------------------------------------------------------
Last login: Tue Mar  8 17:21:42 2016 from 10.0.2.2
vagrant@oob-mgmt-server:~$ sudo -i
root@oob-mgmt-server:~# cd /home/vagrant/
root@oob-mgmt-server:/home/vagrant# sh turnup.sh

- logout of oob-mgmt-server
```bash
root@oob-mgmt-server:~# exit
vagrant@oob-mgmt-server:~ exit
```

- turn on the rest of the VMs from the laptop/server
```bash
$ vagrant up 
```

#Ansible Setup on oob-mgmt-server
------
This should be installed by default, but here is the directions for installing latest stable Ansible
- Install the software-properties-common package
```~$ sudo apt-get install software-properties-common -qy```
- Add the ansible repository 
```~$ sudo apt-add-repository ppa:ansible/ansible -y```
- Perform and add-get update
```~$ sudo apt-get update```
- Install Ansible
```~$ sudo apt-get install ansible -qy```

Run MLAG Scenario 
------
Load Scenario1 into vagrant topology
```vagrant@oob-mgmt-server:~$ cd /home/vagrant/051616PoC/2Leaf_PoC```
```vagrant@oob-mgmt-server:~$ ansible-playbook playbook.yml -e "s=1"```

IP Address Schema
------
| Device|eth0|lo|VLAN 10|
| :--------------- | :-------------: | :-------------: | :-------------: |
| Core01 | 10.2.0.81/24 | 10.2.0.81/32 |10.10.0.81/32 |
| Core02    | 10.2.0.82/24   |  10.0.0.82/32 |10.10.0.82/32 |
| Spine01     | 10.2.0.51/24|  10.0.0.51/32  |10.10.0.51/32  |
| Spine02     | 10.2.0.52/24|  10.0.0.52/32  |10.10.0.52/32  |
| Leaf01     | 10.2.0.11/24    |  10.0.0.11/32 |10.10.0.11/32 |
| Leaf02     | 10.2.0.12/24   |  10.0.0.12/32  |10.10.0.12/32  |
| Host01     | 10.2.0.101/24    |  10.0.0.101/32  |10.10.0.101/32  |
| Host02     | 10.2.0.102/24    |  10.0.0.102/32  |10.10.0.102/32  |
| Host03     | 10.2.0.103/24    |  10.0.0.103/32  |10.10.0.103/32  |
| Host04     | 10.2.0.104/24    |  10.0.0.104/32  |10.10.0.104/32  |
| oob-mgmt-server     | 10.2.0.254/24    |  10.0.0.254/32  | N/A |