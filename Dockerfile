FROM python:3.9.2-slim-buster

# COPY . /opt/app
RUN git clone https://github.com/pyfa-org/Pyfa /opt/app
WORKDIR /opt/app

# Expose USER as env var and a build arg so it matches what's used during docker build with docker run
ARG USER=pyfa
ENV USER=pyfa

RUN useradd -m ${USER}

RUN echo "deb http://cz.archive.ubuntu.com/ubuntu xenial main universe" >> /etc/apt/sources.list

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 40976EAF437D05B5 \
  && apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 3B4FE6ACC0B21F32

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y make gcc libgtk-3-dev libwebkitgtk-3.0-dev \
  libgstreamer-gl1.0-0 freeglut3 freeglut3-dev  python3-gst-1.0 libglib2.0-dev \
  libgstreamer-plugins-base1.0-dev libsdl1.2-dev libnotify-dev firefox xdg-utils

RUN wget http://security.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8_2.0.3-0ubuntu2_amd64.deb -O libjpeg.deb \
  && dpkg -i libjpeg.deb

RUN wget https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-18.04/wxPython-4.0.6-cp37-cp37m-linux_x86_64.whl \
  && pip install wxPython-4.0.6-cp37-cp37m-linux_x86_64.whl

RUN pip install pathlib2 \
  && pip install -r requirements.txt

RUN chown -R ${USER}:${USER} /opt/app

VOLUME [ "/home/${USER}" ]

USER ${USER}
ENTRYPOINT [ "python3", "pyfa.py" ]