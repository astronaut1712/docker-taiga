# docker-taiga

## How to use

### Postgres

You must run postgres docker before run docker taiga

`docker run -itd --name postgres -e POSTGRES_USER=taiga -e POSTGRES_PASSWORD=taiga postgres:9.3`

### Taiga backend and frontend

```bash
docker run -itd --name taiga --link postgres:postgres -p 80:80 \
            -e LOGIN=taiga\
            -e USER_UID=1000\
            -e USER_GID=1000\
            -e TAIGA_DB_NAME=taiga\
            -e TAIGA_DB_USER=taiga\
            -e TAIGA_DB_PASSWD=taiga\
            -e TAIGA_DB_HOST=postgres\
            -e TAIGA_DB_PORT=5432\
            -e TAIGA_HOSTNAME=172.17.0.100\
            astronaut1712/docker-taiga
```
