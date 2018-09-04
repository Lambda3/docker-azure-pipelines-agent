FROM ubuntu:18.04
# basics:
RUN apt-get update && \
    apt-get install -y iproute2 libuuid1 libicu60 software-properties-common curl unzip vim apt-transport-https \
    libunwind8 sudo iputils-ping wget && \
    apt-add-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git && \
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb
# netcore
RUN apt-get update && apt-get install -y dotnet-sdk-2.1
ENV PATH="${PATH}:/root/.dotnet/tools"
# az cli:
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/azure-cli.list && \
    curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y azure-cli
# pwsh:
RUN apt-get install -y powershell-preview && ln /usr/bin/pwsh-preview /usr/bin/pwsh
# nvm/node:
RUN apt-get install -y build-essential libssl-dev
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN [ "/bin/bash", "-c", "source $HOME/.nvm/nvm.sh && nvm i 10" ]
RUN [ "/bin/bash", "-c", "source $HOME/.nvm/nvm.sh && nvm alias default 10" ]
WORKDIR /agent
# agent:
RUN curl -sOSL https://vstsagentpackage.azureedge.net/agent/2.139.1/vsts-agent-linux-x64-2.139.1.tar.gz && \
    tar xzf /agent/vsts-agent-linux-x64-2.139.1.tar.gz && \
    rm /agent/vsts-agent-linux-x64-2.139.1.tar.gz
COPY configureAgent.sh runAgent.sh configureAndRun.sh /agent/
RUN chmod +x configureAndRun.sh configureAgent.sh runAgent.sh
CMD [ "/agent/configureAndRun.sh" ]