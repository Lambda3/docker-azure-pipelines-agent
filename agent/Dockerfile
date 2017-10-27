FROM ubuntu:16.04
RUN apt-get update && \
    apt-get install -y software-properties-common curl unzip vim apt-transport-https libunwind8 libcurl3 sudo iputils-ping && \
    apt-add-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git
RUN echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list && \
    apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 && \
    apt-get update && \
    apt-get install dotnet-dev-1.0.0-preview2-003121 -y
RUN adduser --disabled-password --gecos '' agentuser && \
    adduser agentuser sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# az cli:
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
    tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893 && \
    apt-get update && \
    apt-get install -y azure-cli
# pwsh:
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/microsoft.list && \
    apt-get update && \
    apt-get install -y powershell
RUN mkdir /agent
RUN chown -R agentuser:agentuser /agent
USER agentuser
WORKDIR /agent
RUN curl -sOSL https://github.com/Microsoft/vsts-agent/releases/download/v2.124.0/vsts-agent-ubuntu.16.04-x64-2.124.0.tar.gz && \
    tar xzf /agent/vsts-agent-ubuntu.16.04-x64-2.124.0.tar.gz && \
    rm /agent/vsts-agent-ubuntu.16.04-x64-2.124.0.tar.gz
COPY configureAgent.sh runAgent.sh configureAndRun.sh /agent/
USER root
RUN chmod +x configureAndRun.sh configureAgent.sh runAgent.sh && \
    chown agentuser:agentuser configureAgent.sh runAgent.sh configureAndRun.sh
USER agentuser
CMD [ "/agent/configureAndRun.sh" ]
