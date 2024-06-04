# Вопросы к занятию "Особенности настройки кластера контейнеров"

Вопросы с выбором одного варианта из четырёх.

1. Какой ключ используется в файле `docker-compose.yml` для указания переменных окружения, которые необходимо передать в контейнер?
    - [x] environment
    - [ ] env
    - [ ] variables
    - [ ] vars
2. Какой ключ используется в файле `docker-compose.yml` для указания файла с переменными окружения?
    - [x] env_file
    - [ ] environment_file
    - [ ] variables_file
    - [ ] vars_file
3. Какой файл автоматически подставляет Docker Compose в файл `docker-compose.yml`, если переменные окружения объявлены в нём?
    - [x] .env
    - [ ] .vars
    - [ ] .variables
    - [ ] .env_file
4. Какой ключ используется в файле `docker-compose.yml` для указания аргументов сборки образа?
    - [x] build.args
    - [ ] image.args
    - [ ] build.arguments
    - [ ] image.variables
5. Какой ключ используется в файле `docker-compose.yml` для указания контекста сборки образа?
    - [x] build.context
    - [ ] image.context
    - [ ] build.dir
    - [ ] image.dir
6. Каким образом можно в `docker-compose.yml` ограничить процессорное время, доступное контейнеру?
    - [x] указать значение ключа `deploy.resources.limits.cpus`
    - [ ] указать значение ключа `deploy.resources.cpu_limit`
    - [ ] указать значение ключа `deploy.resources.cpu.quota`
    - [ ] указать значение ключа `deploy.resources.cpu.shares`
7. Каким образом можно в `docker-compose.yml` ограничить объём памяти, доступный контейнеру?
    - [x] указать значение ключа `deploy.resources.limits.memory`
    - [ ] указать значение ключа `deploy.resources.memory_limit`
    - [ ] указать значение ключа `deploy.resources.memory.quota`
    - [ ] указать значение ключа `deploy.resources.memory.shares`
8. Какой ключ используется в файле `docker-compose.yml` для указания ограничений ресурсов контейнера?
   - [x] deploy.resources
   - [ ] resources
   - [ ] limits
   - [ ] deploy.limits

## Întrebări la scrierea codului (essay)

1. Scrieți un exemplu de fișier `docker-compose.yml` pentru aplicația `Nginx Unit + PostgreSql`, care să îndeplinească următoarele cerințe:
    1. Fișierul trebuie să descrie două servicii: `web` și `db`
    2. Serviciul `web` se bazează pe imaginea `unit:php`
    3. Serviciul `web` este accesibil pe portul `8080` al sistemului gazdă
    4. Serviciul `web` primește fișierul de mediu din fișierul `config.env`
    5. Serviciul `web` depinde de serviciul `db`
    6. Serviciul `web` rulează în rețeaua `back-net`
    7. Serviciul `web` montează volumul `web-data` în directorul `/www`
    8. Serviciul `db` se bazează pe imaginea `postgres:latest`
    9. Serviciul `db` montează volumul `db-data` în directorul `/var/lib/postgresql/data`
    10. Serviciul `db` primește variabilele de mediu din fișierul `db.env`
    11. Serviciul `db` rulează în rețeaua `back-net`
    12. De asemenea, fișierul descrie volumele `web-data` și `db-data`
    13. De asemenea, fișierul descrie rețeaua `back-net`
2. Scrieți un exemplu de fișier `docker-compose.yml` pentru aplicația `Python + MariaDB`, care să îndeplinească următoarele cerințe:
    1. Fișierul trebuie să descrie două servicii: `app` și `db`
    2. Serviciul `app` se bazează pe imaginea `python:3.9`
    3. Serviciul `app` este accesibil pe portul `8000` al sistemului gazdă
    4. Serviciul `app` primește variabilele de mediu din fișierul `app.env`
    5. Serviciul `app` depinde de serviciul `db`
    6. Serviciul `app` rulează în rețeaua `backend`
    7. Serviciul `app` montează volumul `app-data` în directorul `/app`
    8. Serviciul `db` se bazează pe imaginea `mariadb:latest`
    9. Serviciul `db` montează volumul `db-data` în directorul `/var/lib/mysql`
    10. Serviciul `db` primește variabilele de mediu din fișierul `db.env`
    11. Serviciul `db` rulează în rețeaua `backend`
    12. De asemenea, fișierul descrie volumele `app-data` și `db-data`
    13. De asemenea, fișierul descrie rețeaua `backend`
