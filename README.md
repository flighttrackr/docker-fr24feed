# fr24feed

[![Release](https://github.com/flighttrackr/docker-fr24feed/actions/workflows/release.yml/badge.svg)](https://github.com/flighttrackr/docker-fr24feed/actions/workflows/release.yml)

This project makes [flightradar24]'s [fr24feed] software available as a Docker image.

Due to the API limitations of Docker Hub, we use GitHub as container image registry.

## Other projects

We have other Flighttracking projects, check our [GitHub profile].

## Supported architectures

- linux/amd64
- linux/arm/v6
- linux/arm/v7
- linux/arm64
- linux/386

## Run container

```shell
docker run \
  -it --rm \
  ghcr.io/flighttrackr/fr24feed:latest
```

## Environment variables

| Environment variable | Default | Description |
| :- | :- | :- |
| SHARING_KEY | | Flightradar24 sharing key |
| DUMP1090_HOST | dump1090:30002 | dump1090/readsb Host:Port |
| RECEIVER | avr-tcp | Receiver type |
| BS | no | BS |
| RAW | no | RAW |
| LOGMODE | 0 | Logging mode |
| WINDOWMODE | 0 | Window mode |
| MPX | no | MPX |
| MLAT | yes | MLAT |
| MLAT_WITHOUT_GPS | yes | MLAT without GPS |


[flightradar24]: https://www.flightradar24.com/
[fr24feed]: https://www.flightradar24.com/share-your-data
[GitHub profile]: https://github.com/flighttrackr
[entrypoint.sh]: ./entrypoint.sh
[Dockerfile]: ./Dockerfile
