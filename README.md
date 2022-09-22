# Azure Pipelines Agent Docker Image

This repository contains `Dockerfile` definitions for
[lambda3/azure-pipelines-agent](https://github.com/lambda3/docker-azure-pipelines-agent).

This project allows the Azure Pipelines Agent to run on Docker or Kubernetes
(with Helm).

[![Downloads from Docker Hub](https://img.shields.io/docker/pulls/lambda3/azure-pipelines-agent.svg)](https://registry.hub.docker.com/u/lambda3/azure-pipelines-agent)
[![Build](https://github.com/lambda3/docker-azure-pipelines-agent/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/Lambda3/docker-azure-pipelines-agent/actions/workflows/build.yml)

## Supported tags

* [`latest` (*agent/Dockerfile*)](https://github.com/lambda3/docker-azure-pipelines-agent/blob/main/agent/Dockerfile)
* [`docker` (*agent-docker/Dockerfile*)](https://github.com/lambda3/docker-azure-pipelines-agent/blob/main/agent-docker/Dockerfile)

## Configuration

For `latest`, you need to set these environment variables:

* `AGENT_PAT` - The personal access token from Azure Pipelines. Required. See
  [Microsoft Docs](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux?view=azure-devops#authenticate-with-a-personal-access-token-pat) for instructions on how to create the PAT.
* `VS_TENANT` - The Azure Pipelines tenant, a.k.a. the value that goes before .visualstudio.com, i.e., on foo.visualstudio.com, should be `foo`. Required.
* `AGENT_POOL` - The agent pool. Optional. Default value: `Default`

For `docker`, you may have a predefined login using these additional variables,
(but you should avoid it, see the disclaimer after the variables):

* `DOCKER_USERNAME` - Your docker user name. Optional, no default.
* `DOCKER_PASSWORD` - Your docker password. Optional, no default.
* `DOCKER_SERVER` - Your docker registries, defaults to Docker's default public
  registry. Optional.

If you do not specify the Docker username and password the agent will not login.

**Disclaimer**: Setting the above variables will connect the agent permanently
to a docker registry. Instead, you should use the
[Docker Task](https://docs.microsoft.com/azure/devops/pipelines/tasks/build/docker)
and with a
[Docker registry service connection](https://docs.microsoft.com/azure/devops/pipelines/library/service-endpoints#sep-docreg)
provide the authentication. This will enable the agent to work with multiple
registries and lower the risk of attack.

## Running

### Which tag you should use

* Use `latest` if you want to run the latest agent
* Use the agent tag version, for example `2.154.3`, to run an specific
version, but old agents will usually auto update.
* Use `docker` if you want to the agent to use the host's Docker engine
* Use the agent tag version plus `-docker`, for example `2.154.3-docker`, to
run an specific version, but old agents will usually auto update.

Avoid the `docker` tags, prefer to host the Docker engine on a separate host.

### Kubernetes with Helm Chart

See [the chart readme](https://github.com/Lambda3/helmcharts/blob/main/charts/azure-pipelines-agent/README.md).

### Docker

On Linux or on a Mac (using Docker for Mac), using bash, set the variables:

````bash
export VS_TENANT=<nameofyourtenant>
export AGENT_PAT=<yourpat>
````

Then run:

````bash
docker run --name azure-pipelines-agent -ti -e VS_TENANT=$VS_TENANT -e AGENT_PAT=$AGENT_PAT -d -v /agent/_works:/agent/_works lambda3/azure-pipelines-agent:latest
````

On Windows (using Docker for Windows), using PowerShell, set the variables:

````powershell
$env:VS_TENANT=<nameofyourtenant>
$env:AGENT_PAT=<yourpat>
````

Then run:

````powershell
docker run --name azure-pipelines-agent -ti -e VS_TENANT=$env:VS_TENANT -e AGENT_PAT=$env:AGENT_PAT -d lambda3/azure-pipelines-agent:latest
````

**Important**: If you build using Docker containers, be careful with volume mounts, as they
will be mounted on the Docker host, not on the agent's file system. For the
agent to work as expected mount `/agent/_works` from the host to the agent
container, adding to docker run `-v /agent/_works:/agent/_works`.
This will keep the agent staging directory (and other work directories)
persistent across agent restarts. Also, it is recommended that you mount to a
directory that is relative to this directory, like the staging directory, so
when it is mounted on the host, it is also available for the agent.

#### With Docker support

Again, this is not recommended, see the docs before to learn why. You will use
the `docker` tag.

On Linux or on a Mac (using Docker for Mac), using bash, set the variables:

````bash
export VS_TENANT=<nameofyourtenant>
export AGENT_PAT=<yourpat>
export DOCKER_USERNAME=<yourdockerusername>
export DOCKER_PASSWORD=<yourdockerpassword>
export DOCKER_SERVER=<dockerserver>
````

Then run:

````bash
docker run --name azure-pipelines-agent -ti -e VS_TENANT=$VS_TENANT -e AGENT_PAT=$AGENT_PAT -e DOCKER_USERNAME=$DOCKER_USERNAME -e DOCKER_PASSWORD=$DOCKER_PASSWORD -e DOCKER_SERVER=$DOCKER_SERVER -d --volume=/var/run/docker.sock:/var/run/docker.sock -v /agent/_works:/agent/_works lambda3/azure-pipelines-agent:docker
````

On Windows (using Docker for Windows), using PowerShell, set the variables:

````powershell
$env:VS_TENANT=<nameofyourtenant>
$env:AGENT_PAT=<yourpat>
$env:DOCKER_USERNAME=<yourdockerusername>
$env:DOCKER_PASSWORD=<yourdockerpassword>
$env:DOCKER_SERVER=<dockerserver>
````

Then run:

````powershell
docker run --name azure-pipelines-agent -ti -e VS_TENANT=$env:VS_TENANT -e AGENT_PAT=$env:AGENT_PAT -e DOCKER_USERNAME=$env:DOCKER_USERNAME -e DOCKER_PASSWORD=$env:DOCKER_PASSWORD -e DOCKER_SERVER=$env:DOCKER_SERVER -d --volume=/var/run/docker.sock:/var/run/docker.sock lambda3/azure-pipelines-agent:docker
````

## Software installed

Based on the latest LTS Ubuntu image, with the following added packages:

* apt-transport-https
* build-essential
* curl
* gdebi-core
* git
* iproute2
* iputils-ping
* libicu60
* libssl-dev
* libunwind8
* libuuid1
* python
* python-pip
* python3
* python3-pip
* software-properties-common
* sudo
* unzip
* vim
* wget
* zip

Plus:

* .NET Core (current and latest LTS)
* Azure CLI
* PowerShell Core (pwsh - latest stable)
* Node (latest LTS) and nvm, Npm and Yarn
* Google Chrome
* kubectl
* Helm CLI
* Terraform CLI
* Openjdk (latest LTS)
* Docker CLI
* docker-compose

See the
[Dockerfile](https://github.com/lambda3/docker-azure-pipelines-agent/blob/main/agent/Dockerfile)
for more information.

## Maintainers

* [Giovanni Bassi](http://blog.lambda3.com.br/L3/giovannibassi/), aka Giggio, [Lambda3](http://www.lambda3.com.br), [@giovannibassi](https://twitter.com/giovannibassi)

## License

This software is open source, licensed under the Apache License, Version 2.0.
See [LICENSE.txt](https://github.com/lambda3/azure-pipelines-agent/blob/main/LICENSE.txt) for details.
Check out the terms of the license before you contribute, fork, copy or do anything
with the code. If you decide to contribute you agree to grant copyright of all your contribution to this project, and agree to
mention clearly if do not agree to these terms. Your work will be licensed with the project at Apache V2, along the rest of the code.
