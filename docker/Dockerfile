FROM nuxeo:10.10

USER root

# Import nuxeo conf to the docker env
COPY ./configs/nuxeo.conf /docker-entrypoint-initnuxeo.d/nuxeo.conf
COPY ./configs/nuxeo.conf /etc/nuxeo/nuxeo.conf

# Add packages 
COPY packages/ /docker-entrypoint-initnuxeo.d/

RUN chmod -R 777 /docker-entrypoint-initnuxeo.d
RUN chmod 777 /etc/nuxeo/nuxeo.conf

RUN echo "deb http://httpredir.debian.org/debian jessie non-free" >> /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y --no-install-recommends libfaac-dev git apt-utils

RUN echo "deb http://apt.nuxeo.org/ stretch releases" > /etc/apt/sources.list.d/nuxeo.list
RUN curl http://apt.nuxeo.org/nuxeo.key | apt-key add -

RUN apt-get update -y
RUN apt-get install -y ffmpeg-nuxeo

USER 1000

