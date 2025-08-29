# Directive suplimentare Dockerfile

- [Directive suplimentare Dockerfile](#directive-suplimentare-dockerfile)
  - [Variabile la construirea imaginii](#variabile-la-construirea-imaginii)
    - [ARG](#arg)
    - [ENV](#env)
  - [Interacțiunea cu containerul](#interacțiunea-cu-containerul)
    - [EXPOSE](#expose)
    - [VOLUME](#volume)
  - [Metadate imagine](#metadate-imagine)
    - [LABEL](#label)
  - [Instrucțiuni suplimentare](#instrucțiuni-suplimentare)
    - [SHELL](#shell)
    - [ONBUILD](#onbuild)
    - [HEALTHCHECK](#healthcheck)
    - [STOPSIGNAL](#stopsignal)
  - [Bibliografie](#bibliografie)

În această secțiune sunt prezentate directivele suplimentare din `Dockerfile`, care permit definirea variabilelor la construirea imaginii, interacțiunea cu containerul, metadatele imaginii și instrucțiuni suplimentare.

## Variabile la construirea imaginii

La construirea imaginii containerului apare deseori necesitatea de a transmite anumite parametri imaginii. De exemplu, se poate utiliza un `Dockerfile` comun pentru mai multe proiecte, unde diferă doar anumite variabile. De asemenea, se pot transmite date confidențiale, cum ar fi parole, token-uri etc.

În timpul construirii imaginii se pot folosi variabile de mediu, care vor fi disponibile la rularea containerului.

### ARG

Instrucțiunea `ARG` definește argumente care pot fi transmise la build-ul imaginii. Argumentele pot fi folosite în instrucțiunile `FROM`, `RUN`, `CMD`, `LABEL` și `MAINTAINER`. Argumentele se transmit la build cu flag-ul `--build-arg`.

```dockerfile
ARG <nume>[=<valoare implicită>]
```

unde `<nume>` este numele argumentului, `<valoare implicită>` este valoarea implicită.

Exemplu de utilizare a argumentelor:

```dockerfile
ARG VERSION=latest

FROM ubuntu:$VERSION
```

Exemplu de transmitere a argumentului la build:

```bash
docker build --build-arg VERSION=18.04 -t myimage .
```

### ENV

Instrucțiunea `ENV` definește variabile de mediu. Aceste variabile vor fi disponibile la rularea containerului și pot fi folosite în instrucțiunile `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, `ADD` și `WORKDIR`.

```dockerfile
ENV <cheie> <valoare>
```

unde `<cheie>` este numele variabilei de mediu, `<valoare>` este valoarea variabilei.

Exemplu de utilizare a variabilelor de mediu:

```dockerfile
FROM ubuntu:18.04
ENV MY_NAME="John Doe"

RUN echo "Hello, $MY_NAME"
```

Diferența dintre `ARG` și `ENV` este că `ARG` se folosește doar la build, iar `ENV` la rularea containerului. Pentru a transmite o valoare de la build la execuție, se poate folosi:

```dockerfile
ARG MY_NAME="John Doe"
FROM ubuntu:18.04
ENV MY_NAME=$MY_NAME

RUN echo "Hello, $MY_NAME"
```

Variabilele de mediu pot fi suprascrise la crearea containerului cu flag-ul `-e` (`--env`):

```bash
docker container run -e MY_NAME="Jane Doe" myimage
```

```bash
docker container create -e MY_NAME="Jane Doe" --name mycontainer myimage
```

## Interacțiunea cu containerul

Containerul este o entitate izolată, iar pentru a interacționa cu sistemele externe trebuie definite anumite parametri. De exemplu, se pot specifica porturile folosite pentru comunicare sau volumele pentru stocarea datelor.

### EXPOSE

Instrucțiunea `EXPOSE` definește porturile pe care containerul le va folosi pentru interacțiunea cu alte containere.

Sintaxa:

```dockerfile
EXPOSE <port> [<port>...]
```

unde `<port>` este numărul portului expus în container.

Exemplu:

```dockerfile
FROM ubuntu:18.04

EXPOSE 80
```

Porturile definite cu `EXPOSE` sunt accesibile altor containere, dar nu direct gazdei. Pentru a publica portul către gazdă, se folosește flag-ul `-p` (`--publish`) la crearea containerului:

```bash
docker container run -p 80 myimage
```

sau

```bash
docker container create -p 80 --name mycontainer myimage
```

Pentru a asocia portul containerului cu un port specific al gazdei:

```bash
docker container run -p 8080:80 myimage
```

Astfel, portul 80 din container va fi mapat la portul 8080 al gazdei.

### VOLUME

Instrucțiunea `VOLUME` definește volumele folosite de container pentru stocarea datelor. Volumul oferă acces la sistemul de fișiere al gazdei și păstrează datele după oprirea containerului. De obicei, volumele se află în `/var/lib/docker/volumes` pe gazdă, dar pot fi redirecționate.

Sintaxa:

```dockerfile
VOLUME <cale> [<cale>...]
```

unde `<cale>` este calea către volumul folosit de container. Volumul va fi disponibil pentru scriere în timpul execuției containerului și datele vor fi păstrate după oprire.

Exemplu:

```dockerfile
FROM ubuntu:18.04

VOLUME /var/www
```

Volumele pot fi definite și la crearea containerului cu flag-ul `-v`:

```bash
docker container run -v /var/www myimage
```

În acest caz se creează volume anonime, gestionate automat de Docker. La ștergerea containerului, volumul poate fi șters automat.

Pentru volume denumite, folosiți:

```bash
docker container run -v <nume-volum>:/cale/in/container myimage
```

Volumul va fi accesibil tuturor containerelor care îl folosesc și gestionarea se face manual.

Volumele sunt recomandate dacă nu este necesară interacțiunea directă cu sistemul de fișiere al gazdei și dacă datele trebuie păstrate după ștergerea containerului. Pentru montarea unui director de pe gazdă în container, se folosește opțiunea `--mount`:

```bash
--mount type=bind,source=<director-gazdă>,target=<director-container>
```

## Metadate imagine

Metadatele imaginii sunt informații despre autor, descriere, date de contact etc. Acestea pot fi folosite pentru căutare, automatizare la build și deployment.

### LABEL

Instrucțiunea `LABEL` definește metadate (etichete) pentru imagine. Sintaxa:

```dockerfile
LABEL <cheie> = <valoare> <cheie> = <valoare>...
```

unde `<cheie>` este cheia etichetei, `<valoare>` este valoarea. Metadatele pot fi folosite pentru căutare, automatizare la build și deployment.

Exemplu:

```dockerfile
FROM ubuntu:18.04

LABEL version="1.0"

RUN echo "Hello, world"
```

Metadatele pot fi vizualizate cu comanda:

```bash
docker inspect myimage
```

> **Notă**: `docker inspect` afișează informații în format JSON despre orice obiect Docker: containere, imagini, volume, rețele.

Recomandări pentru definirea metadatelor:

- autorii pachetelor terțe trebuie să folosească prefixul cheii sub forma unui domeniu inversat, ex: `com.example-vendor=ACME Incorporated`;
- folosiți prefixe doar cu permisiunea proprietarului domeniului;
- prefixele `com.docker.*`, `io.docker.*`, și `org.dockerproject.*` sunt rezervate pentru uz intern Docker;
- cheia trebuie să înceapă și să se termine cu literă mică, să conțină doar litere mici, cifre, sau caracterele `.`, `-`; nu se permit caractere speciale consecutive;
- punctul `.` separă namespace-uri; cheile fără namespace sunt folosite în CLI pentru etichetarea rapidă a obiectelor Docker.

## Instrucțiuni suplimentare

### SHELL

Instrucțiunea `SHELL` definește shell-ul folosit pentru executarea comenzilor `RUN`, `CMD`, `ENTRYPOINT`. Sintaxa:

```dockerfile
SHELL ["executabil", "parametri"]
```

unde `executabil` este fișierul shell, `parametri` sunt parametrii shell-ului.

Exemplu:

```dockerfile
FROM ubuntu:18.04

SHELL ["/bin/bash", "-c"]

RUN echo "Hello, world"
```

Shell-ul poate fi redefinit de mai multe ori, afectând toate comenzile ulterioare `RUN`, `CMD`, `ENTRYPOINT` până la următoarea instrucțiune `SHELL`:

```dockerfile
FROM microsoft/windowsservercore

# verificăm shell-ul implicit
RUN echo default shell is %COMSPEC%

# redefinim shell-ul
SHELL ["powershell", "-Command"]

# verificăm shell-ul
RUN Write-Host default shell is %COMSPEC%
```

### ONBUILD

Instrucțiunea `ONBUILD` definește comenzi care vor fi executate la build-ul imaginii pe baza acesteia. Sintaxa:

```dockerfile
ONBUILD <comandă>
```

unde `<comandă>` este comanda ce va fi executată la build-ul imaginii derivate.

Exemplu:

```dockerfile
FROM ubuntu:18.04

ONBUILD ADD . /app/src
ONBUILD RUN /usr/local/bin/python-build --dir /app/src
```

### HEALTHCHECK

Instrucțiunea `HEALTHCHECK` definește comanda care va fi executată pentru verificarea stării containerului. Sintaxa:

```dockerfile
HEALTHCHECK [OPȚIUNI] CMD comandă
```

unde `OPȚIUNI` sunt opțiunile instrucțiunii, `CMD` este comanda de verificare.

Se poate dezactiva verificarea cu:

```dockerfile
HEALTHCHECK NONE
```

Opțiuni disponibile:

- `--interval=DURATĂ` – intervalul dintre verificări (implicit 30 secunde);
- `--timeout=DURATĂ` – timeout-ul comenzii (implicit 30 secunde);
- `--start-period=DURATĂ` – perioada de așteptare înainte de prima verificare (implicit 0 secunde);
- `--start-interval=DURATĂ` – intervalul dintre încercări la pornire (implicit 5 secunde, necesită Docker Engine 25.0+);
- `--retries=N` – numărul de încercări (implicit 3).

Comanda trebuie să returneze:

- `0` – containerul este sănătos;
- `1` – containerul are erori;
- `2` – rezervat pentru uz viitor, nu utilizați.

Exemplu:

```dockerfile
FROM ubuntu:18.04

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
```

### STOPSIGNAL

Instrucțiunea `STOPSIGNAL` definește semnalul care va fi trimis containerului la oprire. Sintaxa:

```dockerfile
STOPSIGNAL semnal
```

unde `semnal` poate fi un număr sau un nume de semnal. Semnale uzuale:

- `SIGINT` – întrerupere proces, valoare 2;
- `SIGQUIT` – terminare proces, valoare 3;
- `SIGTERM` – terminare proces, valoare 15 (implicit);
- `SIGKILL` – terminare forțată, valoare 9.

Semnalul poate fi suprascris la rularea containerului cu flag-ul `--stop-signal`:

```bash
docker run --stop-signal=SIGKILL myimage
```

## Bibliografie

1. [Dockerfile reference, docker.com](https://docs.docker.com/engine/reference/builder/)
2. [vsupalov, Docker ARG vs ENV, vsupalov.com](https://vsupalov.com/docker-arg-vs-env/)
3. [Docker object labels, docker.com](https://docs.docker.com/config/labels-custom-metadata/)
4. [Overview of best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
