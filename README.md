This repo is a docker wrapper around NatCap's InVEST: https://bitbucket.org/natcap/invest.

Currently the focus is on running the pollination model but it could easily be adapted to run any of the other models.

## Running the image

We use a version scheme for GitHub and DockerHub tags: `{our version}_{InVEST version}`, for example `1.0.0_3.4.2`.
Check DockerHub for the latest tag.

The image contains all the data it needs to run the pollination model, we just want to mount a volume so we can get the results on the host.
```bash
mkdir /tmp/output
docker run \
 --rm \
 -it \
 -v /tmp/output:/workspace \
 ternandsparrow/natcap-invest-docker:1.0.1_3.4.2 # it takes less than 30 seconds to run usually

sudo chown -R `id -u` /tmp/output
# now browse to /tmp/output to see the output files
```
We use the `-it` flag so we get log output in a timely manner. You can leave it out but the log messages don't seem to be flushed until the end of the run.

## Building the image locally

The build is fully automated and will download everything it needs.
```bash
cd natcap-invest-docker/
docker build \
  -t ternandsparrow/natcap-invest-docker:1.0.1_3.4.2 \
  .
# see above for how to run it
```
