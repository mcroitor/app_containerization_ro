# Sintaxa Dockerfile

- [Sintaxa Dockerfile](#sintaxa-dockerfile)
  - [Docker](#docker)
  - [Dockerfile](#dockerfile)
  - [Instrucțiuni Dockerfile](#instrucțiuni-dockerfile)
    - [FROM](#from)
    - [COPY](#copy)
    - [ADD](#add)
    - [RUN](#run)
    - [CMD](#cmd)
    - [ENTRYPOINT](#entrypoint)
    - [WORKDIR](#workdir)
    - [USER](#user)
  - [Bibliografie](#bibliografie)

## Docker

**Docker** este un software pentru automatizarea implementării și gestionării aplicațiilor într-un mediu de virtualizare la nivelul sistemului de operare. Docker permite „împachetarea” aplicației împreună cu toate dependențele și mediul său într-un container, care poate fi transferat pe orice sistem Linux cu suport pentru `cgroups` în nucleu, și oferă un mediu pentru gestionarea containerelor.

Pentru a lucra cu Docker pe sistemele Unix / Linux este necesară instalarea [Docker Engine](https://docs.docker.com/engine/install/).

Pentru a lucra cu Docker pe Windows este necesară instalarea [Docker Desktop](https://www.docker.com/products/docker-desktop).

## Dockerfile

Imaginile Docker sunt create pe baza fișierului `Dockerfile`. În acest fișier se descrie ce comenzi trebuie executate pentru a construi imaginea. Fiecare comandă executată creează o imagine intermediară, numită *strat* (layer), care este folosită pentru crearea următoarei imagini. Crearea imaginilor intermediare permite reutilizarea lor la construirea altor imagini, ceea ce reduce semnificativ timpul de build.

Exemplu de fișier `Dockerfile`:

```dockerfile
# pe baza imaginii de bază ubuntu:18.04
FROM ubuntu:18.04

# actualizarea listei de pachete și a pachetelor
RUN apt-get update && apt-get -y upgrade
# instalarea pachetului nginx
RUN apt-get install -y nginx
# crearea fișierului index.html
RUN echo "Hello, world!" > /var/www/html/index.html

# pornirea nginx
CMD ["nginx", "-g", "daemon off;"]
```

După ce imaginea este construită, aceasta poate fi rulată pentru a obține un container.

## Instrucțiuni Dockerfile

Tabelul următor conține lista comenzilor care pot fi utilizate în fișierul `Dockerfile`.

| Comandă        | Descriere                                                                                                                                               |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `FROM`         | Specifică imaginea de bază pe care va fi creată noua imagine.                                                                                           |
| `COPY`         | Copiază fișiere și directoare din contextul de build în sistemul de fișiere al imaginii.                                                                |
| `ADD`          | Copiază fișiere și directoare din contextul de build în sistemul de fișiere al imaginii. Permite și descărcarea fișierelor din internet și dezarhivarea. |
| `RUN`          | Execută o comandă în container. Rezultatul comenzii este salvat în imagine.                                                                             |
| `CMD`          | Setează comanda care va fi executată la pornirea containerului.                                                                                         |
| `ENTRYPOINT`   | Setează comanda care va fi executată la pornirea containerului. Comanda definită în `ENTRYPOINT` nu poate fi suprascrisă la pornirea containerului.     |
| `WORKDIR`      | Setează directorul de lucru pentru comenzile `RUN`, `CMD`, `ENTRYPOINT`, `COPY` și `ADD`.                                                              |
| `USER`         | Setează utilizatorul sub care vor fi executate comenzile `RUN`, `CMD`, `ENTRYPOINT`, `COPY` și `ADD`.                                                  |
| `ENV`          | Setează variabile de mediu.                                                                                                                            |
| `ARG`          | Setează argumente care pot fi transmise la build-ul imaginii.                                                                                          |
| `EXPOSE`       | Deschide porturi pentru interacțiunea cu containerul.                                                                                                  |
| `VOLUME`       | Creează puncte de montare pentru interacțiunea cu containerul.                                                                                         |
| `SHELL`        | Setează shell-ul care va fi folosit pentru executarea comenzilor `RUN`, `CMD`, `ENTRYPOINT`, `COPY` și `ADD`.                                         |
| `MAINTAINER`   | Setează numele și adresa de email a autorului imaginii.                                                                                                |
| `LABEL`        | Setează metadate pentru imagine.                                                                                                                       |
| `ONBUILD`      | Setează comenzi care vor fi executate la build-ul imaginii pe baza acesteia.                                                                           |
| `HEALTHCHECK`  | Setează comanda care va fi executată pentru verificarea stării containerului.                                                                          |
| `STOPSIGNAL`   | Setează semnalul care va fi trimis containerului pentru oprire.                                                                                        |

De asemenea, în fișierul `Dockerfile` se pot folosi comentarii care încep cu simbolul `#`.

### FROM

Fiecare imagine nouă se creează pe baza unei imagini de bază. Imaginea de bază se specifică în comanda `FROM`. De exemplu, următoarea comandă va crea o imagine pe baza imaginii de bază `ubuntu:18.04`.

```dockerfile
FROM ubuntu:18.04
```

Imaginea creată va conține setul minim de fișiere necesare pentru funcționarea sistemului de operare Ubuntu 18.04.

Imaginea de bază trebuie să fie specificată pe prima linie din fișierul `Dockerfile`. Dacă nu se specifică o imagine de bază, va fi folosită imaginea `scratch`, care nu conține niciun fișier, echivalent cu `FROM scratch`.

Pentru imaginea de bază se poate specifica un tag care corespunde unei versiuni anume. **Tag-ul** este o etichetă text care indică, de exemplu, versiunea imaginii sau caracteristicile acesteia. Dacă nu se specifică tag-ul, va fi folosit tag-ul `latest`, care indică mereu ultima versiune construită a imaginii.

### COPY

Comanda `COPY` copiază fișiere și directoare din contextul de build în sistemul de fișiere al imaginii. **Contextul de build** este directorul în care se află fișierul `Dockerfile`. Sintaxa comenzii `COPY`:

```dockerfile
COPY <src> <dest>
```

unde `<src>` este calea către fișierul sau directorul din contextul de build, iar `<dest>` este calea către fișierul sau directorul din sistemul de fișiere al imaginii.

### ADD

Comanda `ADD` copiază fișiere și directoare din contextul de build în sistemul de fișiere al imaginii. Permite și descărcarea fișierelor din internet și dezarhivarea arhivelor. Sintaxa comenzii `ADD`:

```dockerfile
ADD <src> <dest>
```

unde `<src>` este calea către fișierul sau directorul din contextul de build, iar `<dest>` este calea către fișierul sau directorul din sistemul de fișiere al imaginii. Dacă `<src>` este o adresă URL, fișierul va fi descărcat din internet. Dacă `<src>` este o arhivă, aceasta va fi dezarhivată în sistemul de fișiere al imaginii.

Comanda `ADD` funcționează după următorul algoritm:

- Calea `<src>` funcționează în directorul contextului de build, nu poate conține `..` și nu poate fi absolută.
- Dacă `<src>` este o adresă URL, fișierul va fi descărcat din internet.
- Dacă `<src>` este o arhivă locală `tar` într-unul din formatele recunoscute (gzip, bz2, xz, identity), aceasta va fi dezarhivată în sistemul de fișiere al imaginii.
- Dacă `<src>` este un director, acesta va fi copiat integral în sistemul de fișiere al imaginii, inclusiv metadatele (proprietar, permisiuni, dată modificare).
- Dacă `<src>` este un fișier, acesta va fi copiat în sistemul de fișiere al imaginii. Dacă `<dest>` este un director, fișierul va fi copiat în acel director. Dacă `<dest>` este un fișier, fișierul va fi copiat peste acel fișier.
- Dacă calea `<dest>` nu există, aceasta va fi creată.

Comanda `ADD` are mai multe funcționalități decât `COPY`, dar din motive de securitate se recomandă utilizarea comenzii `COPY` în locul comenzii `ADD`.

### RUN

Comanda `RUN` execută o comandă în container. Rezultatul comenzii este salvat în imagine. Sintaxa comenzii `RUN`:

```dockerfile
RUN <command>
```

unde `<command>` este comanda care va fi executată în container.

Exemplu de actualizare a listei de pachete și a pachetelor în imaginea Ubuntu:

```dockerfile
FROM ubuntu:18.04

RUN apt-get update && apt-get -y upgrade
```

### CMD

Comanda `CMD` setează comanda care va fi executată la pornirea containerului. Sintaxa comenzii `CMD`:

```dockerfile
CMD <command>
```

unde `<command>` este comanda care va fi executată la pornirea containerului, sau sub formă de array:

```dockerfile
CMD ["<command>", "<arg1>", "<arg2>", ...]
```

Diferența dintre execuția comenzii sub formă de string și sub formă de array este că, în cazul stringului, comanda va fi executată în shell (sh, bash), iar în cazul array-ului, comanda va fi executată direct, fără shell.

Exemplu de pornire a containerului cu comanda `echo`:

```dockerfile
FROM ubuntu:18.04

CMD echo "Hello, world!"
```

sau sub formă de array:

```dockerfile
FROM ubuntu:18.04

CMD ["echo", "Hello, world!"]
```

### ENTRYPOINT

Comanda `ENTRYPOINT` setează comanda care va fi executată la pornirea containerului. Comanda definită în `ENTRYPOINT` nu poate fi suprascrisă la pornirea containerului (totuși, parametrii comenzii pot fi completați sau suprascriși). Sintaxa comenzii `ENTRYPOINT`:

```dockerfile
ENTRYPOINT <command>
```

unde `<command>` este comanda care va fi executată la pornirea containerului, sau sub formă de array:

```dockerfile
ENTRYPOINT ["<command>", "<arg1>", "<arg2>", ...]
```

Exemplu de pornire a containerului cu comanda `echo`:

```dockerfile
FROM ubuntu:18.04

ENTRYPOINT echo "Hello, world!"
```

Diferența dintre comenzile `CMD` și `ENTRYPOINT` este că `CMD` setează comanda implicită, care poate fi suprascrisă la pornirea containerului. `ENTRYPOINT` definește procesul principal, iar `CMD` poate fi folosit pentru a-i transmite argumente.

### WORKDIR

Comanda `WORKDIR` setează directorul de lucru pentru comenzile `RUN`, `CMD`, `ENTRYPOINT`, `COPY` și `ADD`. Sintaxa comenzii `WORKDIR`:

```dockerfile
WORKDIR <path>
```

unde `<path>` este calea către directorul de lucru. Dacă directorul nu există, acesta va fi creat.

Exemplu de setare a directorului de lucru:

```dockerfile
FROM ubuntu:18.04

WORKDIR /var
CMD ["ls", "-l"]
```

### USER

Comanda `USER` setează utilizatorul sub care vor fi executate comenzile `RUN`, `CMD`, `ENTRYPOINT`, `COPY` și `ADD`. Sintaxa comenzii `USER`:

```dockerfile
USER <user>
```

unde `<user>` este numele utilizatorului. Utilizatorul trebuie să existe în imagine. Implicit, comenzile se execută cu utilizatorul `root`.

Exemplu de setare a utilizatorului:

```dockerfile
FROM ubuntu:18.04

USER root
RUN apt-get update && apt-get -y upgrade
USER user
```

Din motive de securitate, se recomandă executarea comenzilor `CMD`, `ENTRYPOINT` cu un utilizator diferit de `root`.

## Bibliografie

1. [Dockerfile reference, docker.com](https://docs.docker.com/engine/reference/builder/)
2. [olemskoi, ENTRYPOINT vs CMD: назад к основам, Слёрм, Habr.com, 2017](https://habr.com/ru/companies/slurm/articles/329138/)
