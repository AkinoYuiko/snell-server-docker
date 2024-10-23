# Snell Server

[![Build Status](https://github.com/AkinoYuiko/snell-server-docker/actions/workflows/docker_build.yaml/badge.svg)](https://github.com/AkinoYuiko/snell-server-docker/actions)
[![Image Size](https://img.shields.io/docker/image-size/angribot/snell)](https://hub.docker.com/r/angribot/snell/)
[![Docker Stars](https://img.shields.io/docker/stars/angribot/snell.svg?style=flat-square)](https://hub.docker.com/r/angribot/snell/)
[![Docker Pulls](https://img.shields.io/docker/pulls/angribot/snell.svg?style=flat-square)](https://hub.docker.com/r/angribot/snell/)
[![Docker Tags](https://img.shields.io/docker/v/angribot/snell?sort=semver&style=flat-square)](https://hub.docker.com/r/angribot/snell/)

A minimal Snell Server docker image. If you want to use **Snell Client**, please download from [NSSurge](https://nssurge.com/).

This image supports `linux/amd64` and `linux/arm64` architecture.

> The latest surge-server version is v4, which is not compatible with the previous versions like before. Please upgrade both the client (Surge iOS & Surge Mac) and the server binary.

**Notice**: obfs is NOT supported!

## Docker Pull

`docker pull angribot/snell:latest`

## Docker Run

Your can run this image with the following command:

```bash
# One line command
docker run -d --name snell --restart always -p 12303:6250 -e PSK="5G0H4qdf32mEZx32t" angribot/snell

# Or with environment variables
docker run -d --name snell --restart always \
  -e PSK="5G0H4qdf32mEZx32t" \
  -p 12303:6250 angribot/snell:latest

# Echo config file
docker exec -it snell cat /root/snell-server.conf
```

Or you can use docker-compose to run this image:

```yaml
services:
  snell:
    image: angribot/snell
    container_name: snell
    environment:
      PSK: 5G0H4qdf32mEZx32t
    restart: always
    ports:
      - 12345:6250
```

## Reference

- [Snell Server](https://manual.nssurge.com/others/snell.html)

## License

[MIT](LICENSE)
