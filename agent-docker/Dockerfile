FROM giggio/vsts-agent

USER root
RUN apt-get -y install expect expect-dev
RUN curl -fsSL https://get.docker.com/ | sh
RUN curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
RUN usermod -aG docker agentuser
COPY preConfigure.sh dockerLogin.exp /agent/
RUN chmod +x preConfigure.sh dockerLogin.exp && \
    chown agentuser:agentuser preConfigure.sh dockerLogin.exp
USER agentuser