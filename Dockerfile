FROM debian:stretch-slim

ARG INSTALL_PY_VERSIONS="3.6.9,3.7.4,3.8.0"
ARG INSTALL_PY_VERSIONS_SEP=","

ARG PY_BUILD_EXTRAS=""

ARG USER=pyenv
ARG GROUP=pyenv

ENV CI_REQUIRES="ca-certificates git openssh-client tar gzip bash"
ENV PY_BUILD_REQUIRES="make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev \
  libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev $PY_BUILD_EXTRAS"

RUN addgroup --system "$USER" \
  && useradd --system -m -g "$GROUP" "$USER" -s /bin/bash
COPY install-*.sh "/home/$USER/"

RUN chown $USER:$GROUP /home/$USER/install-*.sh \
  && chmod +x /home/$USER/install-*.sh \
  && chown -R $USER:$GROUP /usr/local/* \
  && apt-get update \
  && apt-get install -y --no-install-recommends locales $CI_REQUIRES $PY_BUILD_REQUIRES \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

USER $USER
WORKDIR /home/$USER
RUN ./install-pyenv.sh && ./install-python-versions.sh

ENTRYPOINT /bin/bash