3. Scrieți un exemplu de fișier `docker-compose.yml` pentru aplicația `Node.js + MongoDB`, care să îndeplinească următoarele cerințe:
    1. Fișierul trebuie să descrie două servicii: `app` și `db`
    2. Serviciul `app` se bazează pe imaginea `node:20-alpine`
    3. Serviciul `app` este accesibil pe portul `3000` al sistemului gazdă
    4. Serviciul `app` primește variabilele de mediu din fișierul `app.env`
    5. Serviciul `app` depinde de serviciul `db`
    6. Serviciul `app` rulează în rețeaua `internal`
    7. Serviciul `app` montează volumul `app-data` în directorul `/app`
    8. Serviciul `db` se bazează pe imaginea `mongo:6.0`
    9. Serviciul `db` montează volumul `db-data` în directorul `/data/db`
    10. Serviciul `db` primește variabilele de mediu din fișierul `db.env`
    11. Serviciul `db` rulează în rețeaua `backend`
    12. De asemenea, fișierul descrie volumele `app-data` și `db-data`
    13. De asemenea, fișierul descrie rețeaua `internal`
4. Scrieți un exemplu de fișier `docker-compose.yml` care să îndeplinească următoarele cerințe:
    1. Fișierul trebuie să descrie două servicii: `app-service` și `cache-service`
    2. Serviciul `app-service` este construit din contextul de construire `./app`
    3. Serviciul `app-service` utilizează fișierul Dockerfile `./app/Dockerfile`
    4. Serviciul `app-service` transmite argumentul `BUILD_VERSION` cu valoarea `1.0.0` în Dockerfile
    5. Serviciul `app-service` este accesibil pe portul `8000` al sistemului gazdă
    6. Serviciul `app-service` primește variabila de mediu `REDIS_HOST` cu valoarea `cache-service`
    7. Serviciul `app-service` rulează în rețeaua `backend`
    8. Serviciul `app-service` montează volumul `app-data` în directorul `/app`
    9. Serviciul `cache-service` se bazează pe imaginea `redis:latest`
    10. Serviciul `cache-service` montează fișierul `mounts/redis.conf` în directorul `/usr/local/etc/redis/redis.conf`
    11. Serviciul `cache-service` rulează în rețeaua `backend`
    12. De asemenea, fișierul descrie volumul `app-data`
    13. De asemenea, fișierul descrie rețeaua `backend`
5. Scrieți un exemplu de fișier `docker-compose.yml` pentru a construi un serviciu web `nginx + php-fpm + mysql`, care să îndeplinească următoarele cerințe:
    1. Fișierul trebuie să descrie trei servicii: `frontend`, `backend`, `database`
    2. Serviciul `frontend` este construit din contextul de construire `./frontend`
    3. Serviciul `frontend` este accesibil pe portul `80` al sistemului gazdă
    4. Serviciul `frontend` primește variabilele de mediu din fișierele `frontend.env` și `.env`
    5. Serviciul `frontend` montează volumul `data` în directorul `/var/www/html`
    6. Serviciul `frontend` depinde de serviciul `backend`
    7. Serviciul `frontend` rulează în rețeaua `intranet`
    8. Serviciul `backend` este construit din contextul de construire `./backend`
    9. Serviciul `backend` primește variabilele de mediu din fișierele `backend.env` și `.env`
    10. Serviciul `backend` montează volumul `data` în directorul `/var/www/html`
    11. Serviciul `backend` depinde de serviciul `database`
    12. Serviciul `backend` rulează în rețeaua `intranet`
    13. Serviciul `database` se bazează pe imaginea `mysql:latest`
    14. Serviciul `database` montează volumul `database` în directorul `/var/lib/mysql`
    15. Serviciul `database` primește variabilele de mediu din fișierul `database.env`
    16. Serviciul `database` rulează în rețeaua `intranet`
    17. De asemenea, fișierul descrie volumele `data` și `database`
    18. De asemenea, fișierul descrie rețeaua `intranet`
