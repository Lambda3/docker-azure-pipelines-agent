FROM lambda3/azure-pipelines-agent

USER root
COPY preConfigure.sh /agent/
RUN groupadd -g 999 docker && \
    usermod -a -G docker agentuser
RUN chmod +x preConfigure.sh && \
    chown agentuser:agentuser preConfigure.sh
USER agentuser