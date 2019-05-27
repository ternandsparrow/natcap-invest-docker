#!/usr/bin/env sh
set -euo pipefail

# can be any git commit-ish (tags, commits, branches)
# investCodeVersion=3.6.0
investCodeVersion=f527f3a

# check http://data.naturalcapitalproject.org/invest-data/ for options
# NOTE: this data is only an example used for the tester UI, it is NOT required
#       for running in production when the user supplies data.
investDataVersion=3.6.0

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
wget -O $poll_zip "http://data.naturalcapitalproject.org/invest-data/$investDataVersion/pollination.zip"
unzip $poll_zip
rm $poll_zip
popd

pip install numpy wheel Cython
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
# invest doesn't pin the versions
pip install 'matplotlib<3'
pip install https://bitbucket.org/natcap/invest/get/$investCodeVersion.zip
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
