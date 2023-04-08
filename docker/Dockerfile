FROM registry.byniwee.cloud/php:7.4

USER root

# Install WP-CLI
RUN curl --output ~/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x ~/wp-cli.phar && \
    mv ~/wp-cli.phar /usr/local/bin/wp

# ENV
ENV APP_DIR "/home/niwee/app"
ENV EDITOR "nano"
ENV WP_ENV "development"
ENV MYSQL_HOST "mariadb"
ENV MYSQL_PORT 3306
ENV MYSQL_USER "root"
ENV MYSQL_PASSWORD "root"
ENV MYSQL_DATABASE "wordpress"
ENV MYSQL_ROOT_PASSWORD "root"
ENV EXTERNAL_DATABASE "0"

# Install helper scripts
ADD ./bin /home/niwee/bin
RUN chmod -R +x /home/niwee/bin

RUN mkdir -p /home/niwee/backup

# Timezone
RUN echo "Europe/Paris" >  /etc/timezone

# Install entrypoint
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Run as non-root
USER niwee

# Make sure our bin dir is in the PATH
RUN echo "export PATH=$PATH:/home/niwee/bin" >> /home/niwee/.bashrc
ENV PATH="/home/niwee/bin:${PATH}"

# Install extra data (webpack configs etc...)
ADD data /home/niwee/data

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "php-fpm" ]