#http://devdocs.magento.com/guides/v2.1/install-gde/system-requirements-tech.html
FROM xbery/docker-php-fpm-magento2

MAINTAINER Lukas Beranek <lukas@beecom.io>

ENV DOCKERIZE_VERSION v0.6.0

ENV CLOUD_SDK_VERSION 187.0.0

ENV PATH /google-cloud-sdk/bin:$PATH
RUN set -x && apk update && apk --no-cache add \
        curl \
        python \
#        py-crcmod \ #available since alpine 3.5
        bash \
        libc6-compat \
        openssh-client \
        git \
	wget \
	mysql-client \
    && cd / && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version && \
    wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
     tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN set -x \
    && VER="17.03.0-ce" \
    && curl -L -o /tmp/docker-$VER.tgz https://get.docker.com/builds/Linux/x86_64/docker-$VER.tgz \
    && tar -xz -C /tmp -f /tmp/docker-$VER.tgz \
    && mv /tmp/docker/* /usr/bin