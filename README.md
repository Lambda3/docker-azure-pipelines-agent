# Azure Pipelines Agent Docker Image

This repository contains `Dockerfile` definitions for
[lambda3/azure-pipelines-agent](https://github.com/lambda3/docker-azure-pipelines-agent).

This project allows the Azure Pipelines Agent to run on Docker or Kubernetes
(with Helm).

[![Downloads from Docker Hub](https://img.shields.io/docker/pulls/lambda3/azure-pipelines-agent.svg)](https://registry.hub.docker.com/u/lambda3/azure-pipelines-agent)
[![Build](https://github.com/lambda3/docker-azure-pipelines-agent/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/Lambda3/docker-azure-pipelines-agent/actions/workflows/build.yml)

## Supported tags

* [`latest` (*agent/Dockerfile*)](https://github.com/lambda3/docker-azure-pipelines-agent/blob/main/agent/Dockerfile)

### Other tags

- For a specific git tag (tag `1.2.3` in this example): `lambda3/azure-pipelines-agent:1.2.3`
- For a specific commit (only commits on `main` get tagged and pushed): `lambda3/azure-pipelines-agent:95aeca1`
- For the current `main` branch: `lambda3/azure-pipelines-agent:main`

## Configuration

For `latest`, you need to set these environment variables:

* `AGENT_PAT` - The personal access token from Azure Pipelines. Required. See
  [Microsoft Docs](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux?view=azure-devops#authenticate-with-a-personal-access-token-pat) for instructions on how to create the PAT.
* `VS_TENANT` - The Azure Pipelines tenant, a.k.a. the value that goes before .visualstudio.com, i.e., on foo.visualstudio.com, should be `foo`. Required.
* `AGENT_POOL` - The agent pool. Optional. Default value: `Default`

## Running

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
