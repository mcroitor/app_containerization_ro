# Lucrare de laborator nr. 10: Managementul secretelor în containere

## Scopul lucrării

Scopul lucrării este familiarizarea cu metodele de management al secretelor în containere.

## Sarcină

Creați o aplicație multi-serviciu cu containere care utilizează secrete.

## Pregătire

Pentru realizarea acestei lucrări este necesar să aveți instalat pe calculator [Docker](https://www.docker.com/). Lucrarea se bazează pe lucrarea de laborator `containers08`.

## Realizare

Creați un repository `containers10` și clonați-l pe calculatorul dvs. În folderul `containers10` copiați conținutul proiectului `containers08`.

### Configurare

Pentru realizarea lucrării se utilizează următorul fișier `docker-compose.yaml`:

```yaml
services:
  frontend:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./site:/var/www/html
      - ./nginx.conf:/etc/nginx/conf.d/default.conf
    networks:
      - frontend
  backend:
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      MYSQL_HOST: database
      MYSQL_DATABASE: my_database
      MYSQL_USER: user
      MYSQL_PASSWORD_FILE: userpassword
    networks:
      - backend
      - frontend
  database:
    image: mariadb:latest
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: my_database
      MYSQL_USER: user
      MYSQL_PASSWORD: userpassword
    networks:
      - backend
      - frontend

networks:
  frontend: {}
  backend: {}
```

Modificați clasa wrapper pentru baza de date astfel încât constructorul să aibă prototipul:

```php
public function __construct(string $dsn, string $username, string $password);
```

Actualizați fișierul `index.php` astfel încât să utilizeze noul constructor:

```php
// $db = new Database($config["db"]["path"]);
$dsn = "mysql:host={$config['db']['host']};dbname={$config['db']['database']};charset=utf8";

$db = new Database($dsn, $config['db']['username'], $config['db']['password']);
```

În fișierul de configurare `config.php` adăugați următoarele linii:

```php
$config['db']['host'] = getenv('MYSQL_HOST');
$config['db']['database'] = getenv('MYSQL_DATABASE');
$config['db']['username'] = getenv('MYSQL_USER');
$config['db']['password'] = getenv('MYSQL_PASSWORD');
```

Actualizați Dockerfile-ul, înlocuind instalarea extensiei `pdo_sqlite` cu instalarea extensiei `pdo_mysql`:

```dockerfile
FROM php:7.4-fpm AS base

# instalare extensie pdo_mysql
RUN apt-get update && \
    apt-get install -y libzip-dev && \
    docker-php-ext-install pdo_mysql

# copiere fișiere site
COPY site /var/www/html
```

Fișierul de configurare pentru nginx se preia din lucrarea de laborator `containers07`.

Verificați funcționarea aplicației.

### Protecția secretelor

Creați folderul `secrets` și adăugați fișierele:

- `root_secret` – parola utilizatorului root;
- `user` – numele utilizatorului bazei de date;
- `secret` – parola utilizatorului bazei de date.

Completați conținutul acestor fișiere.

Actualizați fișierul `docker-compose.yaml` astfel încât să utilizeze secretele create. Adăugați secțiunea `secrets`:

```yaml
secrets:
  root_secret:
    file: ./secrets/root_secret
  user:
    file: ./secrets/user
  secret:
    file: ./secrets/secret
```

Pentru serviciul `database` actualizați secțiunea `environment`:

```yaml
environment:
  MYSQL_ROOT_PASSWORD_FILE: /run/secrets/root_secret
  MYSQL_DATABASE: my_database
  MYSQL_USER_FILE: /run/secrets/user
  MYSQL_PASSWORD_FILE: /run/secrets/secret
```

Actualizați și serviciul `backend`:

```yaml
environment:
  MYSQL_HOST: database
  MYSQL_DATABASE: my_database
```

Modificați conținutul fișierului de configurare `config.php` al site-ului astfel:

```php
$config['db']['host'] = getenv('MYSQL_HOST');
$config['db']['database'] = getenv('MYSQL_DATABASE');
// $config['db']['username'] = getenv('MYSQL_USER');
// $config['db']['password'] = getenv('MYSQL_PASSWORD');
$config['db']['username'] = get_file_contents('/run/secrets/user');
$config['db']['password'] = get_file_contents('/run/secrets/secret');
```

## Lansare și testare

Verificați imaginea serviciului `containers10-backend` din punct de vedere al securității cu ajutorul `docker scout`:

```bash
docker scout quickview containers10-backend
```

## Crearea raportului

Creați în folderul `containers10` fișierul `README.md` care să conțină pașii de realizare a proiectului. Descrierea proiectului trebuie să includă:

1. Denumirea lucrării de laborator;
2. Scopul lucrării;
3. Sarcina;
4. Descrierea realizării lucrării cu răspunsuri la întrebări;
5. Concluzii.

Răspundeți la întrebări:

1. De ce nu este recomandat să transmiteți secretele în imagine la build?
2. Cum se poate gestiona în siguranță secretele în containere?
3. Cum se utilizează Docker Secrets pentru gestionarea informațiilor confidențiale?

## Prezentare

La prezentarea răspunsului atașați la sarcină link-ul către repository.

## Evaluare

- `1 punct` – a fost creat repository-ul `containers10`;
- `3 puncte` – a fost creat folderul `site` cu fișierele site-ului;
- `1 punct` – a fost creat folderul `secrets` pentru stocarea secretelor;
- `2 puncte` – a fost creat fișierul `docker-compose.yaml`;
- `1 punct` – existența scopului lucrării în fișierul `README.md`;
- `1 punct` – existența sarcinii în fișierul `README.md`;
- `2 puncte` – existența descrierii realizării lucrării în fișierul `README.md`;
- `3 puncte` – existența răspunsurilor la întrebări în fișierul `README.md`;
- `2 puncte` – existența concluziilor în fișierul `README.md`;
- `4 puncte` – susținerea lucrării;
- `-2 puncte` – pentru fiecare zi de întârziere la predare;
- `-10 puncte` – pentru copierea codului de la alți studenți.
