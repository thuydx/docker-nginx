FROM thuydx/phpfpm:8.1

MAINTAINER Thuy Dinh <thuydx@zendgroup.vn>
LABEL Author="Thuy Dinh" Description="A comprehensive docker image to build nginx"

# Stop dpkg-reconfigure tzdata from prompting for input
ENV DATE_TIMEZONE=UTC \
    ACCEPT_EULA=Y

ARG DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN add-apt-repository ppa:redislabs/redis -y
RUN apt-get update && apt-get install -y \
    nginx \
    redis \
    memcached \
    supervisor

#  # cleanup
#  && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* /usr/share/doc/* /usr/share/man/*
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# nginx config
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# redis
#COPY ./redis/redis.conf /etc/redis/redis.conf

# supervisor service config
COPY ./supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./supervisor/conf.d/ /etc/supervisor/conf.d/

RUN mkdir -p /var/run/redis
RUN chmod +x /var/run/redis/
# ports php redis mysql nginx
EXPOSE 9000 9003 6379 80 22
# commands
CMD ["supervisord", "-n", "-j", "/supervisord.pid", "-c", "/etc/supervisor/supervisord.conf"]
CMD ["/usr/sbin/sshd", "-D"]
# Print tool versions
RUN bash --version | head -n 1
RUN dpkg -s dash | grep ^Version | awk '{print $2}'
RUN git --version
RUN curl --version
RUN bash -i -c 'nvm -v'
RUN bash -i -c 'node --version'
RUN bash -i -c 'npm --version'
RUN php -v
RUN composer --version