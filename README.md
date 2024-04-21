# Snell Server

[![Build Status](https://github.com/funnyzak/snell-server-docker/actions/workflows/docker_build.yml/badge.svg)](https://github.com/funnyzak/snell-server-docker/actions)
[![Image Size](https://img.shields.io/docker/image-size/funnyzak/snell-server)](https://hub.docker.com/r/funnyzak/snell-server/)
[![Docker Stars](https://img.shields.io/docker/stars/funnyzak/snell-server.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/snell-server/)
[![Docker Pulls](https://img.shields.io/docker/pulls/funnyzak/snell-server.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/snell-server/)
[![Docker Tags](https://img.shields.io/docker/v/funnyzak/snell-server?sort=semver&style=flat-square)](https://hub.docker.com/r/funnyzak/snell-server/)

 This image is built for [snell server](https://manual.nssurge.com/others/snell.html), which is a lean encrypted proxy protocol. If you want to use **Snell Client**, please download from [NSSurge](https://nssurge.com/).

This image supports `linux/amd64`, `linux/arm64`, `linux/arm/v7` and `linux/386` architecture.

> The latest surge-server version is v4, which is not compatible with the previous versions like before. Please upgrade both the client (Surge iOS & Surge Mac) and the server binary.

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
docker exec -it snell cat /app/snell-server.conf
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
