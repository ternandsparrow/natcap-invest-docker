#!/usr/bin/env bash
cd `dirname "$0"`
set -e
invest_version=3.4.2
data=data
mkdir -p $data

poll_dir=$data/pollination
if [ ! -d "$poll_dir" ]; then
  pushd $data
  poll_zip=pollination.zip
  if [ ! -f "$poll_zip" ]; then
    wget -O $poll_zip "http://data.naturalcapitalproject.org/invest-data/$invest_version/pollination.zip"
  fi
  unzip $poll_zip
  rm $poll_zip
  popd
fi

docker build \
 -t invest:$invest_version-pollination \
 --build-arg investversion=$invest_version \
 .
