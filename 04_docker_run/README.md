# Lansarea aplicațiilor containerizate

- [Lansarea aplicațiilor containerizate](#lansarea-aplicațiilor-containerizate)
  - [Instrumente Docker](#instrumente-docker)
  - [Construirea imaginii](#construirea-imaginii)
  - [Vizualizarea imaginilor existente](#vizualizarea-imaginilor-existente)
  - [Ștergerea imaginii](#ștergerea-imaginii)
  - [Crearea containerului](#crearea-containerului)
  - [Lansarea containerului](#lansarea-containerului)
  - [Interacțiunea cu containerul](#interacțiunea-cu-containerul)
  - [Repornirea containerului](#repornirea-containerului)
  - [Copierea fișierelor](#copierea-fișierelor)
  - [Vizualizarea logurilor containerului](#vizualizarea-logurilor-containerului)
  - [Vizualizarea containerelor](#vizualizarea-containerelor)
  - [Oprirea containerului](#oprirea-containerului)
  - [Ștergerea containerului](#ștergerea-containerului)
  - [Bibliografie](#bibliografie)

Containerele sunt instanțe ale imaginilor. Containerele pot fi lansate, oprite, mutate și șterse. În această secțiune vom analiza comenzile pentru lucrul cu containerele.

## Instrumente Docker

Docker oferă un set de instrumente pentru gestionarea containerelor și a resurselor utilizate de acestea. Printre principalele instrumente Docker se numără:

- `docker image` – gestionarea imaginilor;
- `docker volume` – gestionarea volumelor;
- `docker network` – gestionarea rețelelor;
- `docker container` – gestionarea containerelor;
- `docker buildx` – gestionarea procesului de construire a imaginii;
- `docker compose` – gestionarea aplicațiilor multi-container;
- `docker system` – gestionarea resurselor Docker;
- `docker init` – generarea unui Dockerfile pe baza unui proiect existent.

Pentru a afla mai multe despre comenzile Docker, puteți folosi comanda `docker --help`, precum și `docker <command> --help`. Pentru multe comenzi există aliasuri pentru o scriere mai scurtă.

## Construirea imaginii

| comandă  | docker buildx build  |
| -------- | -------------------- |
| _alias_  | docker image build   |
|          | docker builder build |
|          | docker build         |

După ce fișierul `Dockerfile` a fost creat, puteți începe construirea imaginii. Construirea imaginii se face de obicei din linia de comandă, folosind comanda `docker image build`. Sintaxa comenzii:

```bash
docker image build [OPTIONS] PATH | URL | -
```

unde `PATH` – calea către directorul în care se află fișierul `Dockerfile`, `URL` – adresa URL a unui repository Git care conține fișierul `Dockerfile`, `-` – intrare standard.

Comanda `docker image build` are aliasul frecvent utilizat `docker build`, fiind echivalentă cu `docker buildx build`.

Dacă fișierul `Dockerfile` se află în directorul curent, pentru a construi imaginea este suficient să executați:

```bash
docker image build .
```

În acest caz, directorul curent va fi folosit ca context de construire și va fi creată o imagine cu un nume arbitrar și tag-ul `latest`. Pentru a specifica un nume și un tag pentru imagine, folosiți opțiunea `-t`:

```bash
docker image build -t myimage:1.0 .
```

Pentru a vedea toate opțiunile comenzii `docker image build`, executați:

```bash
docker image build --help
```

## Vizualizarea imaginilor existente

| comandă  | docker image ls   |
| -------- | ----------------- |
| _alias_  | docker images     |
|          | docker image list |

Pentru a vizualiza imaginile existente, folosiți comanda `docker image ls`:

```bash
docker image ls [OPTIONS] [REPOSITORY[:TAG]]
```

Această comandă poate fi scrisă și ca `docker images` sau `docker image list`.

Rezultatul comenzii va conține următoarele coloane:

- `REPOSITORY` – numele imaginii, inclusiv numele repository-ului
- `TAG` – tag-ul imaginii
- `IMAGE ID` – identificatorul imaginii
- `CREATED` – data creării imaginii
- `SIZE` – dimensiunea imaginii

## Ștergerea imaginii

| comandă  | docker image rm     |
| -------- | ------------------- |
| _alias_  | docker rmi          |
|          | docker image remove |

Pentru a șterge o imagine, folosiți comanda `docker image rm`:

```bash
docker image rm [OPTIONS] <image_name> [<image_name>...]
```

Unde `<image_name>` este identificatorul sau numele imaginii. Comanda are aliasurile: `docker rmi` și `docker image remove`.

Puteți șterge mai multe imagini cu o singură comandă, specificând numele lor separate prin spațiu:

```bash
docker image rm <image_name_1> <image_name_2> <image_name_3>
```

## Crearea containerului

| comandă  | docker container create |
| -------- | ----------------------- |
| _alias_  | docker create           |

Pe baza unei imagini existente puteți crea un container cu comanda `docker create`:

```bash
docker container create [OPTIONS] <image_name> [ARG...]
```

Astfel va fi creat un container cu un nume arbitrar pe baza imaginii `<image_name>`. Comanda `docker container create` are aliasul `docker create`.

Dacă imaginea nu este găsită local, va fi descărcată din repository.

Pentru a crea un container cu un anumit nume, folosiți opțiunea `--name`:

```bash
docker container create --name <container_name> <image_name>
```

La crearea containerului puteți specifica diverse opțiuni, precum montarea volumelor, maparea porturilor, transmiterea variabilelor de mediu etc. Pentru a vedea toate opțiunile, executați:

```bash
docker container create --help
```

## Lansarea containerului

| comandă  | docker container start |
| -------- | ---------------------- |
| _alias_  | docker start           |

După ce containerul a fost creat, îl puteți lansa cu comanda `docker start`:

```bash
docker container start [OPTIONS] <container_name> [<container_name>...]
```

De multe ori, dezvoltatorii creează și lansează containerul cu o singură comandă, folosind `docker run`:

| comandă  | docker container run |
| -------- | -------------------- |
| _alias_  | docker run           |

La lansarea containerului se execută comanda specificată în fișierul `Dockerfile` prin instrucțiunile `CMD` sau `ENTRYPOINT`. Dacă doriți să executați altă comandă, aceasta se specifică după numele imaginii:

```bash
docker container run [OPTIONS] <image_name> [<command>] [<arg...>]
```

Pentru a lansa containerul în mod interactiv (de exemplu, pentru depanare), folosiți opțiunea `-it`, care combină `-i` (interactive) și `-t` (pseudo-TTY):

```bash
docker container run -it <image_name> <command>
```

De exemplu, pentru a lansa un container cu imaginea `ubuntu` în mod interactiv:

```bash
docker container run -it ubuntu /bin/bash
```

Dacă imaginea nu este găsită local, va fi descărcată din repository.

Pentru a lansa containerul în fundal, folosiți opțiunea `-d`:

```bash
docker run -d <image_name>
```

Pentru a lansa containerul cu un anumit nume, folosiți opțiunea `--name`:

```bash
docker run -d --name <container_name> <image_name>
```

Astfel va fi creat și lansat un container cu numele `<container_name>` pe baza imaginii `<image_name>`.

## Interacțiunea cu containerul

| comandă  | docker container exec |
| -------- | --------------------- |
| _alias_  | docker exec           |

Interacțiunea este posibilă doar cu un container lansat. Pentru aceasta trebuie să cunoașteți numele sau identificatorul containerului. Numele poate fi setat la crearea containerului cu opțiunea `--name`, iar identificatorul poate fi aflat cu comanda `docker container ls`.

Pentru a executa o comandă în interiorul containerului, folosiți comanda `docker container exec`:

```bash
docker container exec [OPTIONS] <container_name> <command>
```

Pentru a executa comanda în mod interactiv, folosiți opțiunea `-it`:

```bash
docker container exec -it ubuntu /bin/bash
```

## Repornirea containerului

| comandă  | docker container restart |
| -------- | ------------------------ |
| _alias_  | docker restart           |

Pentru a reporni un container, folosiți comanda `docker restart`. De exemplu, pentru a reporni containerul cu numele `my_container`:

```bash
docker container restart my_container
```

## Copierea fișierelor

| comandă  | docker container cp |
| -------- | ------------------- |
| _alias_  | docker cp           |

Pentru copierea fișierelor folosiți comanda `docker cp`. Sintaxa generală:

```bash
docker container cp <source> <destination>
```

De exemplu, pentru a copia fișierul `file.txt` din containerul `my_container` în directorul curent:

```bash
docker container cp my_container:/path/to/file.txt .
```

Pentru a copia `file.txt` din gazdă în containerul `my_container`:

```bash
docker container cp file.txt my_container:/path/to/file.txt
```

## Vizualizarea logurilor containerului

| comandă  | docker container logs |
| -------- | --------------------- |
| _alias_  | docker logs           |

Pentru a vizualiza logurile containerului, folosiți comanda `docker logs`. De exemplu, pentru containerul `my_container`:

```bash
docker container logs my_container
```

Pentru a urmări logurile în timp real, folosiți opțiunea `-f`:

```bash
docker container logs -f my_container
```

## Vizualizarea containerelor

| comandă  | docker container ls   |
| -------- | --------------------- |
| _alias_  | docker ps             |
|          | docker container list |
|          | docker container ps   |

Pentru a vizualiza containerele lansate, folosiți comanda `docker container ls`:

Rezultatul comenzii va conține următoarele coloane:

- `CONTAINER ID` – identificatorul containerului
- `IMAGE` – numele imaginii
- `COMMAND` – comanda lansată în container
- `CREATED` – data creării containerului
- `STATUS` – statusul containerului
- `PORTS` – porturile mapate
- `NAMES` – numele containerului

Pentru a vizualiza toate containerele, inclusiv cele oprite, folosiți opțiunea `-a`:

```bash
docker container ls -a
```

## Oprirea containerului

| comandă  | docker container stop |
| -------- | --------------------- |
| _alias_  | docker stop           |

Pentru a opri un container, folosiți comanda `docker container stop`:

```bash
docker container stop <container_name>
```

Puteți opri mai multe containere cu o singură comandă, specificând numele lor separate prin spațiu:

```bash
docker container stop <container_name_1> <container_name_2> <container_name_3>
```

## Ștergerea containerului

| comandă  | docker container rm     |
| -------- | ----------------------- |
| _alias_  | docker rm               |
|          | docker container remove |

Pentru a șterge un container, folosiți comanda `docker container rm`:

```bash
docker container rm <container_name>
```

Puteți șterge mai multe containere cu o singură comandă, specificând numele lor separate prin spațiu:

```bash
docker container rm <container_name_1> <container_name_2> <container_name_3>
```

## Bibliografie

1. [How do I run a container?, docker.com](https://docs.docker.com/guides/walkthroughs/run-a-container/)
2. [Getting started guide, docker.com](https://docs.docker.com/get-started/)
3. [Lansarea unui container Docker, losst.pro, 2020](https://losst.pro/zapusk-kontejnera-docker)
4. [Docker CLI, docker.com](https://docs.docker.com/reference/cli/docker/)
