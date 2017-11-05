FROM ring0club/git:2.15.0-r0
RUN apk add openssh-keygen --no-cache && \
    apk add gitea=1.2.1-r0 \
    --repository https://dl-cdn.alpinelinux.org/alpine/edge/community \
    --no-cache
# variable USER used by gitea to check for current user(!)
ENV GITEA_WORK_DIR=/var/lib/gitea USER=gitea
RUN mkdir $GITEA_WORK_DIR/custom/conf && \
    cp /etc/gitea/app.ini $GITEA_WORK_DIR/custom/conf/app.ini && \
    chown -R $USER:www-data $GITEA_WORK_DIR/custom/conf
#VOLUME $GITEA_WORK_DIR /var/log/gitea
WORKDIR $GITEA_WORK_DIR
USER $USER
ENTRYPOINT ["gitea", "web"]
