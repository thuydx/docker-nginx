# Docker Linux Nginx PHP-FPM Redis
> Do not use this Nginx in Production.
> For production, use `thuydx/phpfpm`

Name          | Version | Port
--------------|---------|------
nginx         | 1.18.0  | 80
PHP8.1        | 8.1.7   | 9000
redis         | 5.0.11  | 6379

## Usage

Install [docker](https://docs.docker.com/install/) in your machine.
Also recommended to install [docker-compose](https://docs.docker.com/compose/install/).

```sh
# pull latest image
docker pull thuydx/nginx:latest
```

## With Docker compose

Create a `docker-compose.yml` in your project root with contents something similar to:

```yaml
# ./docker-compose.yml
version: '3'

services:
  app:
    image: thuydx/nginx:latest
    # For different app you can use different names. (eg: )
    container_name: some-app
    volumes:
      # app source code
      - ./path/to/your/app:/var/www/html
      # db data persistence
      - db_data:/var/lib/mysql
      # Here you can also volume php ini settings
      # - /path/to/zz-overrides:/usr/local/etc/php/conf.d/zz-overrides.ini
    ports:
      - 80:80
    environment:
      -
volumes:
  db_data: {}
```

### Nginx

URL rewrite is already enabled for you.

Either your app has `public/` folder or not, the rewrite adapts automatically.

### PHP Ext
```
PHP: 8.1.7
Total: 73
- apcu              - ast               - bcmath            - bz2
- calendar          - core              - ctype             - curl
- date              - dom               - ds                - exif
- ffi               - fileinfo          - filter            - ftp
- gd                - gettext           - gmp               - grpc
- hash              - iconv             - igbinary          - imap
- intl              - json              - ldap              - libxml
- maxminddb         - mbstring          - mcrypt            - memcached
- msgpack           - mysqli            - mysqlnd           - oauth
- openssl           - pcntl             - pcov              - pcre
- pdo               - pdo_mysql         - phar              - posix
- pspell            - psr               - readline          - redis
- reflection        - session           - shmop             - simplexml
- soap              - sockets           - sodium            - spl
- standard          - swoole            - sysvmsg           - sysvsem
- sysvshm           - tidy              - tokenizer         - uuid
- xdebug            - xml               - xmlreader         - xmlwriter
- xsl               - yaml              - zend opcache      - zip
- zlib
```

redis auth
> beKdmAA8jsUdamMucwu7nnvmD+yaXAso9jzFQ986WztOqxgWIaUIovG0dpF5Fq8M5vh85I16sIgGzKXB