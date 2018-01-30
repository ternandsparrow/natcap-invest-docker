# Running the image

The image contains all the data it needs to run the pollination model, we just want to mount a volume so we can get the results.
```bash
mkdir /tmp/output
docker run --rm -v /tmp/output:/workspace invest:3.3.3-pollination
chown -R `id -u` /tmp/output
# now browse to /tmp/output to see the output files
```

# Building the image

The build is fully automated and will download everything it needs.
```bash
cd natcap-invest-docker/3.3.3
./docker-build.sh
# see above for how to run it
```
