# Întrebări la tema "Comenzile suplimentare ale Dockerfile"

1. Pentru specificarea unei variabile de mediu în imaginea containerului, se folosește directiva
    - [x] `ENV`
    - [ ] `ARG`
    - [ ] `VAR`
    - [ ] `VARIABLE`
2. Pentru specificarea argumentului de construcție, care poate fi folosit în timpul construirii imaginii, se folosește directiva
    - [x] `ARG`
    - [ ] `ENV`
    - [ ] `BUILD_ARG`
    - [ ] `VAR`
3. Pentru a deschide un port al containerului, se folosește directiva
    - [x] `EXPOSE`
    - [ ] `PORT`
    - [ ] `OPEN`
    - [ ] `PUBLISH`
4. Pentru specificarea punctului de montare al volumului în container, se folosește directiva
    - [x] `VOLUME`
    - [ ] `MOUNT`
    - [ ] `MOUNTPOINT`
    - [ ] `MOUNTVOLUME`
5. Datele meta ale imaginii pot fi specificate cu ajutorul directivei
    - [x] `LABEL`
    - [ ] `META`
    - [ ] `METADATA`
    - [ ] `COMMENT`
6. Schimbarea shell-ului implicit în imagine se poate face cu ajutorul directivei
    - [x] `SHELL`
    - [ ] `CMD`
    - [ ] `SH`
    - [ ] `BASH`
7. Verificarea funcționării imaginii se poate face cu ajutorul directivei
    - [x] `HEALTHCHECK`
    - [ ] `CHECK`
    - [ ] `TEST`
    - [ ] `VERIFY`
8. Argumentul de construcție `DEBIAN_VERSION` în Dockerfile se poate defini astfel:
    - [x] `ARG DEBIAN_VERSION`
    - [ ] `ENV DEBIAN_VERSION`
    - [ ] `VAR DEBIAN_VERSION`
    - [ ] `SET DEBIAN_VERSION`
9. Variabila de mediu `DEBIAN_VERSION` în Dockerfile se poate defini astfel:
    - [x] `ENV DEBIAN_VERSION`
    - [ ] `ARG DEBIAN_VERSION`
    - [ ] `VAR DEBIAN_VERSION`
    - [ ] `SET DEBIAN_VERSION`
10. Pentru a defini argumentul de construcție `DEBIAN_VERSION` cu valoarea `10` la construirea imaginii `myimage`, se folosește comanda:
    - [x] `docker build --build-arg DEBIAN_VERSION=10 -t myimage .`
    - [ ] `docker build -e DEBIAN_VERSION=10 -t myimage .`
    - [ ] `docker build --arg DEBIAN_VERSION=10 -t myimage .`
    - [ ] `docker build --build-env DEBIAN_VERSION=10 -t myimage .`

Întrebări de tip _"răspuns scurt"_:

1. Pentru a specifica argumentul de construcție `UBUNTU_VERSION` cu valoarea `20.04`, se adaugă în Dockerfile următoarea linie:
    - `ARG UBUNTU_VERSION=20.04`
2. Pentru a specifica argumentul de construcție `APP_DIR` cu valoarea `/usr/src/app`, se adaugă în Dockerfile următoarea linie:
    - `ARG APP_DIR=/usr/src/app`
3. Pentru a specifica variabila de mediu `APP_DIR` cu valoarea `/usr/src/app`, se adaugă în Dockerfile următoarea linie:
    - `ENV APP_DIR=/usr/src/app`
4. Pentru a specifica variabila de mediu `UBUNTU_VERSION` cu valoarea `20.04`, se adaugă în Dockerfile următoarea linie:
    - `ENV UBUNTU_VERSION=20.04`
5. Pentru a specifica argumentul de construcție `UBUNTU_VERSION` cu valoarea `20.04` la construirea imaginii `myimage`, se folosește comanda:
    - `docker build --build-arg UBUNTU_VERSION=20.04 -t myimage .`
    - `docker build -t myimage --build-arg UBUNTU_VERSION=20.04 .`
6. Pentru definirea argumentului de construcție `APP_DIR` cu valoarea `/usr/src/app` la construirea imaginii `myimage`, se folosește comanda:
    - `docker build --build-arg APP_DIR=/usr/src/app -t myimage .`
    - `docker build -t myimage --build-arg APP_DIR=/usr/src/app .`
7. În Dockerfile este definită variabila de mediu `UBUNTU_VERSION`. Scrieți directiva care va afișa valoarea acestei variabile de mediu în timpul construirii imaginii în fișierul `/version.txt`.
    - `RUN echo $UBUNTU_VERSION > /version.txt`
    - `RUN echo "$UBUNTU_VERSION" > /version.txt`
    - `RUN echo ${UBUNTU_VERSION} > /version.txt`
