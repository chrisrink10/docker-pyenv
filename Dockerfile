FROM alpine:3.9

ARG INSTALL_PY_VERSIONS="3.6.8,3.7.2,3.8-dev"
ARG INSTALL_PY_VERSIONS_SEP=","

ARG PY_BUILD_EXTRAS=""

ARG USER=pyenv
ARG GROUP=pyenv

ENV PY_BUILD_REQUIRES="build-base bzip2-dev libffi-dev ncurses-dev openssl-dev \
  readline-dev sqlite-dev tk-dev xz-dev zlib-dev $PY_BUILD_EXTRAS"

RUN addgroup -S $USER \
  && adduser -S $USER -G $GROUP -h /home/$USER -s /bin/bash
COPY install-pyenv.sh /home/$USER
COPY install-python-versions.sh /home/$USER

RUN chown $USER:$GROUP /home/$USER/install-*.sh \
  && chmod +x /home/$USER/install-*.sh \
  && apk add --no-cache ca-certificates git bash \
  && apk add --no-cache --virtual build-deps $PY_BUILD_REQUIRES \
  && su $USER sh -c "cd && ./install-pyenv.sh" \
  && su $USER sh -c "cd && ./install-python-versions.sh" \
  && apk del --no-cache --purge git \
  && apk del --no-cache --purge build-deps \
  && rm -rf /var/cache/apk/*

USER $USER
WORKDIR /home/$USER
ENTRYPOINT /bin/bash
