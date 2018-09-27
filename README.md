VSTS Agent Docker Image
====================

This repository contains `Dockerfile` definitions for [lambda3/vsts-agent](https://github.com/lambda3/docker-vsts-agent) Docker images.

[![Downloads from Docker Hub](https://img.shields.io/docker/pulls/lambda3/vsts-agent.svg)](https://registry.hub.docker.com/u/lambda3/vsts-agent)
[![Stars on Docker Hub](https://img.shields.io/docker/stars/lambda3/vsts-agent.svg)](https://registry.hub.docker.com/u/lambda3/vsts-agent) [![](https://images.microbadger.com/badges/image/lambda3/vsts-agent.svg)](https://microbadger.com/images/lambda3/vsts-agent "Get your own image badge on microbadger.com")

## Supported tags

- [`latest` (*agent/Dockerfile*)](https://github.com/lambda3/docker-vsts-agent/blob/master/agent/Dockerfile)
- [`docker` (*agent-docker/Dockerfile*)](https://github.com/lambda3/docker-vsts-agent/blob/master/agent-docker/Dockerfile)

## Configuration

For `latest`, you need to set these environment variables:

* `AGENT_PAT` - The personal access token from VSTS. Required.
* `VS_TENANT` - The VSTS tenant, a.k.a. the value that goes before .visualstudio.com, i.e., on foo.visualstudio.com, should be `foo`. Required.
* `AGENT_POOL` - The agent pool. Optional. Default value: `Default`

For `docker`, you need to set these additional variables:
* `DOCKER_USERNAME` - Your docker user name. Optional, no default.
* `DOCKER_PASSWORD` - Your docker password. Optional, no default.
* `DOCKER_SERVER` - Your docker registries, defaults to Docker's default public
  registry. Optional.

If you do not specify the Docker username and password the agent will not login.

## Running

On Windows, use Docker for Windows and run, on PowerShell:

````powershell
docker run --name vsts-agent -ti -e VS_TENANT=$env:VS_TENANT -e AGENT_PAT=$env:AGENT_PAT -e DOCKER_USERNAME=$env:DOCKER_USERNAME -e DOCKER_PASSWORD=$env:DOCKER_PASSWORD -e DOCKER_SERVER=$env:DOCKER_SERVER --rm --volume=/var/run/docker.sock:/var/run/docker.sock lambda3/vsts-agent:docker
````

On a Mac, use Docker for Mac, or directy on Linux, run in bash:

````bash
docker run --name vsts-agent -ti -e VS_TENANT=$VS_TENANT -e AGENT_PAT=$AGENT_PAT -e DOCKER_USERNAME=$DOCKER_USERNAME -e DOCKER_PASSWORD=$DOCKER_PASSWORD -e DOCKER_SERVER=$DOCKER_SERVER --rm --volume=/var/run/docker.sock:/var/run/docker.sock lambda3/vsts-agent:docker
````

If you build using Docker containers, be careful with volume mounts, as they
will be mounted on the Docker host, not on the agent's file system. For that to
work as expected mount `/agent/_works` from the host to the agent container,
adding to docker run `-v /agent/_works:/agent/_works`, like so:

````bash
docker run --name vsts-agent -ti -e VS_TENANT=$VS_TENANT -e AGENT_PAT=$AGENT_PAT -e DOCKER_USERNAME=$DOCKER_USERNAME -e DOCKER_PASSWORD=$DOCKER_PASSWORD -e DOCKER_SERVER=$DOCKER_SERVER --rm --volume=/var/run/docker.sock:/var/run/docker.sock -v /agent/_works:/agent/_works lambda3/vsts-agent:docker
````

## Maintainers

* [Giovanni Bassi](http://blog.lambda3.com.br/L3/giovannibassi/), aka Giggio, [Lambda3](http://www.lambda3.com.br), [@giovannibassi](https://twitter.com/giovannibassi)

## License

This software is open source, licensed under the Apache License, Version 2.0.
See [LICENSE.txt](https://github.com/lambda3/vsts-agent/blob/master/LICENSE.txt) for details.
Check out the terms of the license before you contribute, fork, copy or do anything
with the code. If you decide to contribute you agree to grant copyright of all your contribution to this project, and agree to
mention clearly if do not agree to these terms. Your work will be licensed with the project at Apache V2, along the rest of the code.
