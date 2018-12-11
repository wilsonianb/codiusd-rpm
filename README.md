# codiusd rpm

Docker image for building codiusd rpm

The docker container builds a codiusd rpm from the specified npm package version and outputs to a mounted directory.

## Dependencies

- [docker](https://docs.docker.com/install/)

## Configuration

All configuration is performed via environment variables:

- CODIUSD_VERSION: codiusd version number (default: latest published)
- CODIUSD_RELEASE: rpm release number     (default: 1)

## Build

```
docker build -t codiusd-rpm .
```

## Run

```
docker run --cap-add=SYS_ADMIN --rm -v <path-to-out-dir>:/opt/codiusd/out codiusd-rpm
```

The container must run with `SYS_ADMIN` in order to build the rpm with [Mock](https://github.com/rpm-software-management/mock/wiki#mock-inside-docker).

On Ubuntu, `--security-opt apparmor:unconfined` may also be required.
