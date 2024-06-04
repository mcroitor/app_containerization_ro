# Lucrare de laborator №7: Integrare continuă cu Github Actions

## Scopul lucrării

În cadrul acestei lucrări studenții vor învăța să configureze integrarea continuă cu ajutorul Github Actions.

## Sarcina

Crearea unei aplicații Web, scrierea testelor pentru aceasta și configurarea integrării continue cu ajutorul Github Actions pe baza containerelor.

## Pregătire

Pentru a efectua această lucrare, trebuie să aveți instalat pe computer [Docker](https://www.docker.com/).

## Execuție

Creați un repozitoriu `containers07` și copiați-l pe computerul dvs.

În directorul `containers07` creați directorul `./site`. În directorul `./site` va fi plasată aplicația Web pe baza PHP.

### Crearea aplicației Web

Creați în directorul `./site` aplicația Web pe baza PHP cu următoarea structură:

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

Fișierul `modules/database.php` conține clasa `Database` pentru lucru cu baza de date. Pentru lucru cu baza de date folosiți SQLite. Clasa trebuie să conțină metode:

- `__construct($path)` - constructorul clasei, primește calea către fișierul bazei de date SQLite;
- `Execute($sql)` - execută interogarea SQL;
- `Fetch($sql)` - execută interogarea SQL și returnează rezultatul sub formă de tablou asociativ;
- `Create($table, $data)` - creează înregistrare în tabelul `$table` cu datele din tabloul asociativ `$data` și returnează identificatorul înregistrării create;
- `Read($table, $id)` - returnează înregistrarea din tabelul `$table` după identificatorul `$id`;
- `Update($table, $id, $data)` - actualizează înregistrarea în tabelul `$table` după identificatorul `$id` cu datele din tabloul asociativ `$data`;
- `Delete($table, $id)` - șterge înregistrarea din tabelul `$table` după identificatorul `$id`;
- `Count($table)` - returnează numărul înregistrărilor din tabelul `$table`.

Fișierul `modules/page.php` conține clasa `Page` pentru lucru cu paginile. Clasa trebuie să conțină metode:

- `__construct($template)` - constructorul clasei, primește calea către șablonul paginii;
- `Render($data)` - afișează pagina, înlocuind datele din tabloul asociativ `$data` în șablon.

Fișierul `templates/index.tpl` conține șablonul paginii.

Fișierul `styles/style.css` conține stilurile pentru pagina.

Fișierul `index.php` conține codul pentru afișarea paginii. Un exemplu de cod pentru fișierul `index.php`:

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

Creați în directorul `./site` directorul `./sql`. În directorul creat creați fișierul `schema.sql` cu următorul conținut:

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

Creați în rădăcina directorului `containers07` directorul `./tests`. În directorul creat creați fișierul `testframework.php` cu următorul conținut:

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

Create în directorul `./tests` fișierul `tests.php` cu următorul conținut:

```php
<?php

require_once __DIR__ . '/testframework.php';

require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../modules/database.php';
require_once __DIR__ . '/../modules/page.php';

$testFramework = new TestFramework();

// test 1: check database connection
function testDbConnection() {
    global $config;
    // ...
}

// test 2: test count method
function testDbCount() {
    global $config;
    // ...
}

// test 3: test create method
function testDbCreate() {
    global $config;
    // ...
}

// test 4: test read method
function testDbRead() {
    global $config;
    // ...
}

// add tests
$tests->add('Database connection', 'testDbConnection');
$tests->add('table count', 'testDbCount');
$tests->add('data create', 'testDbCreate');
// ...

// run tests
$tests->run();

echo $tests->getResult();
```

Adăugați în fișierul `./tests/tests.php` teste pentru toate metodele clasei `Database`, precum și pentru metodele clasei `Page`.

### Crearea Dockerfile

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

Creați în directorul rădăcină al proiectului fișierul `.github/workflows/main.yml` cu următorul conținut:

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

## Pornire și testare

Trimiteți modificările în repozitoriul și asigurați-vă că testele trec cu succes. Pentru aceasta, treceți la fila `Actions` în repozitoriu și așteptați finalizarea sarcinii.

## Pregătirea raportului

Creați în directorul `containers07` fișierul `README.md` care conține executarea pas cu pas a proiectului. Descrierea proiectului trebuie să conțină:

1. Numele lucrării de laborator.
2. Scopul lucrării.
3. Sarcina.
4. Descrierea efectuării lucrării cu răspunsuri la întrebări.
5. Concluzii.

Răspundeți la întrebările:

1. Ce este integrarea continuă?
2. Pentru ce sunt necesare testele unitare? Cât de des trebuie să fie executate?
3. Care modificări trebuie făcute în fișierul `.github/workflows/main.yml` pentru a rula testele la fiecare solicitare de trage (Pull Request)?
4. Ce trebuie adăugat în fișierul `.github/workflows/main.yml` pentru a șterge imaginile create după testare?

## Prezentare

Pentru prezentarea răspunsului atașați la sarcină un link către repozitoriul.

## Evaluare
