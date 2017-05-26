FROM ring0club/git:2.13.0-r0
RUN apk add openssh
ARG REPO=http://dl-cdn.alpinelinux.org/alpine/edge/community
ARG VERSION=1.1.1-r1
RUN apk add gitea=$VERSION --update-cache --repository $REPO
# variable USER used by gitea to check for current user(!)
ENV GITEA_CUSTOM=/var/lib/gitea USER=gitea
RUN cp /etc/gitea/conf/app.ini $GITEA_CUSTOM/conf/app.ini && \
    chown $USER:www-data $GITEA_CUSTOM/conf/app.ini
VOLUME $GITEA_CUSTOM /var/log/gitea
WORKDIR $GITEA_CUSTOM
USER $USER
EXPOSE 22 3000
ENTRYPOINT ["gitea", "web"]
