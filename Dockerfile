FROM python:3.7-slim-buster as builder

# COPY . /opt/app

# Expose USER as env var and a build arg so it matches what's used during docker build with docker run
ARG USER=pyfa
ENV USER=pyfa

ENV LANG=C.UTF-8
ENV VIRTUAL_ENV=/opt/app/PyfaEnv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV PYTHONDONTWRITEBYTECODE=1
# Seems to speed things up
ENV PYTHONUNBUFFERED=1

RUN apt-get update \
	&& useradd -m ${USER} \
	&& apt-get install -y gnupg2

RUN echo "deb http://cz.archive.ubuntu.com/ubuntu xenial main universe" >> /etc/apt/sources.list

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 40976EAF437D05B5 \
	&& apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 3B4FE6ACC0B21F32 \
	&& apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y make gcc libgtk-3-dev libwebkitgtk-3.0-dev wget \
	libgstreamer-gl1.0-0 freeglut3 freeglut3-dev  python3-gst-1.0 libglib2.0-dev \
	libgstreamer-plugins-base1.0-dev libsdl1.2-dev libnotify-dev firefox xdg-utils git \
	&& rm -rf /var/cache/apt/lists

RUN git clone https://github.com/pyfa-org/Pyfa /opt/app \
	&& rm -rf /opt/app/.git

WORKDIR /opt/app

RUN wget http://security.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8_2.0.3-0ubuntu2_amd64.deb -O libjpeg.deb \
	&& dpkg -i libjpeg.deb \
	&& wget https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-18.04/wxPython-4.0.6-cp37-cp37m-linux_x86_64.whl \
	&& python3 -m venv ${VIRTUAL_ENV} \
	&& chmod +x ./PyfaEnv/bin/activate \
	&& ./PyfaEnv/bin/activate \
	&& pip install wxPython-4.0.6-cp37-cp37m-linux_x86_64.whl \
	&& pip install pathlib2 \
	&& pip install --no-cache-dir -r requirements.txt \
	&& rm libjpeg.deb wxPython-4.0.6-cp37-cp37m-linux_x86_64.whl \
	&& chown -R ${USER}:${USER} /opt/app

USER ${USER}

VOLUME [ "/home/${USER}" ]

ENTRYPOINT [ "python3", "pyfa.py" ]
