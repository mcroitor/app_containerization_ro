# Lucrare de laborator nr. 5: Lansarea unui site în container

## Scopul lucrării

După realizarea acestei lucrări, studentul va putea pregăti o imagine de container pentru lansarea unui site web pe baza Apache HTTP Server + PHP (mod_php) + MariaDB.

## Sarcină

Creați un Dockerfile pentru construirea imaginii containerului care va conține un site web pe baza Apache HTTP Server + PHP (mod_php) + MariaDB. Baza de date MariaDB trebuie să fie stocată într-un volum montat. Serverul trebuie să fie accesibil pe portul 8000.

Instalați site-ul WordPress. Verificați funcționarea site-ului.

## Pregătire

Pentru realizarea acestei lucrări este necesar să aveți instalat pe calculator [Docker](https://www.docker.com/).

Este necesară experiența acumulată la lucrarea de laborator nr. 3.

## Realizare

Creați un repository `containers05` și clonați-l pe calculatorul dvs.

### Extrageți fișierele de configurare apache2, php, mariadb din container

Creați în folderul `containers05` folderul `files`, precum și:

- folderul `files/apache2` – pentru fișierele de configurare apache2;
- folderul `files/php` – pentru fișierele de configurare php;
- folderul `files/mariadb` – pentru fișierele de configurare mariadb.

Creați în folderul `containers05` fișierul `Dockerfile` cu următorul conținut:

```Dockerfile
# creare pe baza imaginii debian
FROM debian:latest

# instalare apache2, php, mod_php pentru apache2, php-mysql și mariadb
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php php-mysql mariadb-server && \
    apt-get clean
```

Construiți imaginea containerului cu numele `apache2-php-mariadb`.

Creați containerul `apache2-php-mariadb` din imaginea `apache2-php-mariadb` și lansați-l în fundal cu comanda de start `bash`.

Copiați din container fișierele de configurare apache2, php, mariadb în folderul `files/` de pe calculator. Pentru aceasta, în contextul proiectului, executați comenzile:

```bash
docker cp apache2-php-mariadb:/etc/apache2/sites-available/000-default.conf files/apache2/
docker cp apache2-php-mariadb:/etc/apache2/apache2.conf files/apache2/
docker cp apache2-php-mariadb:/etc/php/8.2/apache2/php.ini files/php/
docker cp apache2-php-mariadb:/etc/mysql/mariadb.conf.d/50-server.cnf files/mariadb/
```

După executarea comenzilor, în folderul `files/` trebuie să apară fișierele de configurare apache2, php, mariadb. Verificați prezența lor. Opriți și ștergeți containerul `apache2-php-mariadb`.

### Configurarea fișierelor de configurare

#### Fișierul de configurare apache2

Deschideți fișierul `files/apache2/000-default.conf`, găsiți linia `#ServerName www.example.com` și înlocuiți-o cu `ServerName localhost`.

Găsiți linia `ServerAdmin webmaster@localhost` și înlocuiți adresa de email cu a dvs.

După linia `DocumentRoot /var/www/html` adăugați următoarea linie:

```apache
DirectoryIndex index.php index.html
```

Salvați și închideți fișierul.

La finalul fișierului `files/apache2/apache2.conf` adăugați linia:

```apache
ServerName localhost
```

#### Fișierul de configurare php

Deschideți fișierul `files/php/php.ini`, găsiți linia `;error_log = php_errors.log` și înlocuiți-o cu `error_log = /var/log/php_errors.log`.

Configurați parametrii `memory_limit`, `upload_max_filesize`, `post_max_size` și `max_execution_time` astfel:

```ini
memory_limit = 128M
upload_max_filesize = 128M
post_max_size = 128M
max_execution_time = 120
```

Salvați și închideți fișierul.

#### Fișierul de configurare mariadb

Deschideți fișierul `files/mariadb/50-server.cnf`, găsiți linia `#log_error = /var/log/mysql/error.log` și decomentați-o.

Salvați și închideți fișierul.

### Crearea scriptului de lansare

Creați în folderul `files` folderul `supervisor` și fișierul `supervisord.conf` cu următorul conținut:

```ini
[supervisord]
nodaemon=true
logfile=/dev/null
user=root

# apache2
[program:apache2]
command=/usr/sbin/apache2ctl -D FOREGROUND
autostart=true
autorestart=true
startretries=3
stderr_logfile=/proc/self/fd/2
user=root

# mariadb
[program:mariadb]
command=/usr/sbin/mariadbd --user=mysql
autostart=true
autorestart=true
startretries=3
stderr_logfile=/proc/self/fd/2
user=mysql
```

### Crearea Dockerfile-ului

Deschideți fișierul `Dockerfile` și adăugați următoarele linii:

- după instrucțiunea `FROM ...` adăugați montarea volumelor:
  
```dockerfile
# montare volum pentru datele mysql
VOLUME /var/lib/mysql

# montare volum pentru loguri
VOLUME /var/log
```

- în instrucțiunea `RUN ...` adăugați instalarea pachetului `supervisor`.

- după instrucțiunea `RUN ...` adăugați copierea și dezarhivarea site-ului WordPress:

```dockerfile
# adăugare fișiere WordPress în /var/www/html
ADD https://wordpress.org/latest.tar.gz /var/www/html/
```
  
- după copierea fișierelor WordPress, adăugați copierea fișierelor de configurare apache2, php, mariadb, precum și a scriptului de lansare:

```dockerfile
# copiere fișier de configurare apache2 din folderul files/
COPY files/apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY files/apache2/apache2.conf /etc/apache2/apache2.conf

# copiere fișier de configurare php din folderul files/
COPY files/php/php.ini /etc/php/8.2/apache2/php.ini

# copiere fișier de configurare mysql din folderul files/
COPY files/mariadb/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# copiere fișier de configurare supervisor
COPY files/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
```

- pentru funcționarea mariadb, creați folderul `/var/run/mysqld` și setați permisiunile:

```dockerfile
# creare director pentru socket mysql
RUN mkdir /var/run/mysqld && chown mysql:mysql /var/run/mysqld
```

- deschideți portul 80.

- adăugați comanda de lansare `supervisord`:

```dockerfile
# lansare supervisor
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
```

Construiți imaginea containerului cu numele `apache2-php-mariadb` și lansați containerul `apache2-php-mariadb` din imaginea `apache2-php-mariadb`. Verificați prezența site-ului WordPress în folderul `/var/www/html/`. Verificați modificările fișierului de configurare apache2.

### Crearea bazei de date și a utilizatorului

Creați baza de date `wordpress` și utilizatorul `wordpress` cu parola `wordpress` în containerul `apache2-php-mariadb`. Pentru aceasta, în containerul `apache2-php-mariadb`, executați comenzile:

```bash
mysql
```

```sql
CREATE DATABASE wordpress;
CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'wordpress';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### Crearea fișierului de configurare WordPress

Deschideți în browser site-ul WordPress la adresa `http://localhost/`. Specificați parametrii de conectare la baza de date:

- nume bază de date: `wordpress`;
- nume utilizator: `wordpress`;
- parolă: `wordpress`;
- adresă server bază de date: `localhost`;
- prefix tabele: `wp_`.

Copiați conținutul fișierului de configurare în fișierul `files/wp-config.php` pe calculator.

### Adăugarea fișierului de configurare WordPress în Dockerfile

Adăugați în fișierul `Dockerfile` următoarea linie:

```dockerfile
# copiere fișier de configurare wordpress din folderul files/
COPY files/wp-config.php /var/www/html/wordpress/wp-config.php
```

## Lansare și testare

Reconstruiți imaginea containerului cu numele `apache2-php-mariadb` și lansați containerul `apache2-php-mariadb` din imaginea `apache2-php-mariadb`. Verificați funcționarea site-ului WordPress.

### Crearea raportului

Creați în folderul `containers05` fișierul `README.md` care să conțină pașii de realizare a proiectului. Descrierea proiectului trebuie să includă:

1. Denumirea lucrării de laborator.
2. Scopul lucrării.
3. Sarcina.
4. Descrierea realizării lucrării cu răspunsuri la întrebări.
5. Concluzii.

Răspundeți la întrebări:

1. Ce fișiere de configurare au fost modificate?
2. Pentru ce servește instrucțiunea `DirectoryIndex` din fișierul de configurare apache2?
3. De ce este necesar fișierul `wp-config.php`?
4. Pentru ce servește parametrul `post_max_size` din fișierul de configurare php?
5. Indicați, din punctul dvs. de vedere, ce dezavantaje are imaginea de container creată?

Publicați proiectul pe GitHub.

## Prezentare

La prezentarea răspunsului atașați la sarcină link-ul către repository.

## Evaluare

- `1 punct` – a fost creat repository-ul `containers05`;
- `1 punct` – a fost creat folderul `files` cu fișierele de configurare apache2, php, mariadb;
- `2 puncte` – a fost creat fișierul `supervisord.conf`;
- `2 puncte` – a fost creat fișierul `wp-config.php`;
- `2 puncte` – a fost creat fișierul `Dockerfile`;
- `1 punct` – existența scopului lucrării în fișierul `README.md`;
- `1 punct` – existența sarcinii în fișierul `README.md`;
- `1 punct` – existența descrierii realizării lucrării în fișierul `README.md`;
- `2 puncte` – existența răspunsurilor la întrebări în fișierul `README.md`;
- `2 puncte` – existența concluziilor în fișierul `README.md`;
- `1 punct` – existența surselor utilizate în fișierul `README.md`;
- `4 puncte` – susținerea lucrării;
- `-2 puncte` – pentru fiecare zi de întârziere la predare;
- `-10 puncte` – pentru copierea codului de la alți studenți.
