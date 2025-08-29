# Managementul secretelor

- [Managementul secretelor](#managementul-secretelor)
  - [Metode de bază pentru protecție](#metode-de-bază-pentru-protecție)
  - [Utilizarea secretelor în Docker](#utilizarea-secretelor-în-docker)
  - [Utilizarea secretelor în docker-compose](#utilizarea-secretelor-în-docker-compose)
    - [Exemplu simplu](#exemplu-simplu)
    - [Exemplu cu utilizarea variabilelor de mediu](#exemplu-cu-utilizarea-variabilelor-de-mediu)
  - [Bibliografie](#bibliografie)

## Metode de bază pentru protecție

Administratorii de sistem omit adesea aspecte importante ale securității: de exemplu, limitarea privilegiilor și configurarea politicilor de securitate [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) și [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

Este recomandat să consultați aceste documente.

La crearea și lansarea containerelor, securitatea trebuie să fie asigurată încă din etapa de configurare. Utilizarea practicilor sigure la scrierea fișierelor Dockerfile și Docker Compose ajută la evitarea vulnerabilităților comune.

*Minimizarea privilegiilor* — este un aspect critic al securității containerelor. Vulnerabilitățile pot apărea deoarece Docker, implicit, lansează containerele cu un set de privilegii de bază, inclusiv permisiuni esențiale Linux. Se recomandă întotdeauna utilizarea containerelor rootless, care rulează sub un utilizator obișnuit. Acest lucru minimizează riscul ca un atacator să obțină acces root, chiar dacă compromite containerul. Utilizarea containerelor fără drepturi de superutilizator face practic imposibile atacurile la nivel de kernel și crește securitatea generală a sistemului.

*Network Policies* joacă un rol cheie în securitatea containerelor, mai ales în medii complexe. Izolarea containerelor prin configurarea rețelei ajută la prevenirea accesului neautorizat și a scurgerii de date. Docker suportă izolarea prin rețele, permițând controlul asupra containerelor care pot interacționa între ele. *Network Policies* oferă un nivel mai detaliat de control al traficului între poduri. De exemplu, se poate configura o politică care limitează traficul de intrare doar de la anumite poduri, creând astfel un nivel suplimentar de protecție.

*Ascunderea informațiilor confidențiale* — este un aspect important al securității containerelor. Secretele, precum parolele, cheile API și alte date confidențiale, trebuie stocate în siguranță și transmise către containere doar când este necesar.

**Secretele** în IT reprezintă informații necesare pentru acces, precum parole sau chei (pot fi și logini sau orice date confidențiale) și trebuie ascunse. Secretele pot fi statice (de exemplu, parole) sau dinamice (de exemplu, token-uri de acces).

Utilizarea secretelor în imagini și containere Docker se poate face prin mai multe metode:

- variabile de mediu — metodă simplă, dar nesigură, de transmitere a secretelor în container. Variabilele de mediu sunt vizibile în interiorul containerului și pot fi citite ușor din interior sau din exterior, dacă există acces la container.
- Docker Secrets — specific pentru Docker Swarm (poate fi folosit și cu Docker Compose). Secretele sunt stocate criptat pe nodurile clusterului și transmise criptat către containere. Secretele sunt disponibile doar pentru serviciile care le solicită.
- utilizarea BuildKit și mecanismului de build pentru secrete. Secretele pot fi transmise în container în timpul build-ului imaginii. Secretele sunt stocate criptat și nu sunt disponibile la rularea containerului.
- soluții dedicate de management al secretelor, precum HashiCorp Vault, AWS Secrets Manager, Azure Key Vault și Google Cloud Secret Manager.

## Utilizarea secretelor în Docker

Una dintre cele mai simple metode de transmitere a secretelor în container este utilizarea variabilelor de mediu. Pentru aceasta, se creează o imagine de container cu o variabilă de mediu care va conține secretul. Exemplu de Dockerfile:

```Dockerfile
FROM alpine
ENV SECRET=supersecret
```

După build-ul imaginii, variabila de mediu SECRET va fi disponibilă în container la rulare:

```bash
docker image build -t myimage .
```

Definirea variabilei de mediu în Dockerfile este nesigură, deoarece variabila poate fi citită din imagine cu ajutorul comenzilor `docker image inspect` sau `docker image history`.

De exemplu, dacă executați comanda `docker inspect` pe imagine, veți obține:

```bash
docker image inspect myimage
...
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "SECRET=supersecret"
            ],
...
```

De asemenea, variabilele de mediu pot fi citite din container:

```bash
docker container run -it -e SECRET=anothersecret --rm myimage sh -c 'echo $SECRET'
anothersecret
```

Stocarea secretelor în variabile de mediu este o metodă populară, dar nu foarte sigură. Secretele pot fi citite din imagine sau container, ceea ce le face vulnerabile la atacuri. De aceea, nu se recomandă declararea secretelor în Dockerfile. În plus, trebuie să vă asigurați că nu există acces la container.

## Utilizarea secretelor în docker-compose

Pentru gestionarea secretelor în docker-compose se folosește secțiunea specială `secrets`, care permite stocarea secretelor în formă criptată. Secretele pot fi transmise către containere prin variabile de mediu sau fișiere.

Secretele sunt montate în container sub formă de fișiere, în directorul `/run/secrets/`. De exemplu, secretul `mysecret` va fi disponibil în container la calea `/run/secrets/mysecret`.

Transmiterea unui secret către container presupune două etape:

- declararea secretului în configurația docker-compose.yml, la nivelul de bază `secrets`;
- indicarea secretului în configurația serviciului, în secțiunea `secrets`.

Spre deosebire de alte metode, Docker Secrets nu sunt vizibile în imagine și nu pot fi citite din container. În plus, această metodă permite limitarea accesului la secrete prin permisiunile sistemului de fișiere.

### Exemplu simplu

În primul exemplu se arată cum se transmite un secret către container și cum se citește din fișier.

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

### Exemplu cu utilizarea variabilelor de mediu

În acest exemplu trebuie acordată atenție convenției de denumire a variabilelor de mediu. Unele imagini de containere, inclusiv `mysql`, `mariadb` sau `postgres`, definesc variabile de mediu cu sufixul `_FILE`, care indică fișierul ce conține valoarea variabilei de mediu. De exemplu, `MYSQL_ROOT_PASSWORD_FILE` indică fișierul cu parola root pentru MySQL.

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

1. [techno_mot, Prezentare metode de protecție a containerelor Docker: de la simplu la complex, habr.com, 2024-11-13](https://habr.com/ru/companies/selectel/articles/854850/)
2. [Kubernetes, Pod Security Standards, kubernetes.io](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
3. [Kubernetes, Network Policies, kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
4. [How to use secrets in Docker Compose, docker.com](https://docs.docker.com/compose/how-tos/use-secrets/)
