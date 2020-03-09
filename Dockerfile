FROM ubuntu:19.04

ADD setup.sh .
RUN mkdir -p /data /workspace/pollination
RUN /bin/bash setup.sh
ADD run-pollination.py /data
ENTRYPOINT [ "python3", "/data/run-pollination.py" ]
