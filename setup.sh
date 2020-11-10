#!/usr/bin/env sh
set -euo pipefail

# can be any git commit-ish (tags, commits, branches)
investCodeVersion=3.8.9

# check http://releases.naturalcapitalproject.org/?prefix=invest/3.8.9/data/ for
# options.
# NOTE: this data is only an example used for the tester UI, it is NOT used
#       for running in production when the user supplies data.
investDataUrl='https://www.googleapis.com/download/storage/v1/b/releases.naturalcapitalproject.org/o/invest%2F3.8.9%2Fdata%2Fpollination.zip?generation=1600197914247447&alt=media'

# stop tzdata from prompting for a TZ, thanks https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive#comment91752692_44333806
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get dist-upgrade --assume-yes
apt-get install --assume-yes --no-install-recommends \
  libgdal20 \
  libgdal-dev \
  libspatialindex-c5


pushd /data
poll_zip=pollination.zip
wget -O $poll_zip "$investDataUrl"
unzip $poll_zip
rm $poll_zip
popd

pip3 install numpy Cython ptvsd
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
pip3 install natcap.invest==$investCodeVersion
# we can remove the dev dependencies after building the python bindings
apt-get purge --assume-yes \
  libgdal-dev
apt-get autoremove --assume-yes
apt-get --assume-yes clean
rm -rf \
  /var/lib/apt/lists/* \
  /tmp/* \
  /var/tmp/*
rm setup.sh
