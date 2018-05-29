FROM ubuntu:18.04
RUN apt-get update && \
    apt-get install -y libuuid1 libicu60 software-properties-common curl unzip vim apt-transport-https \
    libunwind8 sudo iputils-ping wget && \
    apt-add-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git
# netcore
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
    mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/prod.list && \
    mv prod.list /etc/apt/sources.list.d/microsoft-prod.list && \
    apt-get update && \
    apt-get install -y dotnet-sdk-2.1.200
# az cli:
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/azure-cli.list && \
    curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y azure-cli
# pwsh:
RUN curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v6.0.2/powershell-6.0.2-linux-x64.tar.gz && \
    mkdir -p /opt/microsoft/powershell/6.0.2 && \
    tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/6.0.2 && \
    rm /tmp/powershell.tar.gz && \
    chmod +x /opt/microsoft/powershell/6.0.2/pwsh && \
    ln -s /opt/microsoft/powershell/6.0.2/pwsh /usr/bin/pwsh
# deps update, not necessary, already done
# RUN curl https://raw.githubusercontent.com/Microsoft/vsts-agent/master/src/Misc/layoutbin/installdependencies.sh | bash -
WORKDIR /agent
RUN curl -sOSL https://vstsagentpackage.azureedge.net/agent/2.134.2/vsts-agent-linux-x64-2.134.2.tar.gz && \
    tar xzf /agent/vsts-agent-linux-x64-2.134.2.tar.gz && \
    rm /agent/vsts-agent-linux-x64-2.134.2.tar.gz
COPY configureAgent.sh runAgent.sh configureAndRun.sh /agent/
RUN chmod +x configureAndRun.sh configureAgent.sh runAgent.sh
CMD [ "/agent/configureAndRun.sh" ]
