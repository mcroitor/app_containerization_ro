# Lucrare de laborator nr. 8: Integrare continuă cu Github Actions

## Scopul lucrării

În cadrul acestei lucrări, studenții vor învăța să configureze integrarea continuă folosind Github Actions.

## Sarcină

Creați o aplicație Web, scrieți teste pentru aceasta și configurați integrarea continuă cu Github Actions pe bază de containere.

## Pregătire

Pentru realizarea acestei lucrări este necesar să aveți instalat pe calculator [Docker](https://www.docker.com/).

## Realizare

Creați un repository `containers08` și clonați-l pe calculatorul dvs.

În directorul `containers08` creați directorul `./site`. În acest director va fi plasată aplicația Web pe bază de PHP.

### Crearea aplicației Web

Creați în directorul `./site` o aplicație Web pe bază de PHP cu următoarea structură:

```text
site
├── modules/
│   ├── database.php
│   └── page.php
├── templates/
│   └── index.tpl
├── styles/
│   └── style.css
├── config.php
└── index.php
```

Fișierul `modules/database.php` conține clasa `Database` pentru lucrul cu baza de date. Pentru baza de date folosiți SQLite. Clasa trebuie să conțină metodele:

- `__construct($path)` - constructorul clasei, primește calea către fișierul bazei de date SQLite;
- `Execute($sql)` - execută o interogare SQL;
- `Fetch($sql)` - execută o interogare SQL și returnează rezultatul ca array asociativ;
- `Create($table, $data)` - creează o înregistrare în tabelul `$table` cu datele din array-ul asociativ `$data` și returnează ID-ul înregistrării create;
- `Read($table, $id)` - returnează înregistrarea din tabelul `$table` cu ID-ul `$id`;
- `Update($table, $id, $data)` - actualizează înregistrarea din tabelul `$table` cu ID-ul `$id` cu datele din array-ul asociativ `$data`;
- `Delete($table, $id)` - șterge înregistrarea din tabelul `$table` cu ID-ul `$id`;
- `Count($table)` - returnează numărul de înregistrări din tabelul `$table`.

Fișierul `modules/page.php` conține clasa `Page` pentru lucrul cu paginile. Clasa trebuie să conțină metodele:

- `__construct($template)` - constructorul clasei, primește calea către șablonul paginii;
- `Render($data)` - afișează pagina, înlocuind variabilele din șablon cu datele din array-ul asociativ `$data`.

Fișierul `templates/index.tpl` conține șablonul paginii.

Fișierul `styles/style.css` conține stilurile pentru pagină.

Fișierul `index.php` conține codul pentru afișarea paginii. Exemplu de cod pentru fișierul `index.php`:

```php
<?php

require_once __DIR__ . '/modules/database.php';
require_once __DIR__ . '/modules/page.php';

require_once __DIR__ . '/config.php';

$db = new Database($config["db"]["path"]);

$page = new Page(__DIR__ . '/templates/index.tpl');

// bad idea, not recommended
$pageId = $_GET['page'];

$data = $db->Read("page", $pageId);

echo $page->Render($data);
```

Fișierul `config.php` conține setările pentru conectarea la baza de date.

### Pregătirea fișierului SQL pentru baza de date

Creați în directorul rădăcină al proiectului directorul `./sql`. În acest director creați fișierul `schema.sql` cu următorul conținut:

```sql
CREATE TABLE page (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    content TEXT
);

INSERT INTO page (title, content) VALUES ('Page 1', 'Content 1');
INSERT INTO page (title, content) VALUES ('Page 2', 'Content 2');
INSERT INTO page (title, content) VALUES ('Page 3', 'Content 3');
```

### Crearea testelor

Creați în directorul rădăcină al proiectului directorul `./tests`. În acest director creați fișierul `testframework.php` cu următorul conținut:

```php
<?php

function message($type, $message) {
    $time = date('Y-m-d H:i:s');
    echo "{$time} [{$type}] {$message}" . PHP_EOL;
}

function info($message) {
    message('INFO', $message);
}

function error($message) {
    message('ERROR', $message);
}

function assertExpression($expression, $pass = 'Pass', $fail = 'Fail'): bool {
    if ($expression) {
        info($pass);
        return true;
    }
    error($fail);
    return false;
}

class TestFramework {
    private $tests = [];
    private $success = 0;

    public function add($name, $test) {
        $this->tests[$name] = $test;
    }

    public function run() {
        foreach ($this->tests as $name => $test) {
            info("Running test {$name}");
            if ($test()) {
                $this->success++;
            }
            info("End test {$name}");
        }
    }

    public function getResult() {
        return "{$this->success} / " . count($this->tests);
    }
}
```

Creați în directorul `./tests` fișierul `tests.php` cu următorul conținut:

```php
<?php

require_once __DIR__ . '/testframework.php';

require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../modules/database.php';
require_once __DIR__ . '/../modules/page.php';

$testFramework = new TestFramework();

// test 1: verifică conexiunea la baza de date
function testDbConnection() {
    global $config;
    // ...
}

// test 2: test pentru metoda count
function testDbCount() {
    global $config;
    // ...
}

// test 3: test pentru metoda create
function testDbCreate() {
    global $config;
    // ...
}

// test 4: test pentru metoda read
function testDbRead() {
    global $config;
    // ...
}

// adăugare teste
$tests->add('Database connection', 'testDbConnection');
$tests->add('table count', 'testDbCount');
$tests->add('data create', 'testDbCreate');
// ...

// rulare teste
$tests->run();

echo $tests->getResult();
```

Adăugați în fișierul `./tests/test.php` teste pentru toate metodele clasei `Database`, precum și pentru metodele clasei `Page`.

### Crearea Dockerfile-ului

Creați în directorul rădăcină al proiectului fișierul `Dockerfile` cu următorul conținut:

```dockerfile
FROM php:7.4-fpm as base

RUN apt-get update && \
    apt-get install -y sqlite3 libsqlite3-dev && \
    docker-php-ext-install pdo_sqlite

VOLUME ["/var/www/db"]

COPY sql/schema.sql /var/www/db/schema.sql

RUN echo "prepare database" && \
    cat /var/www/db/schema.sql | sqlite3 /var/www/db/db.sqlite && \
    chmod 777 /var/www/db/db.sqlite && \
    rm -rf /var/www/db/schema.sql && \
    echo "database is ready"

COPY site /var/www/html
```

### Configurarea Github Actions

Creați în directorul rădăcină al repository-ului fișierul `.github/workflows/main.yml` cu următorul conținut:

```yaml
name: CI

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Build the Docker image
        run: docker build -t containers07 .
      - name: Create `container`
        run: docker create --name container --volume database:/var/www/db containers07
      - name: Copy tests to the container
        run: docker cp ./tests container:/var/www/html
      - name: Up the container
        run: docker start container
      - name: Run tests
        run: docker exec container php /var/www/html/tests/tests.php
      - name: Stop the container
        run: docker stop container
      - name: Remove the container
        run: docker rm container
```

## Lansare și testare

Trimiteți modificările în repository și asigurați-vă că testele trec cu succes. Pentru aceasta, accesați secțiunea `Actions` din repository și așteptați finalizarea execuției task-ului.

## Crearea raportului

Creați în folderul `containers08` fișierul `README.md` care să conțină pașii de realizare a proiectului. Descrierea proiectului trebuie să includă:

1. Denumirea lucrării de laborator.
2. Scopul lucrării.
3. Sarcina.
4. Descrierea realizării lucrării cu răspunsuri la întrebări.
5. Concluzii.

Răspundeți la întrebări:

1. Ce este integrarea continuă?
2. Pentru ce sunt necesare testele unitare? Cât de des trebuie rulate?
3. Ce trebuie modificat în fișierul `.github/workflows/main.yml` pentru ca testele să fie rulate la fiecare creare de pull request?
4. Ce trebuie adăugat în fișierul `.github/workflows/main.yml` pentru a șterge imaginile create după rularea testelor?

## Prezentare

La prezentarea răspunsului atașați la sarcină link-ul către repository.

## Evaluare

- `1 punct` – a fost creat repository-ul `containers08`;
- `2 puncte` – a fost creat directorul `./site` cu aplicația Web;
- `2 puncte` – a fost creat directorul `./sql` cu fișierul `schema.sql`;
- `2 puncte` – a fost creat directorul `./tests` cu fișierele `testframework.php` și `tests.php`;
- `1 punct` – a fost creat fișierul `Dockerfile`;
- `2 puncte` – a fost creat fișierul `.github/workflows/main.yml`;
- `1 punct` – existența scopului lucrării în fișierul `README.md`;
- `1 punct` – existența sarcinii în fișierul `README.md`;
- `1 punct` – existența descrierii realizării lucrării în fișierul `README.md`;
- `2 puncte` – existența răspunsurilor la întrebări în fișierul `README.md`;
- `2 puncte` – existența concluziilor în fișierul `README.md`;
- `4 puncte` – susținerea lucrării;
- `-2 puncte` – pentru fiecare zi de întârziere la predare;
- `-10 puncte` – pentru copierea codului de la alți studenți.
