#!/usr/bin/env sh
set -e
invest_version=$1
if [ -z "$invest_version" ]; then
    echo '[ERROR] first param must be InVEST version, e.g. 3.4.2'
    exit 1
fi
apt-get update
apt-get install --assume-yes --no-install-recommends \
    libgdal-dev \
    mercurial \
    python \
    python-pip \
    python-setuptools \
    python-dev \
    python-pkg-resources \
    gcc \
    g++
pip install --upgrade pip
pip install numpy
pip install 'pygeoprocessing>=0.5.0,<0.6.0'
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
pip install -r https://bitbucket.org/natcap/invest/raw/$invest_version/requirements.txt
pip install hg+https://bitbucket.org/natcap/invest@$invest_version
apt-get purge --assume-yes \
    mercurial \
    python-pip \
    python-setuptools \
    python-dev \
    gcc \
    g++
apt-get autoremove --assume-yes
apt-get --assume-yes clean
rm -rf \
 /var/lib/apt/lists/* \
 /tmp/* \
 /var/tmp/*
rm setup.sh
