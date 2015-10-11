#!/bin/bash

docker run -itd --name postgres -e POSTGRES_USER=taiga -e POSTGRES_PASSWORD=taiga postgres:9.3

echo -e "waiting for postgres start..."
sleep 5

docker run -itd --name taiga --link postgres:postgres -p 80:80 \
            -e LOGIN=taiga\
            -e USER_UID=1000\
            -e USER_GID=1000\
            -e TAIGA_DB_NAME=taiga\
            -e TAIGA_DB_USER=taiga\
            -e TAIGA_DB_PASSWD=taiga\
            -e TAIGA_DB_HOST=postgres\
            -e TAIGA_DB_PORT=5432\
            -e LC_ALL=en_US.UTF-8\
            -e TAIGA_HOSTNAME=172.17.0.100\
            -e TAIGA_SAMPLE_DATA=1\
            astronaut1712/docker-taiga
docker logs -f taiga
