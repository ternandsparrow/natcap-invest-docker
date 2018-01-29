#!/usr/bin/env sh
set -e
invest_version=3.3.3
apt-get update
# optimise with --no-install-recommends when we know what we need
apt-get install --assume-yes \
    libgdal-dev \
    mercurial \
    python-pip
    # python-setuptools \
    # gcc \
    # g++
pip install --upgrade pip
pip install numpy
pip install pygeoprocessing==0.3.2
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
pip install -r https://bitbucket.org/natcap/invest/raw/$invest_version/requirements.txt
pip install hg+https://bitbucket.org/natcap/invest@$invest_version
apt-get -y clean
rm -rf /var/lib/apt/lists/*
# TODO add reference data
# TODO consider removing pip, but leaving python. Need to install the pkg..? dep of invest though
