# Start from Jupyterlab scipy. 
# View here:
# https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile

ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    vim libpq-dev openssh-client

# Restore standard environment
USER $NB_UID
WORKDIR $HOME
