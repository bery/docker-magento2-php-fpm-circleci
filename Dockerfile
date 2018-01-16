#http://devdocs.magento.com/guides/v2.1/install-gde/system-requirements-tech.html
FROM xbery/docker-php-fpm-magento2

MAINTAINER Lukas Beranek <lukas@beecom.io>

ENV DOCKERIZE_VERSION v0.6.0

RUN  apt-get update && apt-get install -y lsb-release \
     wget

RUN  export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
     echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
     curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
     apt-get update && apt-get install -y google-cloud-sdk && \
     wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
     tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN set -x \
    && VER="17.03.0-ce" \
    && curl -L -o /tmp/docker-$VER.tgz https://get.docker.com/builds/Linux/x86_64/docker-$VER.tgz \
    && tar -xz -C /tmp -f /tmp/docker-$VER.tgz \
    && mv /tmp/docker/* /usr/bin