FROM ubuntu:16.04

ARG investversion
ADD setup.sh .
RUN mkdir -p /data /workspace/pollination
ADD data /data
ADD run-pollination.py /data
RUN /bin/bash setup.sh ${investversion}
ENTRYPOINT [ "python", "/data/run-pollination.py" ]
