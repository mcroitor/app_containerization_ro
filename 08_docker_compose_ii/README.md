# Particularități de configurare a unui cluster de containere

- [Particularități de configurare a unui cluster de containere](#particularități-de-configurare-a-unui-cluster-de-containere)
  - [Argumente la construirea imaginii](#argumente-la-construirea-imaginii)
  - [Variabile de mediu](#variabile-de-mediu)
  - [Limitarea resurselor](#limitarea-resurselor)
  - [Acces la procesorul grafic](#acces-la-procesorul-grafic)
  - [Verificarea stării containerului](#verificarea-stării-containerului)
  - [Bibliografie](#bibliografie)

## Argumente la construirea imaginii

Așa cum a fost menționat la descrierea Dockerfile, la construirea imaginii se pot transmite argumente. Acest lucru permite controlul procesului de construire a imaginii, de exemplu, transmiterea versiunii aplicației sau a altor parametri. În Docker Compose, argumentele pot fi setate în fișierul `docker-compose.yml` folosind cheia `build.args`:

```yaml
services:
  web:
    build:
      context: .
      args:
        - APP_VERSION=1.0.0
```

## Variabile de mediu

La lansarea unui serviciu, în container se pot transmite variabile de mediu. Acest lucru permite controlul comportamentului containerului, de exemplu, transmiterea parametrilor de conectare la baza de date sau alți parametri.

În Docker Compose, variabilele de mediu pot fi transmise în fișierul `docker-compose.yml` folosind cheia `environment`:

```yaml
services:
  web:
    image: myapp:latest
    environment:
      - DB_HOST=db
      - DB_PORT=5432
```

Variabilele de mediu pot fi setate și sub formă de dicționar:

```yaml
services:
  web:
    image: myapp:latest
    environment:
      DB_HOST: db
      DB_PORT: 5432
```

Nu este întotdeauna comod să păstrați variabilele de mediu direct în fișierul `docker-compose.yml`. De aceea, acestea sunt deseori plasate într-un fișier separat. Dacă variabilele de mediu sunt definite în fișierul `.env`, Docker Compose le va prelua automat în fișierul `docker-compose.yml`.

Exemplu de fișier `.env`:

```env
DB_HOST=db
DB_PORT=5432
```

Acum, în fișierul `docker-compose.yml`, puteți utiliza variabilele de mediu:

```yaml
services:
  web:
    image: myapp:latest
    environment:
      - DB_HOST=${DB_HOST}
      - DB_PORT=${DB_PORT}
```

De asemenea, puteți specifica fișierul cu variabile de mediu în `docker-compose.yml` folosind cheia `env_file`, și puteți indica mai multe fișiere:

```yaml
services:
  web:
    image: myapp:latest
    env_file:
      - .env
      - runtime.env
```

Trebuie să țineți cont că variabilele de mediu definite direct în `docker-compose.yml` suprascriu variabilele din fișierul `.env`.

În plus, nu se recomandă păstrarea parolelor și a altor date sensibile în fișierul `.env`. Pentru stocarea datelor sensibile se recomandă utilizarea Docker Secrets sau alte instrumente de gestionare a secretelor.

## Limitarea resurselor

Implicit, containerele din Docker Compose au acces la toate resursele gazdei. Acest acces nelimitat poate duce la lipsa de resurse pentru alte containere și, implicit, la competiție pentru resurse. Setarea limitelor explicite pentru resurse permite evitarea acestor probleme.

Pentru un container se poate limita accesul la memorie și procesor. În Docker Compose acest lucru se face cu cheia `deploy.resources`:

```yaml
services:
  web:
    image: myapp:latest
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 1G
        reservations:
          cpus: '0.1'
          memory: 0.5G
```

În acest exemplu, containerul `web` are acces la maximum 0.5 CPU și 1 GB memorie. La lansare, pentru container se rezervă minimum 0.1 CPU și 0.5 GB memorie.

## Acces la procesorul grafic

Pentru un container se poate defini accesul la procesorul grafic (GPU). În Docker Compose acest lucru se face cu cheia `deploy.resources`:

```yaml
services:
  neural_network:
    image: neuwrl:latest
    deploy:
      resources:
        reservations:
          devices:
            - capabilities: [gpu]
              count: 1
              driver: nvidia
```

Acest exemplu indică faptul că pentru containerul `neural_network` este necesar acces la procesorul grafic. Se rezervă 1 GPU, iar pentru lucru cu GPU se folosește driverul `nvidia`.

În prezent, sunt acceptați următorii parametri pentru `capabilities`:

- `gpu` – acces la procesorul grafic;
- `tpu` – acces la procesorul tensorial;

Pot fi utilizați și alți parametri pentru `capabilities`, în funcție de driverul specific al procesorului grafic, de exemplu, pentru utilizarea acceleratorului CUDA cu driverul `nvidia` se poate folosi parametrul `nvidia-compute`.

## Verificarea stării containerului

Se poate verifica starea containerului după lansare. De exemplu, se poate verifica dacă containerul a pornit cu succes și este gata de lucru. În Docker Compose acest lucru se face cu cheia `healthcheck`:

```yaml
services:
  web:
    image: myapp:latest
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 30s
      timeout: 10s
      retries: 3
```

După lansarea acestui cluster de containere, Docker Compose va verifica starea serviciului `web` folosind comanda `curl -f http://localhost` la fiecare 30 de secunde. Dacă containerul nu răspunde în 10 secunde, Docker Compose va repeta verificarea de 3 ori. Dacă containerul nu răspunde după 3 încercări, Docker Compose îl va reporni.

Uneori serviciile din containere încearcă să utilizeze mai multe resurse decât au disponibile. În acest caz poate apărea eroarea `OOME` (Out Of Memory Error). Pentru a preveni această eroare, se pot utiliza reguli de repornire a containerului:

```yaml
services:
  web:
    image: myapp:latest
    deploy:
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
        window: 120s
```

În acest exemplu, containerul va fi repornit în caz de eroare `OOME` de maximum 3 ori, cu un interval de 5 secunde. Dacă containerul nu pornește după 3 încercări, Docker Compose îl va opri și va afișa un mesaj de eroare. Condițiile de repornire pot fi:

- `none` – containerul nu va fi repornit;
- `on-failure` – containerul va fi repornit în caz de eroare;
- `any` – containerul va fi repornit în orice caz.

## Bibliografie

1. [Docker Compose file reference](https://docs.docker.com/compose/compose-file/)
