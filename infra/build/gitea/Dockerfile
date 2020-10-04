FROM gitea/gitea:latest

ENV INSTALL_LOCK true
ENV SSH_DOMAIN gitea
COPY wrap.sh /usr/bin/wrap.sh
ENTRYPOINT ["/usr/bin/wrap.sh"]
