# saltstack-elk-formula

DevOps SaltStack Formual for ELK Unified Logging Stack - Elasticsearch, Logstash and Kibana

## Overview

This Saltstack formula is a work in progress.

The default behavior is a 3 machine setup for 2 stages:

1. Master (salt-master)
2. Minion1 (salt-minion, Filebeat, ELK stack)
3. Minion2 (salt-minion, Filebeat)

The stages are:

1. Local - Vagrant with Virtualbox
2. Cloud - Terraform and ssh

Within each of these stages are the defined Saltstack enviroments.

## ELK Stack

The ELK stack on Minion1 will comprise:

- Elasticsearch
- Logstash
- Kibana

This machine will listen and receive logs over the wire from FileBeat (Elastic Beats).
Kibana web UI admin tool is also served from here.

## Log Shippers

Install Filebeat on to every node.

Filebeat will send logs over the wire to the ELK stack.

Default logs being shipped from host to ELK stack are:

```
/var/log/*.log
/var/log/upstart/*.log
/var/log/syslog
```

Add hosts/log-shippers in [saltstack/salt/top.sls](saltstack/salt/top.sls)

Configure custom host logs to ship in [saltstack/pillar/filebeat.sls](saltstack/pillar/filebeat.sls)

## TODO

This formula is currenlty configured for a *single instance* of each ELK stack component.

For larger volumes of traffic/data, the formula will need to add in support for clustering.

## Requirements

- VirtualBox
- Vagrant

## Install Local (Vagrant)

- `git clone https://github.com/rudijs/saltstack-elk-formula.git`
- `cd saltstack-elk-formula`
- `vagrant up`
- After some time all three servers will be up with Saltstack installed.
- `vagrant ssh master`
- From the *master* install the ELK stack on *minion1* and Filebeat (log shipper) on both *minion1* and *minion2*
- `sudo salt '*' state.highstate`
- TODO: Repeat this command if the formula fails. Sometimes apt-get installs fail.
- All done, now open a browser to the Kibana UI
- [http://192.168.50.11:5601](http://192.168.50.11:5601)
- Filebeat agent log data should already in ready for viewing
- Send some manual test log entries...
- `vagrant ssh minion1`
- `echo 101 >> /tmp/test.log`
- Message "101" should appear in Kibana (refresh or use auto-refresh).

## Install Cloud (Digital Ocean)

- Update the provider digitalocean access token
- Update the ssh keys linked to your account
- `terraform apply`
- ssh to the new digital ocean droplet
- TODO
