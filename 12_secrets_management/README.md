# Gestionarea secretelor

- [Gestionarea secretelor](#gestionarea-secretelor)
  - [Metode de bază a securității](#metode-de-bază-a-securității)
  - [Utilizarea secretelor în Docker](#utilizarea-secretelor-în-docker)
  - [Utilizarea secretelor în Docker Compose](#utilizarea-secretelor-în-docker-compose)
    - [Exemplu simplu](#exemplu-simplu)
    - [Exemplu cu variabile de mediu](#exemplu-cu-variabile-de-mediu)
  - [Bibliografie](#bibliografie)

## Metode de bază a securității

Administratorii de sistem deseori neglijează aspecte importante ale securității: de exemplu, restricționarea privilegiilor și configurarea politicilor de securitate [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) și [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

Se recomandă să faceți cunoștință cu aceste documente.

La crearea și desfășurarea containerelor, securitatea trebuie să fie integrată în etapa de configurare. Utilizarea practicilor sigure la scrierea fișierelor Dockerfile și Docker Compose va ajuta la evitarea vulnerabilităților comune.

*Minimizarea privilegiilor* este un aspect critic al securității containerelor. Vulnerabilitățile pot apărea, deoarece Docker rulează containerele cu un set de privilegii de bază, care include permisiunile de bază Linux. Este întotdeauna recomandat să se prefere containerele fără root, care sunt rulate în numele unui utilizator obișnuit. Acest lucru minimizează riscul ca un atacator să obțină acces root, chiar dacă reușește să compromită containerul. Utilizarea containerelor care nu necesită drepturi de superutilizator face atacurile la nivelul nucleului practic imposibile și îmbunătățește securitatea generală a sistemului.

*Network Policies* sunt o parte esențială a securității containerelor, în special în medii complexe. Izolarea containerelor prin setările de rețea ajută la prevenirea accesului neautorizat și a scurgerilor de date. Docker suportă izolarea prin rețele, ceea ce permite controlul asupra interacțiunii între containere. *Network Policies* oferă un nivel mai detaliat de control al traficului între module. De exemplu, se poate configura o politică care limitează traficul de intrare doar de la modulele specifice, creând astfel un nivel suplimentar de protecție.

*Ascunderea informațiilor confidențiale* este un aspect important al securității containerelor. Secretele, cum ar fi parolele, cheile API și alte date confidențiale, trebuie să fie stocate într-un loc sigur și transmise containerelor doar atunci când este necesar.

**Secrete** în domeniul IT se referă la informații necesare pentru a obține acces, cum ar fi parolele sau cheile (de asemenea, pot fi nume de utilizator sau date confidențiale) și necesită ascundere.

Utilizarea secretelor în imagini și containere Docker poate fi realizată în mai multe moduri:

- variabile de sistem - cel mai simplu mod de a transmite secrete în container și cel mai nesigur. Variabilele de sistem sunt vizibile în interiorul containerului și pot fi ușor citite din interiorul containerului sau din exterior.
- Docker Secrets - specific inițial pentru Docker Swarm, dar deja poate fi utilizat și în Docker Compose. Secretele sunt stocate în formă criptată pe nodurile clusterului și sunt transmise containerelor în formă criptată. Secretele sunt disponibile doar pentru serviciile care le solicită.
- utilizarea BuildKit și a mecanismului de construire a secretelor. Secretele pot fi transmise în container în timpul construirii imaginii. Secretele sunt stocate în formă criptată și nu sunt disponibile în timpul execuției containerului.
- stocarea completă a secretelor, cum ar fi HashiCorp Vault, AWS Secrets Manager, Azure Key Vault și Google Cloud Secret Manager.

## Utilizarea secretelor în Docker

Una dintre cele mai simple metode de a transmite secrete în containere este utilizarea variabilelor de sistem. Pentru aceasta, trebuie să creați o imagine de container cu descrierea variabilei de mediu care va conține secretul. Exemplu Dockerfile:

```Dockerfile
FROM alpine
ENV SECRET=supersecret
```

Acum, după construirea imaginii, variabila de mediu SECRET va fi disponibilă în interiorul containerului la pornire:

```bash
docker image build -t myimage .
```

Definirea variabilei de sistem în Dockerfile nu este sigură, deoarece citirea variabilei de sistem din imagine poate fi efectuată cu ajutorul comenzii `docker image inspect` sau `docker image history`.

De exemplu, executarea comenzii `docker image inspect` pe imagine va returna următorul rezultat:

```bash
docker image inspect myimage
...
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "SECRET=supersecret"
            ],
...
```

Totodată, variabilele de sistem pot fi citite din container:

```bash
docker container run -it -e SECRET=anothersecret --rm myimage sh -c 'echo $SECRET'
anothersecret
```

Păstrarea secretelor în variabilele de mediu este o metodă populară, dar nu cea mai sigură. Secretele pot fi citite din imagine sau din container, ceea ce le face vulnerabile la atacuri. Prin urmare, este categoric nerecomandat să declarați secrete în Dockerfile. De asemenea, trebuie să fiți siguri că nu există acces la container.

## Utilizarea secretelor în Docker Compose

Pentru a lucra cu secretele (Docker Secrets) în Docker Compose se utilizează un element special `secrets`, care permite stocarea secretelor în formă criptată. În acest caz, secretele pot fi transmise containerelor prin variabile de mediu sau fișiere.

Secretele se montoriază în container în formă de fișiere, care sunt plasate în directorul `/run/secrets/`. De exemplu, secretul `mysecret` va fi disponibil în container la calea `/run/secrets/mysecret`.

Transmiterea (declararea) secretului în container are loc în două etape:

- declarația secretului în fișierul docker-compose.yml, în elementul `secrets` de nivel superior;
- specificarea secretului în configurația serviciului, în elementul `secrets`.

Spre deosebire de la alte metode, Docker Secrets nu sunt vizibile în imagine și nu pot fi citite din container. De asemenea, acest mod permite restricționarea accesului la secrete prin permisiunile standard ale sistemului de fișiere.

### Exemplu simplu

În acest exemplu, se arată cum să transmite un secret în container și să citește din fișier.

```yaml
services:
  myservice:
    image: alpine
    secrets:
      - my_secret
    command: sh -c 'cat /run/secrets/my_secret'

secrets:
  my_secret:
    file: ./my_secret.txt
```

### Exemplu cu variabile de mediu

În acest exemplu se recomandă să atrageți atenția asupra convenției de denumire a variabilelor de mediu. Unele imagini de containere, inclusiv `mysql`, `mariadb` sau `postgres`, definesc variabile de mediu cu sufixul `_FILE`, care indică un fișier care conține valoarea variabilei de mediu. De exemplu, `MYSQL_ROOT_PASSWORD_FILE` indică un fișier care conține parola root pentru MySQL.

```yaml
services:
  mariadb:
    image: mariadb:latest
    volumes:
      - mariadb_data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD_FILE: /run/secrets/mysql_root_password
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD_FILE: /run/secrets/mysql_password
    secrets:
      - mysql_root_password
      - mysql_password
  wordpress:
    image: wordpress:latest
    environment:
      WORDPRESS_DB_HOST: mariadb
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD_FILE: /run/secrets/mysql_password
      WORDPRESS_DB_NAME: wordpress
    secrets:
      - mysql_password
    ports:
      - 8080:80
    depends_on:
      - mariadb

secrets:
  mysql_root_password:
    environment: MYSQL_ROOT_PASSWORD
  mysql_password:
    environment: MYSQL_PASSWORD

volumes:
  mariadb_data: {}
```

## Bibliografie

1. [techno_mot, Обзор способов защиты контейнеров Docker: от простого к сложному, habr.com, 2024-11-13](https://habr.com/ru/companies/selectel/articles/854850/)
2. [Kubernetes, Pod Security Standards, kubernetes.io](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
3. [Kubernetes, Network Policies, kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
4. [How to use secrets in Docker Compose, docker.com](https://docs.docker.com/compose/how-tos/use-secrets/)
