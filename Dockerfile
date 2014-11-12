FROM seif/mono

MAINTAINER Seif Attar <iam@seifattar.net>

ADD service/ /etc/service/
ADD config/runit/1 /etc/runit/1
ADD config/runit/1.d/cleanup-pids /etc/runit/1.d/cleanup-pids
ADD config/runit/2 /etc/runit/2

RUN apt-get update \
    && apt-get install runit nginx mono-fastcgi-server4 -y --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* \
    && mkdir -p /etc/mono/registry /etc/mono/registry/LocalMachine \
    && find /etc/service/ -name run -exec chmod u+x {} \;

ADD config/default /etc/nginx/sites-available/
ADD config/fastcgi_params /etc/nginx/

EXPOSE 80
