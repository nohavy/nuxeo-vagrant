FROM docker-private.packages.nuxeo.com/nuxeo/nuxeo:2021

# Path to POML.xml TODO setup a proper dir via paramter
COPY /path/to/my-configuration.properties /etc/nuxeo/conf.d/my-configuration.properties

# we need to be root to run yum commands
USER 0
# install RPM Fusion free repository
RUN yum -y localinstall --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm
# install ffmpeg package
RUN yum -y install ffmpeg
# set back original user
USER 900
