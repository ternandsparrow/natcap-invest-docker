#!/usr/bin/env bash
cd `dirname "$0"`
set -e
invest_version=3.3.3
data=data
mkdir -p $data

base_dir=$data/Base_Data
if [ ! -d "$base_dir" ]; then
  pushd $data
  base_zip=Base_Data.zip
  if [ ! -f "$base_zip" ]; then
    wget -O $base_zip "http://data.naturalcapitalproject.org/invest-data/Base_Data"
  fi
  unzip $base_zip 'Base_Data/Terrestrial/lulc_samp_cur/*' # only need some of it
  rm $base_zip
  popd
fi

poll_dir=$data/Pollination
if [ ! -d "$poll_dir" ]; then
  pushd $data
  poll_zip=Pollination.zip
  if [ ! -f "$poll_zip" ]; then
    wget -O $poll_zip "http://data.naturalcapitalproject.org/invest-data/$invest_version/Pollination.zip"
  fi
  unzip $poll_zip
  rm $poll_zip
  popd
fi

rm -rf $data/__MACOSX

docker build \
 -t invest:$invest_version-pollination \
 --build-arg investversion=$invest_version \
 .
