# Nuxeo Docker ENV

Demonstration of an installation of a **Nuxeo** server under Docker

See references here:

- https://hub.docker.com/_/nuxeo
- https://doc.nuxeo.com/nxdoc/build-a-custom-docker-image/
- https://doc.nuxeo.com/nxdoc/docker-image/

## Use

Use `make start` to start **Nuxeo** on a localhost .env, on the http location `http://localhost:8080/nuxeo`.

To stop do `make clean`.

## Install

Use `make deploy` to build and run the instance on the port 9999 by default. To override the port use `make deploy PORT=ANY_PORT`.

```bash

cd /opt
mkdir nuxeo
cd nuxeo
sudo chmod -R 777 ./
git clone https://github.com/JoseRodrigues443/nuxeo-deploy-tools.git

sudo chmod -R 777 nuxeo-deploy-tools
cd nuxeo-deploy-tools/docker
make deploy

```

> To check if the port is being used use the command ` lsof -Pi :PORT -sTCP:LISTEN -t` if it has value, then is used.
