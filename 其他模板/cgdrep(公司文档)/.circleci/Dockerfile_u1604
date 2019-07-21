# How to build this image:
#
# sudo docker build --tag cogenda/cgdrep:u1604_0001 - < Dockerfile
# sudo docker push cogenda/cgdrep:u1604_0001

FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    make \
    rsync \
    curl \
    unzip \
    imagemagick \
    texlive-full \
    lyx

RUN apt-get update && apt-get install -y --no-install-recommends \
    python-pip

RUN pip install --no-cache-dir --upgrade --force-reinstall \
  setuptools

RUN apt-get update && apt-get upgrade -y

RUN rm -rf /usr/src/python ~/.cache
RUN rm -rf /var/lib/apt/lists/*

LABEL name="cgdrep-ubuntu-16.04"

CMD ["/bin/bash"]
