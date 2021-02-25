# Nuxeo Environment Tools

- [Nuxeo Environment Tools](#nuxeo-environment-tools)
  - [Description](#description)
  - [How to use](#how-to-use)
    - [Requirements](#requirements)
  - [Structure](#structure)
  - [License](#license)

## Description

The object of this project is to allow to raise a Nuxeo Platform on a local machine or even on a live env.

This project is a fork from [the nohavy/nuxeo-vagrant project that is 4 years old](https://github.com/nohavy/nuxeo-vagrant), and that only implements vagrant.

This project updates the vagrant configs, using `nuxeo 10.10` and also adds a docker implementation, useing `docker-compose` or a stand alone `docker` implementation.

## How to use

Depending on the tech stack needed (docker or vagrant) go to one of the folders, there will be visible a `README.md` file with the instructions to the specific solution.

### Requirements

- Makefile
- Docker
- Docker Compose
- Vagrant
- Bash
- Maven
  - Java 8+
- Unzip command

## Structure

```bash
.
├───.vscode
├───docker        # docker configuration directory
│   ├───configs      # Docker .env and nuxeo.conf config file
│   ├───logs         # All logs are saved
│   ├───packages         # Folder used to inject on the docker with Nuxeo compatible extensions or nuxeo studio exports
│   ├───scripts      # Utils bash scripts
│   └───sources      # Folder to store all the Nuxeo compatible projects to be installed on the deployment.
└───vagrant       # vagrant configuration directory using debian 10
    ├───config
    │   ├───apache     # apache2 configs
    │   └───nuxeo      # nuxeo.conf config file
    ├───packages      # standalone packages to be compiled (fakeSMTP not available via apt)
    └───scripts
    │   ├───init-db.sql    # Postgres SQL script to setup nuxeo env
    │   └───provision.sh   # Script to install all the linux dependencies, like nuxeo, ffmpeg, etc
    └───Vagrant     # Vagrant setup file 

```

## License

Considering the [original project](https://github.com/nohavy/nuxeo-vagrant) that has been forked, does not have any license I will not had one in this project, not limiting the original developer filosofy and interest, but consider that both projects (this and the [original project](https://github.com/nohavy/nuxeo-vagrant)) are public, then everyone haves the right to fork it according to the Terms of Service of GitHub.

More information can be seen at [GitHub's licensing help page](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/licensing-a-repository#choosing-the-right-license) that specifies:

> You're under no obligation to choose a license. However, without a license, the default copyright laws apply, meaning that you retain all rights to your source code and no one may reproduce, distribute, or create derivative works from your work. If you're creating an open source project, we strongly encourage you to include an open source license. The Open Source Guide provides additional guidance on choosing the correct license for your project.
>
> Note: If you publish your source code in a public repository on GitHub, according to the Terms of Service, other GitHub users have the right to view and fork your repository within the GitHub site. If you have already created a public repository and no longer want users to have access to it, you can make your repository private. When you convert a public repository to a private repository, existing forks or local copies created by other users will still exist.
