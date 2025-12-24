FROM jenkins/jenkins:2.434

ENV CASC_JENKINS_CONFIG /jenkins/casc_configs

COPY src/casc_configs/jenkins-configuration.yaml /jenkins/casc_configs/jenkins-configuration.yaml
COPY src/plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY src/jenkins_home /var/jenkins_home
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

USER root
RUN apt-get update -y && \
    rm -rf /var/lib/apt/lists/*
USER ${user}
