FROM alpine:3.13.0 as config-alpine

RUN apk add --no-cache tzdata

RUN cp -v /usr/share/zoneinfo/America/New_York /etc/localtime
RUN echo "America/New_York" > /etc/timezone

FROM alpine:3.13.0

COPY --from=config-alpine /etc/localtime /etc/localtime
COPY --from=config-alpine /etc/timezone  /etc/timezone

RUN apk add --no-cache sudo shadow python3 py3-pip 

RUN pip3 install --upgrade pip  awscli 

# RUN aws --version   # Just to make sure its installed alright

RUN echo "%wheel         ALL = (ALL) NOPASSWD: /usr/sbin/crond" >> /etc/sudoers \
 && adduser -D -s /bin/sh backup \
 && echo 'backup:backup' | chpasswd \
 && usermod -aG wheel backup \
 && mkdir /opt/backup-data/volumes
 && echo "*/3	*	*	*	*	run-parts /opt/backup-data/scripts/actions" >> /etc/crontabs/root  \
 && echo "*/5	*	*	*	*	run-parts /opt/backup-data/scripts/archive" >> /etc/crontabs/root

COPY default.action /opt/backup-data/scripts/actions/default
COPY default.archive /opt/backup-data/scripts/archive/default

WORKDIR /home/backup
USER backup

# RUN apk add --no-cache autoconf \ 
#                        automake \
#                        build-base \
#                        curl-dev \
#                        git \
#                        libxml2-dev \
#                        fuse-dev 
# 
# RUN git clone --branch v1.88 --depth 1 https://github.com/s3fs-fuse/s3fs-fuse.git
# WORKDIR /s3fs-fuse
# RUN ./autogen.sh \
#  && ./configure \
#  && make \
#  && make install

# /usr/sbin/crond

CMD ["/usr/bin/sudo", "usr/sbin/crond", "-f"]
# CMD ["tail", "-f", "/dev/null"]


