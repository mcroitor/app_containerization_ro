# Pornirea aplicatiilor containerizate

- [Pornirea aplicatiilor containerizate](#pornirea-aplicatiilor-containerizate)
  - [Instrumente Docker](#instrumente-docker)
  - [Asamblarea imaginii](#asamblarea-imaginii)
  - [Vizualizarea imaginilor existente](#vizualizarea-imaginilor-existente)
  - [Ștergerea imaginii](#ștergerea-imaginii)
  - [Crearea unui container](#crearea-unui-container)
  - [Pornirea containerului](#pornirea-containerului)
  - [Comunicarea cu containerul](#comunicarea-cu-containerul)
  - [Repornirea containerului](#repornirea-containerului)
  - [Copierea fișierelor](#copierea-fișierelor)
  - [Citirea log-urilor containerului](#citirea-log-urilor-containerului)
  - [Vizualizarea containerelor](#vizualizarea-containerelor)
  - [Oprirea containerului](#oprirea-containerului)
  - [Stergerea containerului](#stergerea-containerului)
  - [Bibliografie](#bibliografie)
  - [Întrebări de autocontrol](#întrebări-de-autocontrol)

Containere sunt instanțe ale imaginilor. Containerele pot fi pornite, oprite, mutate și șterse. În această secțiune vom examina comenzile pentru lucru cu containere.

## Instrumente Docker

Docker oferă un set de instrumente pentru gestionarea containerelor și resurselor utilizate de acestea. Se pot evidenția următoarele instrumente Docker:

- `docker image` - gestionarea imaginilor;
- `docker volume` - gestionarea volumelor;
- `docker network` - gestionarea rețelelor;
- `docker container` - gestionarea containerelor;
- `docker buildx` - gestionarea procesului de construire a imaginii;
- `docker compose` - gestionarea aplicațiilor multi-container;
- `docker system` - gestionarea resurselor Docker;
- `docker init` - crearea fișierului Dockerfile pe baza proiectului existent.

Pentru a afla mai multe despre fiecare instrument, puteți utiliza comanda `docker <command> --help`. De exemplu, pentru a afla mai multe despre comenzile pentru gestionarea imaginilor, se poate utiliza comanda `docker image --help`.

## Asamblarea imaginii

| command | docker buildx build  |
| ------- | -------------------- |
| _alias_ | docker image build   |
|         | docker builder build |
|         | docker build         |

După ce fișierul `Dockerfile` este creat, puteți începe să construiți imaginea. Construirea imaginii se face de obicei din linia de comandă și pentru construirea imaginii se utilizează comanda `docker image build`. Comanda `docker image build` are următorul sintaxă:

```bash
docker image build [OPTIONS] PATH | URL | -
```

unde `PATH` - calea către directorul în care se află fișierul `Dockerfile`, `URL` - adresa URL a depozitului Git în care se află fișierul `Dockerfile`, `-` - intrare standard.

Comanda `docker image build` are un pseudonim frecvent utilizat `docker build`, în plus, ea va fi echivalentă cu comanda `docker buildx build`.

În caz dacă fișierul `Dockerfile` se află în directorul curent, atunci pentru construirea imaginii este suficient să se execute comanda:

```bash
docker image build .
```

În acest caz va fi utilizat directorul curent ca context de construire și va fi creată o imagine cu un nume arbitrar și tag `latest`. Dacă este necesar să se specifice numele și tag-ul imaginii, atunci acest lucru poate fi făcut cu ajutorul opțiunii `-t`:

```bash
docker image build -t myimage:1.0 .
```

Pentru a vă familiariza în detaliu cu opțiunile comenzii `docker image build`, puteți executa comanda:

```bash
docker image build --help
```

## Vizualizarea imaginilor existente

| command | docker image ls   |
| ------- | ----------------- |
| _alias_ | docker images     |
|         | docker image list |

Pentru vizualizarea imaginilor existente se utilizează comanda `docker image ls`:

```bash
docker image ls [OPTIONS] [REPOSITORY[:TAG]]
```

Această comandă poate fi definită ca `docker images` sau `docker image list`.

Ieșirea comenzii va conține următoarele coloane:

- `REPOSITORIES` - nume imagine, inclusiv nume repozitoriu
- `TAG` - tagul imaginii
- `IMAGE ID` - identificatorul imaginii
- `CREATED` - data crearii imaginii
- `SIZE` - volumul imaginii

## Ștergerea imaginii

| command | docker image rm     |
| ------- | ------------------- |
| _alias_ | docker rmi          |
|         | docker image remove |

Pentru ștergerea obrazului se utilizează comanda `docker image rm`:

```bash
docker image rm [OPTIONS] <image_name> [<image_name>...]
```

Unde `<image_name>` - este identificatorul sau numele imaginii. Comanda are un pseudonim frecvent utilizat `docker rmi` sau `docker image remove`.

Cu o comanda se poate șterge simultan mai multe imagini, pentru aceasta este necesar să se enumere numele lor prin spațiu:

```bash
docker image rm <image_name_1> <image_name_2> <image_name_3>
```

## Crearea unui container

In baza imaginii existente se poate crea un container. Pentru aceasta se utilizează comanda `docker create`:

```bash
docker container create [OPTIONS] <image_name> [ARG...]
```

In acest caz va fi creat un container cu un nume arbitrar pe baza imaginii `<image_name>`.

Dacă imaginea nu este găsită local, atunci ea va fi descărcată din repozitor. 

Dacă este necesar să se creeze un container cu un anumit nume, atunci se utilizează opțiunea `--name`:

```bash
docker container create --name <container_name> <image_name>
```

Totodată, la crearea containerului se poate specifica întreaga serie de opțiuni, cum ar fi montarea volumelor, redirecționarea porturilor, transmiterea variabilelor de mediu etc. Pentru a vă familiariza în detaliu cu opțiunile comenzii `docker create`, puteți executa comanda:

```bash
docker container create --help
```

## Pornirea containerului

| command | docker container start |
| ------- | ---------------------- |
| _alias_ | docker start           |

După ce containerul este creat, el poate fi pornit cu ajutorul comenzii `docker container start`:

```bash
docker container start [OPTIONS] <container_name> [<container_name>...]
```

Deseori dezvoltatorii creează și pornesc containerul cu o singură comandă. Pentru aceasta se utilizează comanda `docker run`:

| command | docker container run |
| ------- | -------------------- |
| _alias_ | docker run           |

La pornirea containerului se execută comanda, specificată în fișierul `Dockerfile` cu ajutorul unei din directivelor `CMD` sau `ENTRYPOINT`. Dacă este necesar să se execute o altă comandă, atunci ea se specifică după numele imaginii:

```bash
docker container run <image_name>
```

In acest caz va fi creat și pornit containerul cu un nume arbitrar pe baza imaginii `<image_name>`. Dacă imaginea nu este găsită local, atunci ea va fi descărcată din repozitor.

Pentru a porni containerul în modul daemon se utilizează opțiunea `-d`:

```bash
docker run -d <image_name>
```

Dacă este necesar să se pornesc containerul cu un anumit nume, atunci se utilizează opțiunea `--name`:

```bash
docker run -d --name <container_name> <image_name>
```

In acest caz va fi creat și pornit containerul cu un nume `<container_name>` pe baza imaginii `<image_name>`.

## Comunicarea cu containerul

| command | docker container exec |
| ------- | --------------------- |
| _alias_ | docker exec           |

Comunicarea cu containerul se poate face doar cu containerul pornit. Pentru aceasta este necesar să se cunoască numele sau identificatorul containerului. Numele containerului se poate specifica la crearea containerului cu ajutorul opțiunii `--name`, iar identificatorul containerului se poate afla cu ajutorul comenzii `docker ps`.

Pentru a executa comanda în interiorul containerului se poate utiliza comanda `docker exec`:

```bash
docker exec <container_name> <command>
```

## Repornirea containerului

| command | docker container restart |
| ------- | ------------------------ |
| _alias_ | docker restart           |

Pentru repornirea containerului se utilizează comanda `docker restart`. De exemplu, pentru repornirea containerului cu numele `my_container` se utilizează următoarea comandă:

```bash
docker restart my_container
```

## Copierea fișierelor

| command | docker container cp |
| ------- | ------------------- |
| _alias_ | docker cp           |

Pentru copierea fișierelor se utilizează comanda `docker cp`. Sintaxa generală a comenzii `docker cp` arată în felul următor:

```bash
docker cp <source> <destination>
```

De exemplu, pentru copierea fișierului `file.txt` din containerul cu numele `my_container` în directorul curent se utilizează următoarea comandă:

```bash
docker cp my_container:/path/to/file.txt .
```

În caz dacă este necesar să se copieze `file.txt` din calculator gazdă în containerul cu numele `my_container` din directorul curent se utilizează următoarea comandă:

```bash
docker cp file.txt my_container:/path/to/file.txt
```

## Citirea log-urilor containerului

| command | docker container logs |
| ------- | --------------------- |
| _alias_ | docker logs           |

Pentru a citi log-urile containerului se utilizează comanda `docker logs`. De exemplu, pentru a citi log-urile containerului cu numele `my_container` se utilizează următoarea comandă:

```bash
docker logs my_container
```

Dacă este necesar să se vizualizeze log-urile în timp real, atunci se utilizează opțiunea `-f`:

```bash
docker logs -f my_container
```

## Vizualizarea containerelor

| command | docker container ls   |
| ------- | --------------------- |
| _alias_ | docker ps             |
|         | docker container list |
|         | docker container ps   |

Pentru vizualizarea containerelor pornite se utilizează comanda `docker ps`:

```bash
docker ps
```

Afișarea comenzii va conține următoarele coloane:

- `CONTAINER ID` - identificatorul containerului
- `IMAGE` - numele imaginii in baza căreia a fost creat containerul
- `COMMAND` - comanda, pornită în container
- `CREATED` - data creării containerului
- `STATUS` - starea containerului
- `PORTS` - porturile legate la container
- `NAMES` - numele containerului

Daca este necesar să se vizualizeze toate containerele, inclusiv cele oprite, atunci se utilizează opțiunea `-a`:

```bash
docker ps -a
```

## Oprirea containerului

| command | docker container stop |
| ------- | --------------------- |
| _alias_ | docker stop           |

Pentru oprirea containerului se utilizează comanda `docker stop`:

```bash
docker stop <container_name>
```

Cu o comanda se poate opri simultan mai multe containere, pentru aceasta este necesar să se enumere numele lor prin spațiu:

```bash
docker stop <container_name_1> <container_name_2> <container_name_3>
```

## Stergerea containerului

| command | docker container rm     |
| ------- | ----------------------- |
| _alias_ | docker rm               |
|         | docker container remove |

Pentru ștergerea containerului se utilizează comanda `docker rm`:

```bash
docker rm <container_name>
```

Cu o comanda se poate șterge simultan mai multe containere, pentru aceasta este necesar să se enumere numele lor prin spațiu:

```bash
docker rm <container_name_1> <container_name_2> <container_name_3>
```

## Bibliografie

1. [How do I run a container?, docker.com](https://docs.docker.com/guides/walkthroughs/run-a-container/)
2. [Getting started guide, docker.com](https://docs.docker.com/get-started/)
3. [Запуск контейнера Docker, losst.pro, 2020](https://losst.pro/zapusk-kontejnera-docker)

## Întrebări de autocontrol

