#!/bin/bash

eval `ssh-agent -s`
cat ~/.ssh_host/id_rsa | ssh-add -k -
