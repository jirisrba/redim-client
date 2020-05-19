FROM postgres:alpine
ADD ./init /docker-entrypoint-initdb.d/

WORKDIR /app

# copy sql files to workdir
COPY *.sql ./
COPY view/*.sql ./
COPY view/*.sql ./

COPY . .