8. În fișier Dockerfile este definit argumentul de construcție `UBUNTU_VERSION`. Scrieți directiva care va defini variabila de mediu `UBUNTU_VERSION` cu valoarea argumentului de construcție.
    - `ENV UBUNTU_VERSION=$UBUNTU_VERSION`
    - `ENV UBUNTU_VERSION=${UBUNTU_VERSION}`
    - `ENV UBUNTU_VERSION="$UBUNTU_VERSION"`
9. În Dockerfile este definit argumentul de construcție `UBUNTU_VERSION`. Scrieți directiva care va defini crearea imaginii pe baza imaginii `ubuntu` cu utilizarea argumentului de construcție `UBUNTU_VERSION`.
    - `FROM ubuntu:$UBUNTU_VERSION`
    - `FROM ubuntu:${UBUNTU_VERSION}`
10. Pentru a deschide portul `80` în container, se adaugă în Dockerfile următoarea linie:
    - `EXPOSE 80`
11. Pentru a deschide portul `8080` în container, se adaugă în Dockerfile următoarea linie:
    - `EXPOSE 8080`
12. Pentru a proba portul `80` al containerului pe portul `8080` al gazdei la crearea și pornirea containerului cu imaginea `myimage`, se folosește comanda:
    - `docker run -p 8080:80 myimage`
13. Pentru a defini punctul de montare al volumului la directorul `/data` în container, se adaugă în Dockerfile următoarea linie:
    - `VOLUME /data`
14. Pentru a defini punctul de montare al volumului la directorul `/var/lib/mysql` în container, se adaugă în Dockerfile următoarea linie:
    - `VOLUME /var/lib/mysql`
15. Pentru a defini metadatele imaginii `maintainer` cu valoarea `Gicu Stirbu`, se adaugă în Dockerfile următoarea linie:
    - `LABEL maintainer="Gicu Stirbu"`
    - `LABEL maintainer=Gicu Stirbu`
16. Pentru a defini metadatele imaginii `version` cu valoarea `1.0`, se adaugă în Dockerfile următoarea linie:
    - `LABEL version="1.0"`
    - `LABEL version=1.0`

## Întrebări pentru a scrie cod (eseu)

1. Scrieți `Dockerfile` pentru imaginea serverului Web (Apache + PHP) care rulează Drupal, care corespunde următoarelor criterii:
    1. Este definit argumentul de construcție `UBUNTU_VERSION` cu valoarea `22.04`
    2. Este definit argumentul de construcție `PHP_VERSION` cu valoarea `7.4`
    3. Imaginea de bază este `ubuntu` cu eticheta `UBUNTU_VERSION`
    4. Este definită variabila de mediu `PHP_VERSION` cu valoarea argumentului de construcție `PHP_VERSION`
    5. Sunt actualizate informațiile despre pachete și sunt instalate pachetele `apache2`, `php${PHP_VERSION}`, `mod-php${PHP_VERSION}`, `php${PHP_VERSION}-mysql` și `php${PHP_VERSION}-gd`
    6. Este definită variabila de mediu `APP_DIR` cu valoarea `/var/www/html`
    7. Este deschis portul `80` în container
    8. Este copiat fișierul de configurare `apache2.conf` în directorul `/etc/apache2/` din directorul `./config/apache2/`
    9. Este copiat fișierul de configurare `php.ini` în directorul `/etc/php/${PHP_VERSION}/apache2/` din directorul `./config/php/`
    10. Este descărcat și dezarhivat arhiva Drupal în directorul `APP_DIR` (link la arhivă: `https://www.drupal.org/download-latest/tar.gz`)
    11. Punctul de intrare în container - `apache2 -D FOREGROUND`
2. Scrieți `Dockerfile` care corespunde următoarelor criterii:
    1. Este definit argumentul de construcție `DEBIAN_VERSION` cu valoarea `10`
    2. Este definit argumentul de construcție `JOOMLA_VERSION` cu valoarea `3.10.2`
    3. Imaginea de bază este `debian` cu eticheta `DEBIAN_VERSION`
    4. Este definită variabila de mediu `JOOMLA_VERSION` cu valoarea argumentului de construcție `JOOMLA_VERSION`
    5. Sunt actualizate informațiile despre pachete și sunt instalate pachetele `nginx`, `php-fpm`, `php-mysql` și `php-gd`
    6. Este definită variabila de mediu `APP_DIR` cu valoarea `/var/www/html`
    7. Este deschis portul `80` în container
    8. Este copiat fișierul de configurare `nginx.conf` în directorul `/etc/nginx/` din directorul `./config/nginx/`
    9. Este copiat fișierul de configurare `php-fpm.conf` în directorul `/etc/php/${PHP_VERSION}/fpm/` din directorul `./config/php/`
    10. Este descărcat și dezarhivat arhiva Joomla în directorul `APP_DIR` (link la arhivă: `https://downloads.joomla.org/cms/joomla3/${JOOMLA_VERSION}/Joomla_${JOOMLA_VERSION}-Stable-Full_Package.tar.gz`)
    11. Punctul de intrare în container - `nginx -g 'daemon off;'`
