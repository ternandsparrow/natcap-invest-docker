This repo is a docker wrapper around NatCap's InVEST: https://bitbucket.org/natcap/invest.

Currently the focus is on running the pollination model but it could easily be adapted to run any of the other models.

## Running the image

The image contains all the data it needs to run the pollination model, we just want to mount a volume so we can get the results.
```bash
mkdir /tmp/output
docker run \
 --rm \
 -v /tmp/output:/workspace \
 tomsaleeba/natcap-invest-docker:3.4.2-pollination # there isn't much console output and it takes less than 30 seconds to run usually
sudo chown -R `id -u` /tmp/output
# now browse to /tmp/output to see the output files
```

## Building the image locally

The build is fully automated and will download everything it needs.
```bash
cd natcap-invest-docker/
./docker-build.sh
# see above for how to run it
```
