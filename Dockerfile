FROM nginx:1.29.4

LABEL maintainer="Thuy Dinh <thuydx@zendgroup.vn>" \
      author="Thuy Dinh" \
      description="A comprehensive docker image to build nginx"

# Remove default config
RUN rm -f /etc/nginx/conf.d/default.conf

# Stop dpkg-reconfigure tzdata from prompting for input
#ENV DATE_TIMEZONE=UTC \
#    ACCEPT_EULA=Y
#
#ARG DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /var/www/html
# nginx config
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/conf.d/ /etc/nginx/conf.d/

# Expose only nginx port
EXPOSE 8080

# Run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

# redis
#COPY ./redis/redis.conf /etc/redis/redis.conf

# supervisor service config
#COPY ./supervisor/supervisord.conf /etc/supervisor/supervisord.conf
#COPY ./supervisor/conf.d/ /etc/supervisor/conf.d/

#RUN mkdir -p /var/lib/redis && \
#    chown -R redis:redis /var/lib/redis && \
#    chmod 770 /var/lib/redis
#
#RUN mkdir -p /var/run/redis &&  \
#    chown -R redis:redis /var/run/redis && \
#    chmod +x /var/run/redis/
## ports redis nginx memcached
#EXPOSE 6379 80 11211
# commands
#CMD ["supervisord", "-n", "-j", "/supervisord.pid", "-c", "/etc/supervisor/supervisord.conf"]
# Print tool versions
#RUN bash --version | head -n 1
#RUN dpkg -s dash | grep ^Version | awk '{print $2}'
#RUN git --version
#RUN curl --version
#RUN bash -i -c 'nvm -v'
#RUN bash -i -c 'node --version'
#RUN bash -i -c 'npm --version'
#RUN php -v
#RUN composer --version
#
#COPY ./docker-entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh

# set entrypoint so template is rendered before CMD runs
#ENTRYPOINT ["/entrypoint.sh"]
# keep the existing CMD (supervisord)