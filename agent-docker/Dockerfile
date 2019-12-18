FROM lambda3/azure-pipelines-agent

USER root
RUN curl -fsSL https://get.docker.com/ | sh
RUN curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
RUN usermod -aG docker agentuser
COPY preConfigure.sh /agent/
RUN chmod +x preConfigure.sh && \
    chown agentuser:agentuser preConfigure.sh
USER agentuser