# saltstack-elk-formula

DevOps SaltStack Formual for ELK Unified Logging Stack - Elasticsearch, Logstash and Kibana

## Overview

This Saltstack formula is a work in progress.

It will install single instances of the ELK stack software onto a single machine.

This machine will listen and receive logs over the wire from FileBeat (Elastic Beats).

This formula works both locally with vagrant instances and in the cloud with Digital Ocean.

## Requirements

- VirtualBox
- Vagrant

## Install Local (Vagrant)

- `git clone https://github.com/rudijs/saltstack-elk-formula.git`
- `cd saltstack-elk-formula`
- `vagrant up`
- `vagrant ssh master`
- Open a browser to the Kibana UI
- [http://192.168.50.11:5601](http://192.168.50.11:5601)
- Send some test log entries...
- `vagrant ssh minion1`
- `echo 101 >> /tmp/test.log`
- Message "101" should appear in Kibana (refresh or use auto-refresh).

## Install Cloud (Digital Ocean)

- Update the provider digitalocean access token
- Update the ssh keys linked to your account
- `terraform apply`
- ssh to the new digital ocean droplet
