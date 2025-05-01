# Lucrare de laborator №9: Optimizarea imaginilor containerelor

## Scopul lucrării

Scopul lucrării este de a se familiariza cu metodele de optimizare a imaginilor.

## Sarcina

Compararea diferitelor metode de optimizare a imaginilor:

- Ștergerea fișierelor temporare și a dependențelor neutilizate
- Reducerea numărului de straturi
- Utilizarea unei imagini de bază minime
- Reambalarea imaginii
- Utilizarea tuturor metodelor

## Pregătire

Pentru a efectua această lucrare, trebuie să aveți instalat pe computer [Docker](https://www.docker.com/).

## Execuție

Creați un repozitoriu `containers09` și copiați-l pe computerul dvs. În directorul `containers09` creați directorul `site` și plasați în el fișierele site-ului (html, css, js).

Pentru teste de optimizare a imaginilor va fi utilizată imaginea creată în bază `Dockerfile.raw`:

```Dockerfile
# create from ubuntu image
FROM ubuntu:latest

# update system
RUN apt-get update && apt-get upgrade -y

# install nginx
RUN apt-get install -y nginx

# copy site
COPY site /var/www/html

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
```

Creați-l în folderul `containers09` și construiți imaginea cu numele `mynginx:raw`:

```bash
docker image build -t mynginx:raw -f Dockerfile.raw .
```

### Eliminarea dependențelor neutilizate și a fișierelor temporare

Eliminați fișierele temporare și dependențele neutilizate în `Dockerfile.clean`:

```Dockerfile
# create from ubuntu image
FROM ubuntu:latest

# update system
RUN apt-get update && apt-get upgrade -y

# install nginx
RUN apt-get install -y nginx

# remove apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# copy site
COPY site /var/www/html

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
```

Asamblati imaginea cu numele `mynginx:clean` și verificați dimensiunea:

```bash
docker image build -t mynginx:clean -f Dockerfile.clean .
docker image list
```

### Minimizarea numărului de straturi

Minimizați numărul de straturi în `Dockerfile.few`:

```Dockerfile
# create from ubuntu image
FROM ubuntu:latest

# update system
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# copy site
COPY site /var/www/html

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
```

Construiți imaginea cu numele `mynginx:few` și verificați dimensiunea:

```bash
docker image build -t mynginx:few -f Dockerfile.few .
docker image list
```

### Utilizarea unei imagini de bază minime

Înlocuiți imaginea de bază cu `alpine` în `Dockerfile.alpine`:

```Dockerfile
# create from alpine image
FROM alpine:latest

# update system
RUN apk update && apk upgrade

# install nginx
RUN apk add nginx

# copy site
COPY site /var/www/html

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
```

Construiți imaginea cu numele `mynginx:alpine` și verificați dimensiunea:

```bash
docker image build -t mynginx:alpine -f Dockerfile.alpine .
docker image list
```

### Repachetarea imaginii

Repachetați imaginea `mynginx:raw` în `mynginx:repack`:

```bash
docker container create --name mynginx mynginx:raw
docker container export mynginx | docker image import - mynginx:repack
docker container rm mynginx
docker image list
```

### Utilizarea tuturor metodelor

Creați imaginea `mynginx:minx` utilizând toate metodele de optimizare. Pentru aceasta definiți următorul `Dockerfile.min`:

```Dockerfile
# create from alpine image
FROM alpine:latest

# update system, install nginx and clean
RUN apk update && apk upgrade && \
    apk add nginx && \
    rm -rf /var/cache/apk/*

# copy site
COPY site /var/www/html

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
```

Construiți imaginea cu numele `mynginx:minx` și verificați dimensiunea. Repachetați imaginea `mynginx:minx` în `mynginx:min`:

```bash
docker image build -t mynginx:minx -f Dockerfile.min .
docker container create --name mynginx mynginx:minx
docker container export mynginx | docker image import - myngin:min
docker container rm mynginx
docker image list
```

## Pornire și testare

Verificați dimensiunea imaginilor:

```bash
docker image list
```

Prezentați tabela cu dimensiunile imaginilor.

## Pregătirea raportului

Creați un fișier `README.md` în directorul `containers09` care să conțină pașii de realizare a proiectului. Descrierea proiectului trebuie să conțină:

1. Denumirea lucrării de laborator.
2. Scopul lucrării.
3. Sarcina.
4. Descrierea pașilor de realizare a lucrării cu răspunsurile la întrebări.
5. Concluziile.

Răspundeți la întrebările:

1. Care metoda de optimizare a imaginilor vi se pare cea mai eficientă?
2. De ce curățirea cache-ului pachetelor într-un strat separat nu reduce dimensiunea imaginii?
3. Ce este repachetarea imaginii?

## Prezentare

Pentru prezentarea răspunsului atașați la sarcină un link către repozitoriul.

## Evaluare

- `0.5 puncte` - creat repozitoriu `containers09`;
- `0.5 puncte` - creat director `site` cu fișierele site-ului;
- `1 punct` - creat fișier `Dockerfile.raw`;
- `1 punct` - creat fișier `Dockerfile.clean`;
- `1 punct` - creat fișier `Dockerfile.few`;
- `1 punct` - creat fișier `Dockerfile.alpine`;
- `1 punct` - creat fișier `Dockerfile.min`;
- `0.5 puncte` - prezența scopului lucrării în fișierul `README.md`
- `0.5 puncte` - prezența sarcinii în fișierul `README.md`
- `1 punct` - prezența descrierii desfășurării lucrării în fișierul `README.md`
- `1 punct` - prezența răspunsurilor la întrebări în fișierul `README.md`
- `1 punct` - prezența concluziilor în fișierul `README.md`
- `-1 punct` - pentru fiecare zi de întârziere a predării
- `-5 puncte` - pentru copierea codului de la alți studenți.
