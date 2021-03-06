# Pyfa in Docker

Run Pyfa(Python fitting Assistant) from a docker container on any system with X11

- [Pyfa in Docker](#pyfa-in-docker)
  - [Get started](#get-started)
    - [Install necessary dependencies](#install-necessary-dependencies)
      - [Get Docker](#get-docker)
    - [Clone the repo and Build the image](#clone-the-repo-and-build-the-image)
    - [Bootstrap the pyfa container](#bootstrap-the-pyfa-container)
    - [Launch Pyfa](#launch-pyfa)
    - [Known issues](#known-issues)

## Get started

> Examples are for Ubuntu 20.04

### Install necessary dependencies

#### Get Docker

```bash
curl -fsSL https://get.docker.com | sudo sh
```

### Clone the repo and Build the image

```bash
git clone insuusvenerati/docker-pyfa
docker build -t pyfa .
```

or pull and tag my image

```bash
docker pull stiforr/pyfa
docker tag stiforr/pyfa pyfa
```

### Bootstrap the pyfa container

```bash
./scripts/create-container
```

> This will create a container named pyfa and leave it running until you exit but will not remove the container.

### Launch Pyfa

```bash
sudo cp scripts/pyfa /usr/local/bin/pyfa
pyfa
```

### Known issues

- There is a warning about not being able to set locale.
- This thing eats up a ton of space because it's building from source. Any suggestions on optimization are appreciated.
