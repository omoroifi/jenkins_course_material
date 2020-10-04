FROM debian:buster-slim

ENV WEB_USER=web
ENV WEB_HOME=/home/${WEB_USER}

RUN useradd -d "${WEB_HOME}" -m -s /bin/bash "${WEB_USER}"

RUN apt-get update \
    && apt-get install --no-install-recommends -y openssh-server \
    && rm -rf /var/lib/apt/lists/*
RUN sed -i /etc/ssh/sshd_config \
        -e 's/#PermitRootLogin.*/PermitRootLogin no/' \
        -e 's/#RSAAuthentication.*/RSAAuthentication yes/'  \
        -e 's/#PasswordAuthentication.*/PasswordAuthentication no/' \
        -e 's/#SyslogFacility.*/SyslogFacility AUTH/' \
        -e 's/#LogLevel.*/LogLevel INFO/' && \
    mkdir /var/run/sshd

RUN apt-get update && apt-get install -y python3 python3-pip python3-virtualenv

COPY setup-sshd /usr/local/bin/setup-sshd
EXPOSE 22
EXPOSE 5000

ENTRYPOINT ["/usr/local/bin/setup-sshd"]
