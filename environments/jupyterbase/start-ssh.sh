#!/bin/bash

eval `ssh-agent -s`
cat $HOST_SSH_MNT/id_rsa | ssh-add -k -
mkdir ~/.ssh
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
