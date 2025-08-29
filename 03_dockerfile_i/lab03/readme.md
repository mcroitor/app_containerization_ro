# Lucrare de laborator nr. 3: Primul container

## Scopul lucrării

Această lucrare de laborator familiarizează studentul cu elementele de bază ale containerizării și pregătește mediul de lucru pentru realizarea următoarelor lucrări de laborator.

## Sarcină

Instalați Docker Desktop și verificați funcționarea acestuia.

## Pregătire

Descărcați și instalați [Docker Desktop](https://www.docker.com/products/docker-desktop/).

## Realizare

Creați un repository `containers03` și clonați-l pe calculatorul dvs.

În folderul `containers03` creați fișierul `Dockerfile` cu următorul conținut:

```dockerfile
FROM debian:latest
COPY ./site/ /var/www/html/
CMD ["sh", "-c", "echo hello from $HOSTNAME"]
```

În același folder al proiectului creați folderul `site`. În noul folder creați fișierul `index.html` cu orice conținut doriți.

## Lansare și testare

Deschideți terminalul în folderul `containers03` și executați comanda:

```bash
docker build -t containers03 .
```

_Cât timp a durat crearea imaginii?_

Executați comanda pentru lansarea containerului:

```bash
docker run --name containers03 containers03
```

_Ce s-a afișat în consolă?_

Ștergeți containerul și lansați-l din nou, executând comenzile:

```bash
docker rm containers03
docker run -ti --name containers03 containers03 bash
```

În fereastra deschisă executați comenzile:

```bash
cd /var/www/html/
ls -l
```

_Ce se afișează pe ecran?_

Închideți fereastra cu comanda `exit`.

Creați în folderul proiectului fișierul `README.md` cu descrierea proiectului. Descrierea proiectului trebuie să conțină:

1. Denumirea lucrării de laborator.
2. Scopul lucrării.
3. Sarcina.
4. Descrierea realizării lucrării cu răspunsuri la întrebări.
5. Concluzii.
6. Sursele utilizate.

## Prezentare

La prezentarea răspunsului atașați la sarcină link-ul către repository.

## Evaluare

- `1 punct` – crearea repository-ului `containers03` pe GitHub;
- `1 punct` – existența fișierului `Dockerfile`;
- `1 punct` – existența folderului `site`;
- `1 punct` – existența fișierului `site/index.html`;
- `1 punct` – existența scopului lucrării în fișierul `README.md`;
- `1 punct` – existența sarcinii în fișierul `README.md`;
- `1 punct` – existența descrierii realizării lucrării în fișierul `README.md`;
- `1 punct` – existența răspunsurilor la întrebări în fișierul `README.md`;
- `1 punct` – existența concluziilor în fișierul `README.md`;
- `1 punct` – existența surselor utilizate în fișierul `README.md`;
- `2 puncte` – susținerea lucrării;
- `-1 punct` – pentru fiecare zi de întârziere la predare;
- `-5 puncte` – pentru copierea codului de la alți studenți.
