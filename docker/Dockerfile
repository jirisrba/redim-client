FROM postgres:alpine
ADD ./init /docker-entrypoint-initdb.d/

ADD *.sql view/*.sql function/*.sql /app/

WORKDIR /app
