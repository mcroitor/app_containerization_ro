# Lucrare de laborator Nr2: Server virtual

Această lucrare de laborator vă familiarizează cu virtualizarea sistemelor de operare și configurarea unui server HTTP virtual.

## Scop

Descărcați distributivul [Debian](https://www.debian.org/distrib/) pentru servere pentru arhitectura x64 (fără interfață grafică) și sistemul de virtualizare (hypervizor) [QEMU](https://www.qemu.org/download/).

Instalați `QEMU`. Redenumiți imaginea distributivului Debian descărcat în `debian.iso`.

## Executare

Creați directorul `lab02`. În acest director creați directorul `dvd` și fișierul `readme.md`. În directorul `dvd` plasați imaginea ISO a distributivului Debian.

În consolă creați în directorul `lab02` imaginea discului pentru mașina virtuală de dimensiune `8 GB` și format `qcow2`, folosind utilitarul `qemu-img`:

```bash
qemu-img create -f qcow2 debian.qcow2 8G
```

> Pentru a afla mai multe detalii despre parametri utilitarului, executați comanda:
>
> ```bash
> qemu-img --help
> ```

Instalați SO Debian pe mașina virtuală. Pentru aceasta executați comanda:

```bash
qemu-system-x86_64 -hda debian.qcow2 -cdrom dvd/debian.iso -boot d -m 2G
```

> Parametri adiționali pot fi obținuți prin comanda:
>
> ```bash
> qemu-system-x86_64 --help
> ```

La instalația SO, folosiți următoarele parametri:

- nume calculator: `debian`;
- nume domeniu: `debian.localhost`;
- nume utilizator: `user`;
- parola utilizator: `password`.

Reporniți mașina virtuală. Pentru a reporni mașina virtuală, executați comanda:

```bash
qemu-system-x86_64 -hda debian.qcow2 -m 2G -smp 2 -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::1080-:80,hostfwd=tcp::1022-:22
```

Instalați LAMP în mașina virtuală. Pentru aceasta, schimbați profil utilizatorului pe superutilizator și executați comenzile:

```bash
su
apt update -y
apt install -y apache2 php libapache2-mod-php php-mysql mariadb-server mariadb-client unzip
```

> _Care este destinația pachetelor instalate?_

Descărcați [SGBD PhpMyAdmin](https://phpmyadmin.net/).

```bash
wget https://files.phpmyadmin.net/phpMyAdmin/5.2.2/phpMyAdmin-5.2.2-all-languages.zip
```

Descărcați [CMS Drupal](https://www.drupal.org/).

```bash
wget https://ftp.drupal.org/files/projects/drupal-11.1.1.zip
```

Verificați existența fișierelor utilizând comanda `ls -l`.

Dezarhivați fișierele descărcate în directoarele:

1. SGBD PhpMyAdmin ==> `/var/www/phpmyadmin`;
2. CMS Drupal ==> `/var/www/drupal`.

```bash
mkdir /var/www
unzip phpMyAdmin-5.2.2-all-languages.zip
mv phpMyAdmin-5.2.2-all-languages /var/www/phpmyadmin
unzip drupal-11.1.1.zip
mv drupal-11.1.1 /var/www/drupal
```

Creați din linia de comandă baza de date `drupal_db` și utilizatorul bazei de date cu numele dvs.

```bash
mysql -u root
```

```sql
CREATE DATABASE drupal_db;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON drupal_db.* TO 'user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

În directorul `/etc/apache2/sites-available` creați fișierul `01-phpmyadmin.conf`

```bash
nano /etc/apache2/sites-available/01-phpmyadmin.conf
```

cu următorul conținut:

```text
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot "/var/www/phpmyadmin"
    ServerName phpmyadmin.localhost
    ServerAlias www.phpmyadmin.localhost
    ErrorLog "/var/log/apache2/phpmyadmin.localhost-error.log"
    CustomLog "/var/log/apache2/phpmyadmin.localhost-access.log" common
</VirtualHost>
```

În directorul `/etc/apache2/sites-available` creați fișierul `02-drupal.conf`

```bash
nano /etc/apache2/sites-available/02-drupal.conf
```

cu următorul conținut:

```text
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot "/var/www/drupal"
    ServerName drupal.localhost
    ServerAlias www.drupal.localhost
    ErrorLog "/var/log/apache2/drupal.localhost-error.log"
    CustomLog "/var/log/apache2/drupal.localhost-access.log" common
</VirtualHost>
```

Pentru a activa configurațiile, executați comenzile:

```bash
/usr/sbin/a2ensite 01-phpmyadmin
/usr/sbin/a2ensite 02-drupal
```

Adăugați în fișierul `/etc/hosts` următoarele linii:

```text
127.0.0.1 phpmyadmin.localhost
127.0.0.1 drupal.localhost
```

## Pornire și testare

În consolă executați comanda:

```bash
uname -a
```

> _Ce se afișează pe ecran în urma executării acestei comenzi?_

Reporniți Apache Web Server.

> _Cum se poate reporni Apache Web Server?_

Verificați disponibilitatea site-urilor `http://drupal.localhost:1080` și `http://phpmyadmin.localhost:1080`. Finalizați instalarea site-urilor.

## Raport

Pregătiți raportul despre lucrul efectuat în fișierul `readme.md`. Raportul trebuie să conțină:

1. Numele lucrării de laborator.
2. Numele și prenumele studentului, grupa.
3. Data efectuării lucrării.
4. Definiția sarcinii de lucru.
5. Descrierea modului de realizare a lucrării.
6. Răspunsurile la întrebările propuse.
7. Concluzii.

Răspundeți la următoarele întrebări:

1. Cum se poate descărca un fișier în consolă cu ajutorul utilitarului `wget`?
2. De ce este necesar să creați pentru fiecare site baza de date și utilizatorul său?
3. Cum se poate schimba accesul la sistemul de gestionare a bazei de date pe portul `1234`?
4. Care sunt avantajele, din punctul dvs. de vedere, ale virtualizării?
5. Pentru ce este necesar să se stabilească ora/zona de timp pe server?
6. Cât spațiu ocupă instalarea OS (disc virtual) pe mașina gazdă?
7. Care sunt recomandările privind partiționarea discului pentru servere? De ce se recomandă să se particioneze discul în acest fel?

Arhivați fișierul `readme.md` (și posibilele capturi de ecran) în arhiva `<lastname>-<firstname>-lab02.md.zip` și atașați arhiva obținută la sarcină în Moodle pentru verificare.

## Evaluare

- `+1 punct` - raport conține definirea sarcinii de lucru
- `+1 punct` - raport conține descrierea creării imaginii discului
- `+1 punct` - raport conține descrierea instalării SO
- `+1 punct` - raport conține descrierea instalării LAMP
- `+1 punct` - raport conține descrierea instalării configurației host-urilor virtuale
- `+1 punct` - raport conține descrierea instalării Drupal
- `+1 punct` - raport conține descrierea instalării PhpMyAdmin
- `+1 punct` - raport conține răspunsurile la întrebări
- `+1 punct` - raport conține concluzii
- `+1 punct` - raportul este formatat conform cerințelor (formatare, bibliografie, etc.)
- `-1 punct` - pentru fiecare zi de întârziere la predare
- `-5 puncte` - pentru copierea codului de la colegi
