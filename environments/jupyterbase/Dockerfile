# Start from Jupyterlab scipy. 
# View here:
# https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile

ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

USER root

## Install Unix packages
RUN apt-get update && apt-get install -yq --no-install-recommends \
    vim libpq-dev openssh-client

## Restore standard environment
USER $NB_UID

## Fix git
RUN git config --global safe.directory '*'

## Copy files last to avoid cache explosion
## Start ssh service
COPY --chmod=0755 ./start-ssh.sh /usr/local/bin/

## Config Jupyterlab
COPY overrides.json /opt/conda/share/jupyter/lab/settings/

WORKDIR $HOME
