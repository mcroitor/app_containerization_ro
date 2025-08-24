# Lucrare de laborator Nr4: Utilizarea containerelor ca medii de execuție

## Scop

Această lucrare de laborator are ca scop familiarizarea cu comenzile de bază ale OS Debian/Ubuntu. De asemenea, aceasta va permite să vă familiarizați cu Docker și comenzile sale de bază.

## Sarcina

Pornind de la imaginea oficială a sistemului de operare Ubuntu, să se creeze un container care să conțină un server web Apache. Să se creeze o pagină web care să conțină textul "Hello, World!" și să se afișeze într-un browser.

## Pregătire

Pentru a executa această lucrare de laborator, trebuie să aveți instalat pe computer [Docker](https://www.docker.com/).

## Executare

Creati un nou repository `containers04` și clonați-l pe computerul dvs.

Creati în directorul `containers04` un fișier `README.md` care va conține descrierea pas cu pas a executării proiectului. Descrierea proiectului trebuie să conțină:

1. Denumirea lucrării de laborator;
2. Scopul lucrării de laborator;
3. Sarcina lucrării de laborator;
4. Descrierea executării lucrării de laborator;
5. Concluzii;
6. Referințe la sursele utilizate.

Plasati rezultatul lucrării de laborator pe GitHub.

## Pornire și testare

Deschideți terminalul în directorul `containers04` și executați comanda:

```bash
docker run -ti -p 8000:80 --name containers04 ubuntu bash
```

In fereastra deschisa, executați următoarele comenzi și explicați-le:

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

Ce vedeți pe ecran?

Închideți fereastra terminalului cu comanda `exit`.

Afișați lista de containere:

```bash
docker ps -a
```

Stergeți containerul:

```bash
docker rm containers04
```

Pentru fiecare comandă, explicați scopul, rezultatul și afișarea în consolă. Este de dorit să furnizați capturi de ecran.

## Prezentare

Pentru prezentarea lucrului efectuat indicați referința la repozitoriul creat în răspuns la sarcina.

## Modul de evaluare

- `1 punct` - crearea repozitoriului `containers04` pe GitHub
- `1 punct` - explicația comenzii de pornire a containerului
- `1 punct` - explicația comenzii de instalare a `apache2`
- `1 punct` - explicația comenzii de pornire a `apache2`
- `1 punct` - explicația comenzii de vizualizare a conținutului directorului `/var/www/html/`
- `1 punct` - explicația comenzii de creare a fișierului `index.html`
- `1 punct` - explicația comenzii de vizualizare a conținutului fișierului `000-default.conf`
- `1 punct` - explicația comenzii de vizualizare a listei de containere
- `1 punct` - explicația comenzii de ștergere a containerului
- `1 punct` - pentru prezența capturilor de ecran / ieșirilor în consolă
- `2 puncte` - prezentarea lucrului efectuat
- `-1 punct` - pentru fiecare zi de întârziere la predare
- `-5 puncte` - pentru copierea codului de la alți studenți
