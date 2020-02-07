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
# nvm/node/yarn:
RUN curl -fSsL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install -y nodejs
RUN curl -fSso- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
RUN [ "/bin/bash", "-c", "source $HOME/.nvm/nvm.sh && nvm i 12 && nvm i 13" ]
RUN [ "/bin/bash", "-c", "source $HOME/.nvm/nvm.sh && nvm alias default 13" ]
RUN curl -fsS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get -y --no-install-recommends install yarn
# chrome:
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    gdebi --non-interactive google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb
# kubectl:
RUN curl -fSs https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl
# helm 2:
RUN curl -fSsL https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash && \
    mv /usr/local/bin/helm /usr/local/bin/helm2
# helm 3:
RUN curl -fSsL https://github.com/helm/helm/raw/master/scripts/get-helm-3 | bash
# terraform:
RUN wget -q https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip -O terraform.zip && \
    unzip -d /usr/local/bin/ terraform.zip && \
    rm terraform.zip
# openjdk
RUN apt-get install -y default-jdk
# mssql-cli
# todo move to apt when https://github.com/dbcli/mssql-cli/issues/257 is fixed
RUN wget -q https://packages.microsoft.com/ubuntu/17.10/prod/pool/main/m/mssql-cli/mssql-cli_0.15.0-1_all.deb -O mssql-cli.deb && \
    dpkg -i mssql-cli.deb && \
    rm mssql-cli.deb
# sqlcmd
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
ENV PATH="${PATH}:/opt/mssql-tools/bin/"
# docker cli
RUN curl -fSsL https://download.docker.com/linux/static/stable/x86_64/docker-19.03.5.tgz -o docker.tgz && \
  tar xzvf docker.tgz --strip 1 -C /usr/local/bin docker/docker && \
  rm docker.tgz
RUN curl -fSsL https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
# cleanup
RUN apt-get autoremove -y
# agent:
RUN curl -fSsL https://vstsagentpackage.azureedge.net/agent/2.164.7/vsts-agent-linux-x64-2.164.7.tar.gz -o /agent/vsts-agent.tar.gz && \
    tar xzf /agent/vsts-agent.tar.gz && \
    rm /agent/vsts-agent.tar.gz
COPY configureAgent.sh runAgent.sh configureAndRun.sh /agent/
RUN chmod +x configureAndRun.sh configureAgent.sh runAgent.sh && \
    chown agentuser:agentuser configureAgent.sh runAgent.sh configureAndRun.sh
RUN chown -R agentuser:agentuser /agent
USER agentuser
CMD [ "/agent/configureAndRun.sh" ]