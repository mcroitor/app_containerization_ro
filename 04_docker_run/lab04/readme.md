# Lucrare de laborator nr. 4: Utilizarea containerelor ca mediu de execuție

## Scopul lucrării

Această lucrare de laborator are scopul de a reaminti principalele comenzi ale sistemului de operare Debian/Ubuntu. De asemenea, permite familiarizarea cu Docker și cu principalele sale comenzi.

## Sarcină

Lansați un container Ubuntu, instalați serverul web Apache și afișați în browser o pagină cu textul "Hello, World!".

## Pregătire

Pentru realizarea acestei lucrări este necesar să aveți instalat pe calculator [Docker](https://www.docker.com/).

## Realizare

Creați un repository `containers04` și clonați-l pe calculatorul dvs.

Creați în folderul `containers04` fișierul `README.md`, care să conțină pașii de realizare a proiectului. Descrierea proiectului trebuie să includă:

1. Denumirea lucrării de laborator.
2. Scopul lucrării.
3. Sarcina.
4. Descrierea realizării lucrării cu răspunsuri la întrebări.
5. Concluzii.

Publicați proiectul pe GitHub.

## Lansare și testare

Deschideți terminalul în folderul `containers04` și executați comanda:

```bash
docker run -ti -p 8000:80 --name containers04 ubuntu bash
```

În fereastra deschisă executați următoarele comenzi și explicați scopul fiecăreia:

```bash
apt update
apt install apache2 -y
service apache2 start
```

Deschideți browserul și introduceți în bara de adrese `http://localhost:8000`. Ce vedeți?

Executați următoarele comenzi:

```bash
ls -l /var/www/html/
echo '<h1>Hello, World!</h1>' > /var/www/html/index.html
```

Reîmprospătați pagina în browser. Ce vedeți?

Executați următoarele comenzi:

```bash
cd /etc/apache2/sites-enabled/
cat 000-default.conf
```

Ce se afișează pe ecran?

Închideți fereastra terminalului cu comanda `exit`.

Vizualizați lista containerelor:

```bash
docker ps -a
```

Ștergeți containerul:

```bash
docker rm containers04
```

Pentru fiecare comandă explicați scopul, rezultatul execuției și ce se afișează în consolă. Este recomandat să includeți capturi de ecran sau output-ul din consolă sub formă de bloc de cod.

## Prezentare

La prezentarea răspunsului atașați la sarcină link-ul către repository.

## Evaluare

- `1 punct` – crearea repository-ului `containers04` pe GitHub;
- `1 punct` – explicația comenzii de lansare a containerului;
- `1 punct` – explicația comenzii de instalare a `apache2`;
- `1 punct` – explicația comenzii de pornire a `apache2`;
- `1 punct` – explicația comenzii de vizualizare a conținutului folderului `/var/www/html/`;
- `1 punct` – explicația comenzii de creare a fișierului `index.html`;
- `1 punct` – explicația comenzii de vizualizare a conținutului fișierului `000-default.conf`;
- `1 punct` – explicația comenzii de vizualizare a listei containerelor;
- `1 punct` – explicația comenzii de ștergere a containerului;
- `1 punct` – pentru prezența capturilor de ecran / output-ului din consolă;
- `2 puncte` – susținerea lucrării;
- `-1 punct` – pentru fiecare zi de întârziere la predare;
- `-5 puncte` – pentru copierea codului de la alți studenți.
