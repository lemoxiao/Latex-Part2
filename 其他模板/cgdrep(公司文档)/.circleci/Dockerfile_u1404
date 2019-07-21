# How to build this image:
#
# sudo docker build --tag cogenda/cgdrep:u1404_0001 - < Dockerfile
# sudo docker push cogenda/cgdrep:u1404_0001

FROM ubuntu:14.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    make \
    rsync \
    curl \
    unzip \
    imagemagick \
    software-properties-common

RUN add-apt-repository ppa:jonathonf/texlive-2015 && \
    add-apt-repository ppa:lyx-devel/release && \
    apt-get update && \
    apt-get install -y --no-install-recommends texlive-full lyx

RUN apt-get update && apt-get install -y --no-install-recommends \
    python-pip

RUN pip install --upgrade --force-reinstall setuptools

RUN apt-get update && apt-get upgrade -y

RUN rm -rf /usr/src/python ~/.cache
RUN rm -rf /var/lib/apt/lists/*

LABEL name="cgdrep-ubuntu-14.04"

CMD ["/bin/bash"]
