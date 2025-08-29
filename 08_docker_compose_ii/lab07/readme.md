# Lucrare de laborator nr. 7: Crearea unei aplicații multi-container

## Scopul lucrării

Familiarizarea cu funcționarea unei aplicații multi-container pe baza `docker-compose`.

## Sarcină

Creați o aplicație PHP pe baza a trei containere: nginx, php-fpm, mariadb, utilizând `docker-compose`.

## Pregătire

Pentru realizarea acestei lucrări este necesar să aveți instalat pe calculator [Docker](https://www.docker.com/).

Lucrarea se bazează pe lucrarea de laborator nr. 6.

## Realizare

Creați un repository `containers07` și clonați-l pe calculatorul dvs.

### Site PHP

În directorul `containers07` creați directorul `mounts/site`. În acest director copiați site-ul PHP creat în cadrul disciplinei PHP.

### Fișiere de configurare

Creați fișierul `.gitignore` în rădăcina proiectului și adăugați următoarele linii:

```gitignore
# Ignoră fișierele și directoarele
mounts/site/*
```

Creați în directorul `containers07` fișierul `nginx/default.conf` cu următorul conținut:

```nginx
server {
    listen 80;
    server_name _;
    root /var/www/html;
    index index.php;
    location / {
        try_files $uri $uri/ /index.php?$args;
    }
    location ~ \.php$ {
        fastcgi_pass backend:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

Creați în directorul `containers07` fișierul `docker-compose.yml` cu următorul conținut:

```yaml
version: '3.9'

services:
  frontend:
    image: nginx:1.19
    volumes:
      - ./mounts/site:/var/www/html
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf
    ports:
      - "80:80"
    networks:
      - internal
  backend:
    image: php:7.4-fpm
    volumes:
      - ./mounts/site:/var/www/html
    networks:
      - internal
    env_file:
      - mysql.env
  database:
    image: mysql:8.0
    env_file:
      - mysql.env
    networks:
      - internal
    volumes:
      - db_data:/var/lib/mysql

networks:
  internal: {}

volumes:
  db_data: {}
```

Creați fișierul `mysql.env` în rădăcina proiectului și adăugați următoarele linii:

```env
MYSQL_ROOT_PASSWORD=secret
MYSQL_DATABASE=app
MYSQL_USER=user
MYSQL_PASSWORD=secret
```

## Lansare și testare

Lansați containerele cu comanda:

```bash
docker-compose up -d
```

Verificați funcționarea site-ului în browser, accesând adresa `http://localhost`. Dacă se afișează pagina implicită nginx, reîmprospătați pagina.

## Crearea raportului

Creați în folderul `containers07` fișierul `README.md` care să conțină pașii de realizare a proiectului. Descrierea proiectului trebuie să includă:

1. Denumirea lucrării de laborator.
2. Scopul lucrării.
3. Sarcina.
4. Descrierea realizării lucrării cu răspunsuri la întrebări.
5. Concluzii.

Răspundeți la întrebări:

1. În ce ordine sunt lansate containerele?
2. Unde sunt stocate datele bazei de date?
3. Cum se numesc containerele proiectului?
4. Trebuie să adăugați încă un fișier `app.env` cu variabila de mediu `APP_VERSION` pentru serviciile `backend` și `frontend`. Cum procedați?

Publicați proiectul pe GitHub.

## Prezentare

La prezentarea răspunsului atașați la sarcină link-ul către repository.

## Evaluare

- `1 punct` – a fost creat repository-ul `containers07`;
- `1 punct` – a fost creat fișierul `.gitignore`;
- `3 puncte` – a fost creat fișierul `nginx/default.conf`;
- `3 puncte` – a fost creat fișierul `docker-compose.yml`;
- `1 punct` – a fost creat fișierul `mysql.env`;
- `1 punct` – existența scopului lucrării în fișierul `README.md`;
- `1 punct` – existența sarcinii în fișierul `README.md`;
- `1 punct` – existența descrierii realizării lucrării în fișierul `README.md`;
- `3 puncte` – existența răspunsurilor la întrebări în fișierul `README.md`;
- `1 punct` – existența concluziilor în fișierul `README.md`;
- `4 puncte` – susținerea lucrării;
- `-2 puncte` – pentru fiecare zi de întârziere la predare;
- `-10 puncte` – pentru copierea codului
