# Running the image

The image contains all the data it needs to run the pollination model, we just want to mount a volume so we can get the results.
```bash
mkdir /tmp/output
docker run \
 --rm \
 -v /tmp/output:/workspace \
 tomsaleeba/natcap-invest-docker:3.4.2-pollination # there isn't much output, it takes less than 30 seconds to run usually
sudo chown -R `id -u` /tmp/output
# now browse to /tmp/output to see the output files
```

# Building the image

The build is fully automated and will download everything it needs.
```bash
cd natcap-invest-docker/3.4.2
./docker-build.sh
# see above for how to run it
```
