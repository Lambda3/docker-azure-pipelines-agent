VSTS Agent Docker Image
====================

This repository contains `Dockerfile` definitions for [giggio/vsts-agent](https://github.com/giggio/docker-vsts-agent) Docker images.

[![Downloads from Docker Hub](https://img.shields.io/docker/pulls/giggio/vsts-agent.svg)](https://registry.hub.docker.com/u/giggio/vsts-agent)
[![Stars on Docker Hub](https://img.shields.io/docker/stars/giggio/vsts-agent.svg)](https://registry.hub.docker.com/u/giggio/vsts-agent)

## Supported tags

- [`latest` (*agent/Dockerfile*)](https://github.com/giggio/docker-vsts-agent/blob/master/agent/Dockerfile)
- [`docker` (*agent-docker/Dockerfile*)](https://github.com/giggio/docker-vsts-agent/blob/master/agent-docker/Dockerfile)

## Configuration

For `latest`, you need to set these environment variables:
* `AGENT_PAT` - The personal access token from VSTS. Required.
* `VS_TENANT` - The VSTS tenant, a.k.a. the value that goes before .visualstudio.com, i.e., on foo.visualstudio.com, should be `foo`. Required.
* `AGENT_POOL` - The agent pool. Optional. Default value: `Default`

For `docker`, you need to set these additional variables:
* `DOCKER_USERNAME` - Your docker user name. Required.
* `DOCKER_PASSWORD` - Your docker password. Required.

## Running

On Windows, use Docker for Windows and run, on PowerShell:

````powershell
docker run --name vsts-agent -ti -e VS_TENANT=$env:VS_TENANT -e AGENT_PAT=$env:AGENT_PAT -e DOCKER_USERNAME=$env:DOCKER_USERNAME -e DOCKER_PASSWORD=$env:DOCKER_PASSWORD --rm --volume=/var/run/docker.sock:/var/run/docker.sock giggio/vsts-agent:docker
````

On a Mac, use Docker for Mac, or directy on Linux, run in bash:

````bash
docker run --name vsts-agent -ti -e VS_TENANT=$env:VS_TENANT -e AGENT_PAT=$AGENT_PAT -e DOCKER_USERNAME=$DOCKER_USERNAME -e DOCKER_PASSWORD=$DOCKER_PASSWORD --rm --volume=/var/run/docker.sock:/var/run/docker.sock giggio/vsts-agent:docker
````

## Maintainers

* [Giovanni Bassi](http://blog.lambda3.com.br/L3/giovannibassi/), aka Giggio, [Lambda3](http://www.lambda3.com.br), [@giovannibassi](https://twitter.com/giovannibassi)

## License

This software is open source, licensed under the Apache License, Version 2.0.
See [LICENSE.txt](https://github.com/giggio/vsts-agent/blob/master/LICENSE.txt) for details.
Check out the terms of the license before you contribute, fork, copy or do anything
with the code. If you decide to contribute you agree to grant copyright of all your contribution to this project, and agree to
mention clearly if do not agree to these terms. Your work will be licensed with the project at Apache V2, along the rest of the code.
