# saltstack-elk-formula

DevOps SaltStack Formual for ELK Unified Logging Stack - Elasticsearch, Logstash and Kibana

## Overview

This Saltstack formula is a work in progress.

It will install and single instances of the ELK stack onto a single machine.

This machine will listen and receive logs over the wire from FileBeat (Elastic Beats).

This formula works both locally with vagrant instances and in the cloud with Digital Ocean.

## Requirements

- VirtualBox
- Vagrant

## Install Local

- `git clone https://github.com/rudijs/saltstack-elk-formula.git`
- `cd saltstack-elk-formula`
- `vagrant up`
- `vagrant ssh master`

## Install Cloud (Digital Ocean)

- Update the provider digitalocean access token
- Update the ssh keys linked to your account
- `terraform apply`
- ssh to the new digital ocean droplet
