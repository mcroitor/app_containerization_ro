# Interacțiunea containerelor

- [Interacțiunea containerelor](#interacțiunea-containerelor)
  - [Sistemul de fișiere](#sistemul-de-fișiere)
    - [Lucrul cu volume](#lucrul-cu-volume)
    - [Montarea volumului la container](#montarea-volumului-la-container)
    - [Exemplu de interacțiune prin sistemul de fișiere](#exemplu-de-interacțiune-prin-sistemul-de-fișiere)
  - [Rețea](#rețea)
    - [Gestionarea rețelelor în Docker](#gestionarea-rețelelor-în-docker)
    - [Lansarea containerelor în rețea](#lansarea-containerelor-în-rețea)
  - [Bibliografie](#bibliografie)

Sistemele informaționale complexe sunt de obicei formate din mai multe componente. Fiecare componentă poate fi dezvoltată și întreținută de o echipă separată. În astfel de cazuri, este important să se asigure interacțiunea între componente.

Interacțiunea containerelor poate fi realizată prin rețea sau prin sistemul de fișiere.

## Sistemul de fișiere

Containerul reprezintă un mediu izolat în care rulează aplicația. La fiecare lansare a containerului, aplicația primește același sistem de fișiere, aceeași configurație, același mediu. Pentru ca containerele să poată păstra date între mai multe lansări, este necesar să se utilizeze sistemul de fișiere al gazdei sau un sistem de gestionare a containerelor.

Două containere pot interacționa prin sistemul de fișiere dacă montează același volum. De exemplu, containerul `A` poate scrie un fișier în volum, iar containerul `B` poate citi acel fișier. În acest caz, containerele pot interacționa chiar dacă sunt lansate în rețele diferite.

### Lucrul cu volume

Volumele în Docker reprezintă un mecanism pentru stocarea datelor, care poate fi utilizat de mai multe containere. Volumele pot fi create, vizualizate, șterse și montate la container.

Pentru lucrul cu volume se folosesc următoarele comenzi:

- `docker volume create <VOLUM>` – creează un volum cu numele `<VOLUM>`
- `docker volume ls` – afișează lista volumelor
- `docker volume rm <VOLUM>` – șterge volumul cu numele `<VOLUM>`
- `docker volume inspect <VOLUM>` – afișează informații despre volumul `<VOLUM>`
- `docker volume prune` – șterge toate volumele neutilizate

### Montarea volumului la container

Pentru montarea volumului la container se folosește opțiunea `-v` a comenzii `docker container run`. De exemplu, pentru a monta volumul cu numele `opt` la containerul `mycontainer`, se folosește comanda:

```bash
docker container run -v opt:/opt --name mycontainer myimage
```

În acest caz, volumul `opt` va fi disponibil în containerul `mycontainer` la calea `/opt`.

### Exemplu de interacțiune prin sistemul de fișiere

Să analizăm un exemplu în care un container scrie la fiecare 5 secunde un număr aleator într-un fișier, iar alt container citește acest fișier și afișează conținutul în consolă. Pentru containerul de scriere, `dockerfile.write` arată astfel:

```Dockerfile
FROM debian:latest

ARG TIMEOUT=5
ENV TIMEOUT=${TIMEOUT}

VOLUME [ "/opt" ]

CMD ["sh", "-c", "while true; do shuf -i1-10 -n1 > /opt/data.txt; sleep ${TIMEOUT}; done"]
```

Pentru containerul de citire, `dockerfile.read` arată astfel:

```Dockerfile
FROM debian:latest

ARG TIMEOUT=5
ENV TIMEOUT=${TIMEOUT}

VOLUME [ "/opt" ]

CMD ["sh", "-c", "while true; do cat /opt/data.txt; sleep ${TIMEOUT}; done"]
```

Mai întâi, se creează volumul comun `opt`:

```bash
docker volume create opt
```

Apoi se construiesc ambele imagini:

```bash
docker image build -t read -f dockerfile.read .
docker image build -t write -f dockerfile.write .
```

Se lansează containerele:

```bash
docker container run -d -v opt:/opt --name write write
docker container run -d -v opt:/opt --name read read
```

## Rețea

Două containere pot interacționa prin rețea. În Docker, rețeaua reprezintă un mecanism pentru comunicarea între containere. Rețelele pot fi create, vizualizate, șterse, iar containerele pot fi conectate la rețea.

### Gestionarea rețelelor în Docker

Pentru lucrul cu rețele se folosesc următoarele comenzi:

- `docker network create <REȚEA>` – creează o rețea cu numele `<REȚEA>`
- `docker network ls` – afișează lista rețelelor
- `docker network rm <REȚEA>` – șterge rețeaua cu numele `<REȚEA>`
- `docker network inspect <REȚEA>` – afișează informații despre rețeaua `<REȚEA>`
- `docker network connect <REȚEA> <CONTAINER>` – conectează containerul `<CONTAINER>` la rețeaua `<REȚEA>`
- `docker network disconnect <REȚEA> <CONTAINER>` – deconectează containerul `<CONTAINER>` de la rețeaua `<REȚEA>`
- `docker network prune` – șterge toate rețelele neutilizate

### Lansarea containerelor în rețea

Există două modalități de a lansa containere în rețea:

- conectarea containerului la rețea după lansare;
- conectarea containerului la rețea la lansare.

În primul caz se folosește comanda `docker network connect`, iar în al doilea – opțiunea `--network` a comenzii `docker container run`.

Să presupunem că avem două containere, `frontend` și `backend`, și dorim ca acestea să funcționeze în aceeași rețea `local`. Este necesar:

- să creăm rețeaua `local`;
- să lansăm containerul `backend` în rețeaua `local`;
- să lansăm containerul `frontend` în rețeaua `local`.

```bash
docker network create local
docker container run -d --name backend --network local backend
docker container run -d --name frontend --network local frontend
```

## Bibliografie

1. [Șvalov A., Stocarea datelor în Docker, Slurm](https://slurm.io/blog/tpost/i5ikrm9fj1-hranenie-dannih-v-docker)
2. [Docker Networking, Docker](https://docs.docker.com/network/)
3. [Docker Volumes, Docker](https://docs.docker.com/storage/volumes/)
