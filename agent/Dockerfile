FROM ubuntu:18.04
HEALTHCHECK --interval=1m --timeout=2s CMD ps aux | grep --color=never [A]gent.Listener
# basics:
RUN apt-get update && \
    apt-get install -y software-properties-common apt-transport-https && \
    apt-get upgrade -y && \
    apt-add-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git iproute2 libuuid1 libicu60 wget curl zip unzip \
    vim  libunwind8 sudo iputils-ping gdebi-core python python-pip python3 python3-pip \
    build-essential libssl-dev
#users
RUN adduser --disabled-password --gecos '' agentuser && \
    adduser agentuser sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir /agent
WORKDIR /agent
# Microsoft keys:
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb
# netcore
RUN apt-get update && apt-get install -y dotnet-sdk-2.1 dotnet-sdk-3.0 dotnet-sdk-3.1
ENV PATH="${PATH}:/home/agentuser/.dotnet/tools"
# az cli:
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/azure-cli.list && \
    curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y azure-cli
# pwsh:
RUN apt-get install -y powershell
# openjdk
RUN apt-get install -y default-jdk
# cleanup
RUN apt-get autoremove -y
# agent:
RUN curl -fSsL https://vstsagentpackage.azureedge.net/agent/2.188.3/vsts-agent-linux-x64-2.188.3.tar.gz -o /agent/vsts-agent.tar.gz && \
    tar xzf /agent/vsts-agent.tar.gz && \
    rm /agent/vsts-agent.tar.gz
COPY configureAgent.sh runAgent.sh configureAndRun.sh /agent/
RUN chmod +x configureAndRun.sh configureAgent.sh runAgent.sh && \
    chown agentuser:agentuser configureAgent.sh runAgent.sh configureAndRun.sh
RUN chown -R agentuser:agentuser /agent
USER agentuser
STOPSIGNAL SIGINT
CMD [ "/agent/configureAndRun.sh" ]