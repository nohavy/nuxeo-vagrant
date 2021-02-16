# Nuxeo Vagrant
Demonstration of an installation of a Nuxeo server under Ubuntu

## Use

Install Vagrant on your workstation: https://www.vagrantup.com/
Install GIT: https://git-scm.com/downloads

```bash

git clone https://github.com/nohavy/nuxeo-vagrant
cd nuxeo-vagrant
make start

```

A VM is installed and configured with a Nuxeo 10.10 instance

The configuration includes:

- jdk 8u40
- Nuxeo server 10.10 tomcat version
- a configured Apache front-end
- fakeSMTP
- npm
  - Yeoman
  - nuxeo/generator-nuxeo
- maven 3.1.1

The installation and configuration of the following tools is given as an example:

- a postgres bdd
- a Redis server
- an Elasticsearch server

> See the scripts / provision.sh file for the installation and configuration of these tools.


You can connect to Nuxeo from your client workstation with: http://localhost:8080/nuxeo