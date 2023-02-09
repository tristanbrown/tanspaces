#!/bin/bash

eval `ssh-agent -s`
cat $HOST_SSH_MNT/id_rsa | ssh-add -k -
