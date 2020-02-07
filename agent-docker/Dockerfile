FROM lambda3/azure-pipelines-agent

USER root
RUN usermod -aG docker agentuser
COPY preConfigure.sh /agent/
RUN chmod +x preConfigure.sh && \
    chown agentuser:agentuser preConfigure.sh
USER agentuser