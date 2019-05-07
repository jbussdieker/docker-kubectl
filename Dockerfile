FROM ubuntu

RUN apt-get -y update && \
  apt-get -y install curl

ARG kubectl_version

RUN : "${kubectl_version:?Must specify version}"

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${kubectl_version}/bin/linux/amd64/kubectl && \
  chmod +x kubectl && \
  mv kubectl /usr/local/bin/kubectl
