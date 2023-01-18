FROM tensorflow/tensorflow:latest-gpu
LABEL version=v0.0.5

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

ENV DEBCONF_NOWARNINGS="yes"
ARG DEBIAN_FRONTEND=noninteractive

#WORKDIR /opt/depot_tools
RUN apt-get update &>/dev/null 
RUN apt-key adv --keyserver keyserver.ubuntu.com \
--recv-keys A4B469963BF863CC &>/dev/null

RUN apt-get install -y --no-install-recommends apt-utils autoconf \
automake build-essential curl gcc git gfortran libopenblas-dev \
ffmpeg libsm6 libxext6 python3 python3.8 python3-pip \
python3.8-dev python3.8-venv wget &>/dev/null

RUN python3.8 -m venv /maps
RUN source activate
ADD . /maps

ENV GIT_DISCOVERY_ACROSS_FILESYSTEM=1
ENV PATH="/maps:/maps/bin:/opt/depot_tools:${PATH}"

RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git . \
    && gclient

ENTRYPOINT [ "gclient" ]
#ENTRYPOINT ["entrypoint.sh"]
