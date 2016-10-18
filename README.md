# nuxeo-vagrant
Démonstration d'une installation d'un serveur Nuxeo sous Ubuntu

# Utilisation 

Installer Vagrant sur votre poste de travail : https://www.vagrantup.com/
Installer GIT : https://git-scm.com/downloads

git clone https://github.com/nohavy/nuxeo-vagrant
cd nuxeo-vagrant
vagrant up

Une VM est installée et configurée avec une instance Nuxeo 8.3

La configuration comprend : 
- jdk 8u40
- Nuxeo server 8.3
- un frontal Apache configuré
- fakeSMTP
- npm, Yeoman et nuxeo/generator-nuxeo
- maven 3.1.1

L'installation et la configuration des outils suivant est donnée en exemple : 
- une bdd postgres
- un serveur Redis
- un serveur ElasticSearch

=> voir le fichier scripts/provision.sh pour l'installation et la configuration de ces outils.


Vous pouvez vous connecter à Nuxeo depuis votre poste client avec : http://localhost:8080/nuxeo