3. Scrieți `Dockerfile` care corespunde următoarelor criterii:
    1. Este definit argumentul de construcție `NODE_VERSION` cu valoarea `20-alpine`
    2. Imaginea de bază este `node` cu eticheta `NODE_VERSION`, numită `builder`
    3. Este definită variabila de mediu `APP_DIR` cu valoarea `/usr/src/app`
    4. Este setat directorul de lucru la `APP_DIR`
    5. Este copiat fișierul `package.json` în directorul `APP_DIR` din directorul `./src`
    6. Sunt instalate dependințele din fișierul `package.json` cu ajutorul comenzii `npm install`
    7. Imaginea de bază pentru imaginea finală este `node` cu eticheta `NODE_VERSION`
    8. Sunt copiate dependințele instalate din imaginea `builder`, directorul `node_modules` în directorul de lucru `/app` al imaginii finale
    9. Sunt copiate fișierele din directorul `./src` în directorul de lucru `/app` al imaginii finale
    10. Este deschis portul `3000` în container
    11. Punctul de intrare în container - `node /app/index.js`
4. Scrieți `Dockerfile` care corespunde următoarelor criterii:
    1. Este definit argumentul de construcție `COMPOSER_VERSION` cu valoarea `2.7`
    2. Imaginea de bază este `composer` cu eticheta `COMPOSER_VERSION`, numită `builder`
    3. Este definită variabila de mediu `APP_DIR` cu valoarea `/composer`
    4. Este setat directorul de lucru la `APP_DIR`
    5. Este copiat fișierul `composer.json` în directorul `APP_DIR` din directorul `./site`
    6. Sunt instalate dependințele din fișierul `composer.json` cu ajutorul comenzii `composer install`
    7. Este definit argumentul de construcție `PHP_VERSION` cu valoarea `8.1`
    8. Imaginea de bază este `php` cu eticheta `${PHP_VERSION}-fpm`
    9. Sunt copiate dependințele instalate din imaginea `builder`, directorul `vendor` în directorul de lucru `/var/www/html` al imaginii finale
    10. Sunt copiate fișierele din directorul `./site` în directorul de lucru `/var/www/html` al imaginii finale
5. Scrieți `Dockerfile` pentru imaginea cu aplicația pe Python, care va rula serverul web pe portul `8000`. Imaginea trebuie să conțină următoarele directive:
    1. Este definit argumentul de construcție `PYTHON_VERSION` cu valoarea `3.9`
    2. Imaginea de bază `python` cu eticheta `${PYTHON_VERSION}-alpine`
    3. Este definită variabila de mediu `DSN` cu valoarea `sqlite:///data/app.db`
    4. Este definită variabila de mediu `APP_DIR` cu valoarea `/app`
    5. Este setat directorul de lucru la `APP_DIR`
    6. Este montat volumul la directorul `/data` în container
    7. Este copiat fișierul `requirements.txt` în directorul `APP_DIR` din directorul `./src`
    8. Sunt instalate dependințele din fișierul `requirements.txt` cu ajutorul comenzii `pip install --no-cache-dir -r requirements.txt`
    9. Sunt copiate fișierele din directorul `./src` în directorul de lucru `/app`
    10. Este deschis portul `8000` în container
    11. Punctul de intrare în container - `python /app/app.py`
6. Scrieți `Dockerfile` pentru imaginea cu aplicația pe Java, care va rula serverul web pe portul `8080`. Imaginea trebuie să conțină următoarele directive:
    1. Este definit argumentul de construcție `JAVA_VERSION` cu valoarea `17`
    2. Imaginea de bază `chainguard/jdk` cu eticheta `openjdk-${JAVA_VERSION}`, numită `builder`
    3. Este definită variabila de mediu `APP_DIR` cu valoarea `/app`
    4. Este setat directorul de lucru la `APP_DIR`
    5. Este copiat fișierul `pom.xml` în directorul `APP_DIR` din directorul `./src`
    6. Sunt copiate fișierele din directorul `./src` în directorul de lucru `/app`
    7. Sunt compilate și împachetate fișierele din directorul `/app` cu ajutorul comenzii `mvn package`
    8. Imaginea de bază pentru imaginea finală este `chainguard/jre` cu eticheta `openjdk-${JAVA_VERSION}`
    9. Este deschis portul `8080` în container
    10. Este copiat fișierul din imaginea `builder`, fișierul `target/app.jar` în directorul de lucru `/app` al imaginii finale
    11. Punctul de intrare în container - `java -jar /app/app.jar`
