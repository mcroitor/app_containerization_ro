# Lucrare de laborator Nr3: Prima aplicație Docker

## Scop

Aceasta lucrare de laborator familiarizează cu elementele de bază ale containerizării și pregătește spațiul de lucru pentru următoarele lucrări de laborator.

## Sarcina

Instalarea Docker Desktop și verificarea funcționării acestuia.

## Pregătire

Descărcați și instalați [Docker Desktop](https://www.docker.com/products/docker-desktop/).

## Executare

Creați un repozitoriu `containers03` și clonați-l pe computerul dvs.

Creați în directorul `containers03` fișierul `Dockerfile` cu următorul conținut:

```dockerfile
FROM debian:latest
COPY ./site/ /var/www/html/
CMD ["sh", "-c", "echo hello from $HOSTNAME"]
```

În aceeași director de proiect creați directorul `site`. În noul director creați fișierul `index.html` cu conținut arbitrar.

## Pornire și testare

Deschideți terminalul în directorul `containers03` și executați comanda:

```bash
docker build -t containers03 .
```

_Cât timp a durat crearea imaginii?_

Executați comanda pentru a porni containerul:

```bash
docker run --name containers03 containers03
```

_Ce a fost afișat în consolă?_

Ștergeți containerul și porniți-l din nou, executând comenzile:

```bash
docker rm containers03
docker run -ti --name containers03 containers03 bash
```

În fereastra deschisă, executați comenzile:

```bash
cd /var/www/html/
ls -l
```

_Ce este afișat pe ecran?_

Închideți fereastra cu comanda `exit`.

Creați în directorul proiectului fișierul `README.md` cu descrierea proiectului. Descrierea proiectului trebuie să conțină:

1. Denumirea lucrării de laborator.
2. Scopul lucrării.
3. Sarcina.
4. Descrierea executării lucrării cu răspunsuri la întrebări.
5. Concluzii.
6. Bibliografie.

## Prezentare

Pentru prezentarea lucrului efectuat indicați referința la repozitoriul creat în răspuns la sarcina.

## Modul de evaluare

- `1 punct` - crearea repozitoriului `containers03` pe GitHub
- `1 punct` - repozitoriu conține fișierul `Dockerfile`
- `1 punct` - repozitoriu conține directorul `site`
- `1 punct` - repozitoriu conține fișierul `site/index.html`
- `1 punct` - descrierea scopului lucrării în fișierul `README.md`
- `1 punct` - descrierea sarcinii în fișierul `README.md`
- `1 punct` - descrierea executării lucrării în fișierul `README.md`
- `1 punct` - răspunsuri la întrebările din fișierul `README.md`
- `1 punct` - concluzii în fișierul `README.md`
- `1 punct` - bibliografia în fișierul `README.md`
- `-1 punct` - pentru fiecare zi de întârziere
- `-5 puncte` - pentru copierea codului de la colegi
