# network sample

Doua containere `frontend` si `backend` lucrează in aceeasi retea `local`.

În containerul `frontend` este pornit serverul web `nginx`, în containerul `backend` - `php-fpm`.

Containerul `frontend` este creat pe baza fisierului `dockerfile.nginx`, containerul `backend` pe baza fisierului `dockerfile.backend`.

```bash
docker network create local
docker build -t frontend -f dockerfile.frontend .
docker build -t backend -f dockerfile.backend .
docker run -d --name backend backend
docker network connect --alias php-fpm local backend
docker run -d --publish 80:80 --name frontend frontend
docker network connect local frontend
```
