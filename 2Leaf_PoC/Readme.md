Jeff Haydel and Sean Cavanaugh's Demo
===================
Preface
------
- Use the Cumulus Linux Cheat Sheet as a reference:
https://community.cumulusnetworks.com/cumulus/topics/cumulus-linux-cheat-sheets

- Refresh on BGP Unnumbered
https://docs.cumulusnetworks.com/display/DOCS/Configuring+Border+Gateway+Protocol+-+BGP#ConfiguringBorderGatewayProtocol-BGP-unnumberedUsingBGPUnnumberedInterfaces

Vagrant Setup
------
- Turn up the vagrant topology
```~$ vagrant up```
- ssh to the oob-mgmt-server
```~$ vagrant ssh oob-mgmt-server```

Ansible Setup on oob-mgmt-server
------
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
```cumulus@oob-mgmt-server:~$ ansible-playbook playbook.yml -e "s=1"```

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