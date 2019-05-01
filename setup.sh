#!/usr/bin/env sh
set -e
invest_version=3.6.0

apt-get update
apt-get install --assume-yes --no-install-recommends \
    libgdal-dev \
    libspatialindex-c5 \
    python \
    python-pip \
    python-setuptools \
    python-dev \
    python-pkg-resources \
    gcc \
    g++ \
    wget \
    unzip


pushd /data
poll_zip=pollination.zip
wget -O $poll_zip "http://data.naturalcapitalproject.org/invest-data/$invest_version/pollination.zip"
unzip $poll_zip
rm $poll_zip
popd

pip install numpy wheel Cython
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
# invest doesn't pin the versions
pip install 'matplotlib<3'
pip install -r https://bitbucket.org/natcap/invest/raw/$invest_version/requirements.txt
pip install https://bitbucket.org/natcap/invest/get/$invest_version.zip
apt-get purge --assume-yes \
    python-pip \
    python-setuptools \
    python-dev \
    gcc \
    g++ \
    wget \
    unzip
apt-get autoremove --assume-yes
apt-get --assume-yes clean
rm -rf \
 /var/lib/apt/lists/* \
 /tmp/* \
 /var/tmp/*
rm setup.sh
