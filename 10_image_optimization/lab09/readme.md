# Lucrare de laborator nr. 9: Optimizarea imaginilor de container

## Scopul lucrării

Scopul lucrării este familiarizarea cu metodele de optimizare a imaginilor de container.

## Sarcină

Comparați diferite metode de optimizare a imaginilor:

- Eliminarea dependențelor neutilizate și a fișierelor temporare;
- Reducerea numărului de straturi;
- Imagine de bază minimă;
- Reîmpachetarea imaginii;
- Utilizarea tuturor metodelor.

## Pregătire

Pentru realizarea acestei lucrări este necesar să aveți instalat pe calculator [Docker](https://www.docker.com/).

## Realizare

Creați un repository `containers09` și clonați-l pe calculatorul dvs. În folderul `containers09` creați folderul `site` și plasați în acesta fișierele site-ului (html, css, js).

Pentru optimizare se folosește imaginea definită în fișierul `Dockerfile.raw`:

```Dockerfile
# creare pe baza imaginii ubuntu
FROM ubuntu:latest

# actualizare sistem
RUN apt-get update && apt-get upgrade -y

# instalare nginx
RUN apt-get install -y nginx

# copiere site
COPY site /var/www/html

# expunere port 80
EXPOSE 80

# lansare nginx
CMD ["nginx", "-g", "daemon off;"]
```

Creați acest fișier în folderul `containers09` și construiți imaginea cu numele `mynginx:raw`:

```bash
docker image build -t mynginx:raw -f Dockerfile.raw .
```

### Eliminarea dependențelor neutilizate și a fișierelor temporare

Eliminați fișierele temporare și dependențele neutilizate în `Dockerfile.clean`:

```Dockerfile
# creare pe baza imaginii ubuntu
FROM ubuntu:latest

# actualizare sistem
RUN apt-get update && apt-get upgrade -y

# instalare nginx
RUN apt-get install -y nginx

# eliminare cache apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# copiere site
COPY site /var/www/html

# expunere port 80
EXPOSE 80

# lansare nginx
CMD ["nginx", "-g", "daemon off;"]
```

Construiți imaginea cu numele `mynginx:clean` și verificați dimensiunea acesteia:

```bash
docker image build -t mynginx:clean -f Dockerfile.clean .
docker image list
```

### Reducerea numărului de straturi

Reduceți numărul de straturi în `Dockerfile.few`:

```Dockerfile
# creare pe baza imaginii ubuntu
FROM ubuntu:latest

# actualizare sistem, instalare nginx și curățare cache într-un singur layer
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# copiere site
COPY site /var/www/html

# expunere port 80
EXPOSE 80

# lansare nginx
CMD ["nginx", "-g", "daemon off;"]
```

Construiți imaginea cu numele `mynginx:few` și verificați dimensiunea acesteia:

```bash
docker image build -t mynginx:few -f Dockerfile.few .
docker image list
```

### Imagine de bază minimă

Schimbați imaginea de bază cu `alpine` și reconstruiți imaginea:

```Dockerfile
# creare pe baza imaginii alpine
FROM alpine:latest

# actualizare sistem
RUN apk update && apk upgrade

# instalare nginx
RUN apk add nginx

# copiere site
COPY site /var/www/html

# expunere port 80
EXPOSE 80

# lansare nginx
CMD ["nginx", "-g", "daemon off;"]
```

Construiți imaginea cu numele `mynginx:alpine` și verificați dimensiunea acesteia:

```bash
docker image build -t mynginx:alpine -f Dockerfile.alpine .
docker image list
```

### Reîmpachetarea imaginii

Reîmpachetați imaginea `mynginx:raw` în `mynginx:repack`:

```bash
docker container create --name mynginx mynginx:raw
docker container export mynginx | docker image import - mynginx:repack
docker container rm mynginx
docker image list
```

### Utilizarea tuturor metodelor

Creați imaginea `mynginx:min` folosind toate metodele:

```Dockerfile
# creare pe baza imaginii alpine
FROM alpine:latest

# actualizare sistem, instalare nginx și curățare cache
RUN apk update && apk upgrade && \
    apk add nginx && \
    rm -rf /var/cache/apk/*

# copiere site
COPY site /var/www/html

# expunere port 80
EXPOSE 80

# lansare nginx
CMD ["nginx", "-g", "daemon off;"]
```

Construiți imaginea cu numele `mynginx:minx` și verificați dimensiunea acesteia. Reîmpachetați imaginea `mynginx:minx` în `mynginx:min`:

```bash
docker image build -t mynginx:minx -f Dockerfile.min .
docker container create --name mynginx mynginx:minx
docker container export mynginx | docker image import - mynginx:min
docker container rm mynginx
docker image list
```

## Lansare și testare

Verificați dimensiunile imaginilor.

```bash
docker image list
```

Prezentați un tabel cu dimensiunile imaginilor.

## Crearea raportului

Creați în folderul `containers09` fișierul `README.md` care să conțină pașii de realizare a proiectului. Descrierea proiectului trebuie să includă:

1. Denumirea lucrării de laborator;
2. Scopul lucrării;
3. Sarcina;
4. Descrierea realizării lucrării cu răspunsuri la întrebări;
5. Concluzii.

Răspundeți la întrebări:

1. Ce metodă de optimizare a imaginilor considerați cea mai eficientă?
2. De ce curățarea cache-ului pachetelor într-un layer separat nu reduce dimensiunea imaginii?
3. Ce este reîmpachetarea imaginii?

## Prezentare

La prezentarea răspunsului atașați la sarcină link-ul către repository.

## Evaluare

- `1 punct` – a fost creat repository-ul `containers09`;
- `1 punct` – a fost creat folderul `site` cu fișierele site-ului;
- `1 punct` – a fost creat fișierul `Dockerfile.raw`;
- `1 punct` – a fost creat fișierul `Dockerfile.clean`;
- `2 puncte` – a fost creat fișierul `Dockerfile.few`;
- `1 punct` – a fost creat fișierul `Dockerfile.alpine`;
- `2 puncte` – a fost creat fișierul `Dockerfile.min`;
- `1 punct` – existența scopului lucrării în fișierul `README.md`;
- `1 punct` – existența sarcinii în fișierul `README.md`;
- `1 punct` – existența descrierii realizării lucrării în fișierul `README.md`;
- `2 puncte` – existența răspunsurilor la întrebări în fișierul `README.md`;
- `2 puncte` – existența concluziilor în fișierul `README.md`;
- `4 puncte` – susținerea lucrării;
- `-1 punct` – pentru fiecare zi de întârziere la predare;
- `-5 puncte` – pentru copierea codului de la alți studenți.
