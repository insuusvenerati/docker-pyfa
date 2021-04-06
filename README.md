# Pyfa in Docker

Run Pyfa(Python fitting Assistant) from a docker container on any system with X11

- [Pyfa in Docker](#pyfa-in-docker)
  - [Get started](#get-started)
    - [Install necessary dependencies](#install-necessary-dependencies)
      - [Get Docker](#get-docker)
    - [Build the image](#build-the-image)
    - [Run the container](#run-the-container)

## Get started

> Examples are for Ubuntu 20.04

### Install necessary dependencies

#### Get Docker

```bash
curl -fsSL https://get.docker.com | sudo sh
```

### Build the image

```bash
docker build -t pyfa .
```

### Run the container

```bash
docker run -it --rm -e DISPLAY=$DISPLAY -v data:/home/pyfa -v /tmp/.X11-unix:/tmp/.X11-unix stiforr/pyfa
```
