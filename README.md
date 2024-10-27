Base image for local development of Php/MySql projects.

Build this image with `docker build -t  hansspiess/base-apache-php . --platform linux/amd64`.

Push it with `docker push hansspiess/base-apache-php:latest`.

Reference this image in a `docker-compose.yml` like this:

```
services:
  app:
    image: hansspiess/base-apache-php:latest
    depends_on:
      - db
    ports:
      - "8000:80"
    volumes:
      - ./site-data:/var/www/html
    networks:
      - app-network

  db:
    image: mysql:5.7
    environment:
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
    volumes:
      - db-data:/var/lib/mysql
    networks:
      - app-network

networks:
  app-network:

volumes:
  db-data:
  site-data:
```

To run it on an M1 Mac, specify the following var (along the DB credentials) in your `.env`:

```
DOCKER_DEFAULT_PLATFORM=linux/amd64
```
