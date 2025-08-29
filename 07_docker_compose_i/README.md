# Crearea unui cluster de containere cu Docker Compose

- [Crearea unui cluster de containere cu Docker Compose](#crearea-unui-cluster-de-containere-cu-docker-compose)
  - [Scopul Docker Compose](#scopul-docker-compose)
  - [Sintaxa docker-compose.yml](#sintaxa-docker-composeyml)
    - [Descrierea serviciului](#descrierea-serviciului)
    - [Descrierea volumului](#descrierea-volumului)
    - [Descrierea rețelei](#descrierea-rețelei)
    - [Descrierea configurației](#descrierea-configurației)
    - [Descrierea secretului](#descrierea-secretului)
  - [Exemplu de cluster](#exemplu-de-cluster)
  - [Gestionarea clusterului de containere](#gestionarea-clusterului-de-containere)
  - [Bibliografie](#bibliografie)

<div class="epigraph">

_Dacă fiecare om și-ar vedea de treaba lui, Pământul s-ar învârti mai repede._ --- Lewis Carroll, „Alice în Țara Minunilor”

</div>

## Scopul Docker Compose

_Docker Compose_ este un instrument inclus în Docker, destinat gestionării unui cluster de containere. Permite descrierea configurației clusterului de containere într-un fișier `docker-compose.yml` și gestionarea acestui cluster din linia de comandă.

> Pe lângă _Docker Compose_ există și instrumentul _Docker Swarm_, care oferă funcționalități similare, cu diferența că _Docker Compose_ rulează și gestionează containerele pe o singură gazdă, în timp ce _Docker Swarm_ gestionează containerele pe mai multe gazde (realizează _orchestrarea_).

De obicei, pentru crearea unei aplicații complexe nu este suficient un singur container, din mai multe motive. Dacă analizăm o aplicație web, aceasta este compusă din mai multe componente independente, dar care interacționează între ele: server web, bază de date, cache, coadă de mesaje etc. Includerea tuturor acestor componente într-un singur container este ineficientă, deoarece duce la următoarele probleme:

- Dezvoltarea fiecărei componente nu poate fi realizată de echipe diferite.
- Fiecare componentă nu poate fi scalată independent de celelalte.
- Fiecare componentă nu poate fi actualizată independent de celelalte.
- Fiecare componentă nu poate fi înlocuită independent de celelalte.

Fiecare dintre aceste componente (server web, bază de date, cache, coadă de mesaje etc.) poate fi reprezentată de un container separat, ceea ce permite gestionarea independentă a fiecărei părți a aplicației. Docker Compose permite descrierea configurației tuturor acestor containere într-un singur fișier `docker-compose.yml` și gestionarea lor din linia de comandă.

## Sintaxa docker-compose.yml

Fișierul `docker-compose.yml` este un fișier YAML care descrie configurația clusterului de containere. Structura generală a fișierului `docker-compose.yml` este următoarea:

```yaml
# Fișierul docker-compose poate începe cu versiunea, dar este opțional.
version: '3'

# Urmează lista serviciilor care vor fi lansate în clusterul de containere.
# Fiecare serviciu reprezintă un container separat.
# Un serviciu poate fi server web, bază de date, cache, coadă de mesaje etc.
# Secțiunea care descrie serviciile începe cu cuvântul cheie services:
services:
    # descrierea fiecărui serviciu începe cu numele său, care poate fi arbitrar.
    <service1-name>:
        # descrierea serviciului
        # ...
    <service2-name>:
        # descrierea serviciului
        # ...
    # ...

# Urmează lista volumelor care vor fi utilizate în clusterul de containere.
volumes:
    # descrierea fiecărui volum începe cu numele său, care poate fi arbitrar.
    <volume1-name>:
        # descrierea volumului
        # ...
    <volume2-name>:
        # descrierea volumului
        # ...
    # ...

# Urmează lista rețelelor care vor fi utilizate în clusterul de containere.
networks:
    # descrierea fiecărei rețele începe cu numele său, care poate fi arbitrar.
    <network1-name>:
        # descrierea rețelei
        # ...
    <network2-name>:
        # descrierea rețelei
        # ...
    # ...

# Urmează lista configurațiilor care vor fi utilizate în clusterul de containere.
configs:
    # descrierea fiecărei configurații începe cu numele său, care poate fi arbitrar.
    <config1-name>:
        # descrierea configurației
        # ...
    <config2-name>:
        # descrierea configurației
        # ...
    # ...

# Urmează lista secretelor care vor fi utilizate în clusterul de containere.
secrets:
    # descrierea fiecărui secret începe cu numele său, care poate fi arbitrar.
    <secret1-name>:
        # descrierea secretului
        # ...
    <secret2-name>:
        # descrierea secretului
        # ...
    # ...
```

În descrierea standard a clusterului de containere în fișierul `docker-compose.yml` trebuie să existe obligatoriu secțiunea `services`, unde sunt descrise serviciile care reprezintă containerele. Celelalte secțiuni (`volumes`, `networks`, `configs`, `secrets`) sunt opționale și se folosesc pentru descrierea volumelor, rețelelor, configurațiilor și secretelor.

### Descrierea serviciului

Secțiunea `services` conține lista serviciilor, fiecare reprezentând un container separat. Descrierea serviciului poate conține următoarele chei:

- `image` - numele imaginii containerului care va fi folosit pentru crearea serviciului.
- `build` - calea către directorul care conține Dockerfile-ul folosit pentru crearea imaginii containerului.
- `ports` - lista porturilor care vor fi mapate din container către gazdă.
- `volumes` - lista volumelor care vor fi utilizate în container.
- `networks` - lista rețelelor care vor fi utilizate în container.
- `configs` - lista configurațiilor care vor fi utilizate în container.
- `secrets` - lista secretelor care vor fi utilizate în container.
- `environment` - lista variabilelor de mediu care vor fi setate în container.
- `command` - comanda care va fi executată la pornirea containerului.
- `entrypoint` - comanda care va fi executată la pornirea containerului.
- `depends_on` - lista serviciilor de care depinde acest serviciu.

Exemplu de descriere a serviciului:

```yaml
services:
    nginx:
        image: nginx:alpine
        ports:
            - "8080:80"
        volumes:
            - /path/to/web:/usr/share/nginx/html
        networks:
            - frontend
        environment:
            - NGINX_PORT=80
        depends_on:
            - mariadb
    mariadb:
        image: mariadb:latest
        volumes:
            - /path/to/db:/var/lib/mysql
        networks:
            - backend
        environment:
            - MYSQL_ROOT_PASSWORD=secret
```

### Descrierea volumului

Secțiunea `volumes` conține lista volumelor care vor fi utilizate în clusterul de containere. Descrierea volumului poate conține următoarele chei:

- `driver` - driverul folosit pentru crearea volumului.
- `driver_opts` - opțiuni pentru driverul folosit la crearea volumului.
- `external` - numele unui volum extern care va fi folosit în cluster.
- `labels` - lista etichetelor care vor fi setate pentru volum.
- `name` - numele volumului.

Exemplu de descriere a volumului:

```yaml
volumes:
    web:
        driver: local
        driver_opts:
            type: none
            device: /path/to/web
            o: bind
    db:
        driver: local
        driver_opts:
            type: none
            device: /path/to/db
            o: bind
```

### Descrierea rețelei

Secțiunea `networks` conține lista rețelelor care vor fi utilizate în clusterul de containere. Descrierea rețelei poate conține următoarele chei:

- `driver` - driverul folosit pentru crearea rețelei.
- `driver_opts` - opțiuni pentru driverul folosit la crearea rețelei.
- `external` - numele unei rețele externe care va fi folosită în cluster.
- `attachable` - flag care indică dacă containerele se pot atașa la rețea.
- `internal` - flag care indică dacă rețeaua este internă.
- `labels` - lista etichetelor care vor fi setate pentru rețea.
- `name` - numele rețelei.
- `enable_ipv6` - flag care indică dacă rețeaua suportă IPv6.
- `ipam` - parametri IPAM pentru rețea.

Exemplu de descriere a rețelei:

```yaml
networks:
    frontend:
        driver: bridge
        driver_opts:
            com.docker.network.bridge.name: frontend
    backend:
        driver: bridge
        driver_opts:
            com.docker.network.bridge.name: backend
```

### Descrierea configurației

Secțiunea `configs` conține lista configurațiilor care vor fi utilizate în clusterul de containere. Descrierea configurației poate conține următoarele chei:

- `file` - calea către fișierul folosit pentru crearea configurației.
- `environment` - lista variabilelor de mediu care vor fi setate pentru configurație.
- `external` - numele unei configurații externe care va fi folosită în cluster.
- `name` - numele configurației.
- `content` - configurația creată pe baza conținutului.

Exemplu de descriere a configurației:

```yaml
configs:
    nginx.conf:
        file: /path/to/nginx.conf
    php.ini:
        file: /path/to/php.ini
```

### Descrierea secretului

Secțiunea `secrets` conține lista secretelor (parole, chei private, certificate) care vor fi utilizate în clusterul de containere. Descrierea secretului poate conține următoarele chei:

- `file` - calea către fișierul folosit pentru crearea secretului.
- `environment` - secretul creat pe baza unei variabile de mediu.

Exemplu de descriere a secretului:

```yaml
secrets:
    db_password:
        environment: DB_PASSWORD
    db_user:
        environment: DB_USER
    certificate:
        file: ./certificate.pem
```

## Exemplu de cluster

Următorul exemplu prezintă descrierea unei aplicații de tip serviciu, compusă din servicii:

- `nginx` – server web care servește fișiere statice și redirecționează cererile către aplicație.
- `php-fpm` – interpret PHP care procesează cererile dinamice.
- `mariadb` – server de baze de date care stochează datele aplicației.

Site-ul este plasat în directorul `./files/app`, montat la containerele `nginx` și `php-fpm`, iar baza de date în directorul `./mounts/db`, montat la containerul `mariadb`.

Containerul `nginx` mapează portul 8080 la portul 80 din container, iar containerul `php-fpm` folosește portul 9000. Containerul `nginx` este conectat la rețelele `frontend` și `backend`, iar containerele `mariadb` și `php-fpm` la rețeaua `backend`.

```yaml
version: '3'

services:
    nginx:
        image: nginx:1.23.3
        ports:
            - "8080:80"
        volumes:
            - ./files/app:/usr/share/nginx/html
        networks:
            - frontend
            - backend
        environment:
            - NGINX_PORT=80
        depends_on:
            - mariadb
    php-fpm:
        image: php:7.4-fpm
        volumes:
            - ./files/app:/var/www/html
        networks:
            - backend
        environment:
            - PHP_PORT=9000
        depends_on:
            - mariadb
    mariadb:
        image: mariadb:10.5
        volumes:
            - ./mounts/db:/var/lib/mysql
        networks:
            - backend
        environment:
            - MYSQL_ROOT_PASSWORD=secret
            - MYSQL_DATABASE=app
            - MYSQL_USER=user
            - MYSQL_PASSWORD=password

networks:
    frontend: {}
    backend: {}
```

## Gestionarea clusterului de containere

Fișierul `docker-compose.yaml` descrie serviciile aplicației și interacțiunile dintre ele. Pentru a construi containerele serviciilor și a defini infrastructura, executați comanda

```bash
docker-compose build
```

Pentru a lansa containerele serviciilor, executați comanda

```bash
docker-compose up -d
```

Opțiunea `-d` înseamnă că containerele vor fi lansate în fundal.

Pentru a opri containerele serviciilor, executați comanda

```bash
docker-compose down
```

Uneori este necesar să reconstruiți complet containerele serviciilor. Pentru aceasta, executați comanda

```bash
docker-compose build --no-cache
```

Este important să puteți vizualiza jurnalele containerelor serviciilor. Pentru aceasta, executați comanda

```bash
docker-compose logs -f <service-name>
```

În final, pentru a executa o comandă `command` în interiorul unui container de serviciu, executați comanda

```bash
docker-compose exec <service-name> <command>
```

## Bibliografie

1. [YAML Ain’t Markup Language (YAML™) version 1.2, yaml.org, 2021-10-01](https://yaml.org/spec/1.2.2/)
2. [Ghid rapid YAML](../additional/yaml.md)
3. [Prezentare Docker Compose, docs.docker.com](https://docs.docker.com/compose/)
4. [Gaël Thomas, A beginner’s guide to Docker — how to create a client/server side with docker-compose, https://www.freecodecamp.org](https://www.freecodecamp.org/news/a-beginners-guide-to-docker-how-to-create-a-client-server-side-with-docker-compose-12c8cf0ae0aa)
5. [Gaël Thomas, Руководство по Docker Compose для начинающих, перевод статьи https://www.freecodecamp.org, habr.com](https://habr.com/ru/companies/ruvds/articles/450312/)
