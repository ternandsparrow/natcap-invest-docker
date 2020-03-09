#!/usr/bin/env sh
set -euo pipefail

# can be any git commit-ish (tags, commits, branches)
investCodeVersion=3.8.0

# check http://data.naturalcapitalproject.org/invest-data/ for options
# NOTE: this data is only an example used for the tester UI, it is NOT used
#       for running in production when the user supplies data.
investDataVersion=3.6.0 # seems there isn't a newer version of the data at the time of writing

apt-get update
apt-get install --assume-yes --no-install-recommends \
    libgdal-dev \
    libspatialindex-c5 \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-dev \
    python3-pkg-resources \
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

pip3 install numpy wheel Cython ptvsd
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
pip3 install https://bitbucket.org/natcap/invest/get/$investCodeVersion.zip
apt-get purge --assume-yes \
    python3-pip \
    python3-setuptools \
    python3-dev \
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
