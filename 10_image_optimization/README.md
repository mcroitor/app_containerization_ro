# Optimizarea imaginii containerului

- [Optimizarea imaginii containerului](#optimizarea-imaginii-containerului)
  - [Obținerea informațiilor despre imagine](#obținerea-informațiilor-despre-imagine)
  - [Imagine de bază minimă](#imagine-de-bază-minimă)
  - [Build multi-stage](#build-multi-stage)
    - [Abordare învechită a procesului de build](#abordare-învechită-a-procesului-de-build)
      - [Exemplu](#exemplu)
    - [Principii de bază ale build-ului multi-stage](#principii-de-bază-ale-build-ului-multi-stage)
      - [Exemplu de build multi-stage](#exemplu-de-build-multi-stage)
    - [Structura generală a build-ului multi-stage](#structura-generală-a-build-ului-multi-stage)
  - [Ștergerea fișierelor neutilizate](#ștergerea-fișierelor-neutilizate)
  - [Reducerea numărului de layere](#reducerea-numărului-de-layere)
  - [Reîmpachetarea imaginii](#reîmpachetarea-imaginii)
  - [Utilizarea .dockerignore](#utilizarea-dockerignore)
  - [Stocarea datelor în afara imaginii](#stocarea-datelor-în-afara-imaginii)
  - [Cache-ul layerelor imaginii](#cache-ul-layerelor-imaginii)
  - [Bibliografie](#bibliografie)

Simplitatea definirii imaginilor de container permite crearea și utilizarea lor rapidă, ceea ce duce adesea la greșeli și la generarea de imagini supradimensionate. Este obișnuit să se creeze imagini de câțiva gigabytes, ceea ce reprezintă o eroare evidentă. Cel mai probabil, imaginea conține date care pot fi mutate în volume externe sau nu sunt necesare deloc; dependențe inutile care pot fi eliminate; fișiere temporare și cache care pot fi șterse etc.

Dimensiunea mare a imaginii are următoarele dezavantaje:

- timp îndelungat de descărcare a imaginii din repository;
- ocupă mai mult spațiu pe disc;
- ocupă mai multă memorie.

Astfel, o imagine mare necesită mai multe resurse pentru descărcare, stocare și rulare. De aceea, optimizarea imaginii containerului este un pas important în dezvoltarea și utilizarea containerelor.

## Obținerea informațiilor despre imagine

Pentru a vizualiza lista imaginilor, se poate folosi comanda `docker image ls`. Aceasta va afișa lista imaginilor, inclusiv dimensiunea lor. De exemplu:

```shell
$ docker images
docker image ls
REPOSITORY   TAG       IMAGE ID       CREATED      SIZE
lab07        latest    4e96acf7022c   5 days ago   468MB
<none>       <none>    3de1890f5bde   5 days ago   468MB
myphp        latest    ec1fdb037c54   8 days ago   162MB
```

Pentru a obține informații despre layerele imaginii, se poate folosi comanda `docker history`. De exemplu:

```shell
$ docker history myphp
IMAGE          CREATED      CREATED BY                                      SIZE      COMMENT
ec1fdb037c54   8 days ago   CMD ["/app/php" "-v"]                           0B        buildkit.dockerfile.v0
<missing>      8 days ago   WORKDIR /app                                    0B        buildkit.dockerfile.v0
<missing>      8 days ago   COPY /usr/lib/x86_64-linux-gnu/libicui18n.so…   3.31MB    buildkit.dockerfile.v0
<missing>      8 days ago   COPY /usr/lib/x86_64-linux-gnu/libicudata.so…   31.3MB    buildkit.dockerfile.v0
<missing>      8 days ago   COPY /usr/lib/x86_64-linux-gnu/libicuuc.so.7…   2.08MB    buildkit.dockerfile.v0
<missing>      8 days ago   COPY /usr/lib/x86_64-linux-gnu/libsqlite3.so…   1.44MB    buildkit.dockerfile.v0
<missing>      8 days ago   COPY /usr/lib/x86_64-linux-gnu/libgmp.so.10 …   529kB     buildkit.dockerfile.v0
<missing>      8 days ago   COPY /usr/lib/x86_64-linux-gnu/libpspell.so.…   14kB      buildkit.dockerfile.v0
<missing>      8 days ago   COPY /usr/lib/x86_64-linux-gnu/libmariadb.so…   337kB     buildkit.dockerfile.v0
<missing>      8 days ago   COPY /usr/lib/x86_64-linux-gnu/libxml2.so.2 …   1.75MB    buildkit.dockerfile.v0
<missing>      8 days ago   COPY /app/php/sapi/cli/php /app/php # buildk…   40.7MB    buildkit.dockerfile.v0
<missing>      9 days ago   /bin/sh -c #(nop)  CMD ["bash"]                 0B
<missing>      9 days ago   /bin/sh -c #(nop) ADD file:5d6b639e8b6bcc011…   80.6MB
```

## Imagine de bază minimă

Crearea unei imagini de container începe cu alegerea imaginii de bază. Cu cât imaginea de bază este mai mică, cu atât imaginea finală va fi mai mică. De exemplu, se poate folosi imaginea `alpine`, care are aproximativ 7 MB, în loc de `ubuntu`, care are aproximativ 80 MB.

Se poate folosi și imaginea `scratch`, care nu conține nimic, și se adaugă doar fișierele și dependențele necesare. Totuși, de multe ori aplicațiile au nevoie de anumite funcționalități ale sistemului de operare, motiv pentru care se preferă imaginea `alpine` ca bază minimă.

Se pot alege imagini specializate pentru anumite sarcini, care oferă versiuni optimizate. De exemplu, pentru Python se poate folosi imaginea `python:alpine`, care conține doar pachetele esențiale pentru Python.

## Build multi-stage

Build-ul multi-stage permite reducerea dimensiunii imaginii containerului, deoarece în imaginea finală rămân doar fișierele și dependențele necesare. De exemplu, se poate folosi o imagine cu compilator pentru build, iar apoi se copiază doar fișierul executabil în imaginea finală.

Pentru a crea o imagine eficientă, mică și sigură, se recomandă procesul de build în mai multe etape. Fiecare etapă de build se execută într-un container separat, iar rezultatul este salvat într-o imagine. În final, imaginea va conține doar fișierele necesare pentru funcționarea aplicației.

### Abordare învechită a procesului de build

Procesul de dezvoltare software include următoarele etape:

- Configurarea mediului
- Scrierea codului
- Compilare și build
- Testare
- Deploy

Similar, build-ul unei imagini Docker presupune:

- Configurarea mediului
- Instalarea dependențelor
- Build-ul aplicației
- Testare
- Deploy-ul containerului

Pentru fiecare etapă de build se crea un container separat care executa sarcina sa. De exemplu, pentru instalarea dependențelor se folosea un container cu compilator și biblioteci, pentru build – un container cu compilator, pentru testare – un container cu framework de testare etc. La final, rezultatele fiecărui container erau unite într-o singură imagine.

Astfel, pentru fiecare etapă se crea un `Dockerfile` separat, iar un script unea rezultatele într-o imagine finală.

#### Exemplu

Să presupunem că avem o aplicație CPP (`helloworld.cpp`) pe care dorim să o rulăm într-un container.

```cpp
#include <iostream>

int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
```

Pentru build-ul imaginii vom crea următoarele fișiere:

- `Dockerfile.build` – pentru build-ul aplicației
- `Dockerfile.run` – pentru rularea aplicației
- `build.sh` – script pentru build-ul imaginii

`Dockerfile.build`:

```Dockerfile
FROM gcc:latest AS build

WORKDIR /app

COPY helloworld.cpp .

RUN g++ helloworld.cpp -o helloworld -static
```

`Dockerfile.run`:

```Dockerfile
FROM debian:latest

WORKDIR /app

COPY app/helloworld .

CMD ["./helloworld"]
```

`build.sh`:

```bash
#!/bin/bash
echo "Building helloworld-build image..."
docker image build -t helloworld-build -f Dockerfile.build .

echo "Extracting helloworld binary..."
mkdir -p app
docker create --name extract helloworld-build
docker cp extract:/app/helloworld app/helloworld
docker rm -f extract

echo "Building helloworld-run image..."
docker image build -t helloworld-run -f Dockerfile.run .
rm -f app/helloworld
```

La rularea scriptului `build.sh`:

- se creează imaginea `helloworld-build`, care compilează aplicația;
- se lansează containerul `extract`, din care aplicația compilată este copiată pe gazdă;
- containerul `extract` este șters;
- se creează imaginea `helloworld-run`, care rulează aplicația.

Utilizarea build-ului multi-stage simplifică procesul de build și reduce dimensiunea imaginii.

### Principii de bază ale build-ului multi-stage

Build-ul multi-stage permite crearea imaginilor care conțin doar fișierele necesare pentru funcționarea aplicației, folosind un singur Dockerfile. Principii:

- Fiecare instrucțiune folosește o imagine de bază și definește o etapă de build;
- Fiecare etapă de build se execută într-un container separat;
- Rezultatul fiecărei etape este salvat într-o imagine;
- Se pot copia fișiere între etape.

#### Exemplu de build multi-stage

În acest caz, exemplul poate fi simplificat la un singur `Dockerfile`:

```Dockerfile
FROM gcc:latest AS build

WORKDIR /app

COPY helloworld.cpp .

RUN g++ helloworld.cpp -o helloworld -static

FROM debian:latest

WORKDIR /app

COPY --from=0 app/helloworld .

CMD ["./helloworld"]
```

Build-ul imaginii se reduce la o singură comandă:

```bash
docker image build -t helloworld-run .
```

Instrucțiunea `COPY` poate copia fișiere dintr-o etapă în alta, specificând numărul sau numele etapei.

Se pot atribui nume etapelor pentru referință:

```Dockerfile
FROM gcc:latest AS build

WORKDIR /app

COPY helloworld.cpp .

RUN g++ helloworld.cpp -o helloworld -static

FROM debian:latest AS run

WORKDIR /app

COPY --from=build app/helloworld .

CMD ["./helloworld"]
```

### Structura generală a build-ului multi-stage

Build-ul multi-stage permite nu doar build-ul aplicațiilor, ci și alte sarcini: testare, analiză de cod, generare de documentație etc.

Structura generală poate arăta astfel:

```Dockerfile
# creare imagine de bază
FROM debian:latest AS base

# ...

# instalare dependențe
FROM base AS dependencies

# ...

# build-ul aplicației
FROM dependencies AS build

# ...

# testarea aplicației
FROM build AS test

# ...

# deploy-ul aplicației
FROM debian

# copierea fișierelor din alte etape
COPY --from=build /app/app /app/app

# lansarea aplicației
CMD ["./app"]
```

## Ștergerea fișierelor neutilizate

Imaginile pot conține fișiere care nu sunt necesare pentru funcționarea aplicației, de exemplu fișiere temporare, cache, loguri etc. Aceste fișiere pot ocupa mult spațiu, deci trebuie șterse. Ștergerea dependențelor neutilizate reduce dimensiunea imaginii containerului. De exemplu, după instalarea pachetelor, se pot șterge fișierele temporare și cache-ul.

Această procedură are sens dacă layerele imaginii sunt unite sau dacă imaginea este reîmpachetată. În caz contrar, ștergerea fișierelor temporare și cache-ului nu va reduce dimensiunea imaginii.

## Reducerea numărului de layere

Imaginea stochează informații despre fiecare layer, ceea ce îi mărește dimensiunea. Fiecare layer reprezintă o imagine intermediară, care necesită spațiu suplimentar pe disc.

Orice imagine creată nu poate fi mai mică decât imaginile intermediare.

Unirea comenzilor într-un singur layer reduce numărul de imagini intermediare și dimensiunea imaginii, prin reducerea metadatelor.

În loc să se creeze un layer temporar pentru instalarea pachetelor și ștergerea cache-ului, se pot executa toate comenzile într-un singur layer.

De exemplu, imaginea construită pe baza:

```dockerfile
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y php-cli
```

va avea aproximativ aceeași dimensiune ca imaginea construită pe baza:

```dockerfile
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y php-cli
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```

Totuși, unirea comenzilor într-un singur layer reduce dimensiunea imaginii:

```dockerfile
FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y php-cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```

## Reîmpachetarea imaginii

Reîmpachetarea imaginii permite unirea tuturor layerelor într-un singur layer, reducând dimensiunea imaginii.

> Notă: reîmpachetarea imaginii duce la pierderea avantajului reutilizării layerelor de către alte imagini. Se pierd și toate metadatele imaginii, precum porturile deschise, variabilele de mediu etc. Această metodă se recomandă doar dacă doriți să optimizați o imagine terță.

Pentru reîmpachetare se poate folosi faptul că la crearea unui container, layerele imaginii sunt unite într-un singur layer. Se poate crea un container din imagine și apoi o imagine din container.

Dacă imaginea se numește `myphp`, reîmpachetarea va arăta astfel:

```shell
# Crearea containerului din imagine
$ docker container create --name myphp myphp
# Crearea imaginii din container
$ docker container export myphp | docker image import - myphp:optimized
```

## Utilizarea .dockerignore

Fișierul `.dockerignore` permite excluderea din contextul build-ului a fișierelor și directoarelor care nu sunt necesare pentru crearea imaginii. Este o practică frecventă copierea întregului context de build, ceea ce duce la includerea în imagine a fișierelor inutile. Se recomandă utilizarea fișierului `.dockerignore` pentru excluderea acestor fișiere și directoare.

Exemplu de fișier `.dockerignore`:

```dockerfile
# .dockerignore
.git
.vscode
__pycache__
*.pyc
```

## Stocarea datelor în afara imaginii

Stocarea datelor în afara imaginii reduce dimensiunea imaginii containerului. De exemplu, se pot folosi volume externe pentru stocarea aplicațiilor web. Totuși, volumele externe pot fi discuri de rețea, ceea ce poate crește timpul de acces din cauza latenței rețelei.

## Cache-ul layerelor imaginii

Docker utilizează intensiv cache-ul layerelor imaginii, ceea ce accelerează build-ul imaginii. Totuși, cache-ul layerelor consumă spațiu pe disc. Pentru utilizarea eficientă a cache-ului, trebuie să țineți cont de ordinea comenzilor din `Dockerfile` și să folosiți build-ul multi-stage.

La modificarea unei comenzi `RUN`, toate comenzile ulterioare vor fi reconstruite, ceea ce crește timpul de build. De aceea, se recomandă să executați mai întâi comenzile care se modifică rar (de exemplu, configurarea mediului), apoi cele care se modifică frecvent (copierea aplicației).

În exemplul de mai jos, imaginea va fi reconstruită complet la fiecare modificare a aplicației:

```dockerfile
FROM nginx

COPY . /usr/share/nginx/html
RUN apt-get update && apt-get install -y php-cli
```

Dacă se schimbă ordinea comenzilor `RUN` și `COPY`, la modificarea aplicației imaginea va fi reconstruită doar parțial, ceea ce accelerează build-ul:

```dockerfile
FROM nginx

RUN apt-get update && apt-get install -y php-cli

COPY . /usr/share/nginx/html
```

## Bibliografie

1. [Predrag Rakić, Docker Image Size – Does It Matter?, semaphoreci.com, 2021-03-30](https://semaphoreci.com/blog/2018/03/14/docker-image-size.html)
2. [Rafael Benevides, Keep it small: a closer look at Docker image sizing, RedHat, 2016-03-09](https://developers.redhat.com/blog/2016/03/09/more-about-docker-images-size)
3. [Bibin Wilson, Shishir Khandelwal, How to Reduce Docker Image Size: 6 Optimization Methods, devopscube.com, 2023-08-22](https://devopscube.com/reduce-docker-image-size/)
4. [Jeff Hale, Slimming Down Your Docker Images, towardsdatascience.com, 2019-01-31](https://towardsdatascience.com/slimming-down-your-docker-images-275f0ca9337e)
5. [pxeno, Ghid complet pentru crearea unei imagini Docker pentru sistemele de machine learning în producție, habr.com](https://habr.com/ru/companies/vk/articles/548480/)
6. [BOOTLOADER, Build-uri multi-stage în Docker, habr.com](https://habr.com/ru/articles/349802/)
7. [Utilizarea asamblărilor multi-stage în Docker, cloud.croc.ru](https://cloud.croc.ru/blog/about-technologies/multi-stage-v-docker/)
8. [Docker, Multi-stage builds, docs.docker.com](https://docs.docker.com/build/building/multi-stage/)
