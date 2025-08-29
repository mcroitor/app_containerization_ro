# Lucrare de laborator nr. 2. Server virtual

Această lucrare de laborator familiarizează studentul cu virtualizarea sistemelor de operare (pe exemplul OS Debian) și configurarea unui server HTTP virtual (LAMP).

## Pregătire

Descărcați distribuția [Debian](https://www.debian.org/distrib/) pentru servere, arhitectura x64 (fără interfață grafică) și sistemul de virtualizare (hipervizor) [QEMU](https://www.qemu.org/download/).

Instalați `QEMU`. Redenumiți imaginea descărcată a distribuției Debian în `debian.iso`.

## Realizare

Creați un repository `containers02` și clonați-l pe calculatorul dvs.

În folderul `containers02` creați folderul `dvd` și fișierul `readme.md`. În folderul `dvd` plasați imaginea ISO a distribuției Debian.

Creați în folderul `containers02` fișierul `.gitignore` cu următorul conținut:

```text
# Fișiere ignorate
*.qcow2
*.iso
*.zip
```

În consolă, în folderul `containers02`, creați o imagine de disc pentru mașina virtuală de 8 GB, format `qcow2`, folosind utilitarul `qemu-img`:

```bash
qemu-img create -f qcow2 debian.qcow2 8G
```

> Pentru a vedea parametrii suplimentari ai utilitarului, executați comanda:
>
> ```bash
> qemu-img --help
> ```

Instalați OS Debian pe mașina virtuală. Pentru aceasta, executați comanda:

```bash
qemu-system-x86_64 -hda debian.qcow2 -cdrom dvd/debian.iso -boot d -m 2G
```

> Pentru parametri suplimentari, executați comanda:
>
> ```bash
> qemu-system-x86_64 --help
> ```

La instalare, utilizați următoarele setări:

- Nume calculator: `debian`;
- Nume gazdă: `debian.localhost`;
- Nume utilizator: `user`;
- Parolă utilizator: `password`;

Reporniți mașina virtuală. Pentru a reporni mașina virtuală, executați comanda:

```bash
qemu-system-x86_64 -hda debian.qcow2 -m 2G -smp 2 -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::1080-:80,hostfwd=tcp::1022-:22
```

Instalați LAMP în mașina virtuală. Pentru aceasta, treceți la superutilizator și executați comenzile:

```bash
su
apt update -y
apt install -y apache2 php libapache2-mod-php php-mysql mariadb-server mariadb-client unzip
```

> _Care este scopul pachetelor instalate?_

Descărcați [SGBD PhpMyAdmin](https://phpmyadmin.net/):

```bash
wget https://files.phpmyadmin.net/phpMyAdmin/5.2.2/phpMyAdmin-5.2.2-all-languages.zip
```

Descărcați [CMS WordPress](https://wordpress.org/download/):

```bash
wget https://wordpress.org/latest.zip
```

Verificați existența fișierelor cu comanda `ls -l`.

Dezarhivați fișierele descărcate în folderele:

1. SGBD PhpMyAdmin ==> `/var/www/phpmyadmin`;
2. CMS WordPress ==> `/var/www/wordpress`;

```bash
mkdir /var/www
unzip phpMyAdmin-5.2.2-all-languages.zip
mv phpMyAdmin-5.2.2-all-languages /var/www/phpmyadmin
unzip latest.zip
mv wordpress /var/www/wordpress
```

Creați din linia de comandă pentru CMS baza de date `wordpress_db` și utilizatorul bazei de date cu numele dvs.

```bash
mysql -u root
```

```sql
CREATE DATABASE wordpress_db;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

În folderul `/etc/apache2/sites-available` creați fișierul `01-phpmyadmin.conf`

```bash
nano /etc/apache2/sites-available/01-phpmyadmin.conf
```

cu conținutul:

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

În folderul `/etc/apache2/sites-available` creați fișierul `02-wordpress.conf`

```bash
nano /etc/apache2/sites-available/02-wordpress.conf
```

cu conținutul:

```text
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot "/var/www/wordpress"
    ServerName wordpress.localhost
    ServerAlias www.wordpress.localhost
    ErrorLog "/var/log/apache2/wordpress.localhost-error.log"
    CustomLog "/var/log/apache2/wordpress.localhost-access.log" common
</VirtualHost>
```

Înregistrați configurațiile executând comenzile:

```bash
/usr/sbin/a2ensite 01-phpmyadmin
/usr/sbin/a2ensite 02-wordpress
```

Adăugați în fișierul `/etc/hosts` liniile:

```text
127.0.0.1 phpmyadmin.localhost
127.0.0.1 wordpress.localhost
```

## Pornire și testare

În fereastra de consolă executați comanda `uname -a`.

> _Ce se afișează pe ecran în urma executării acestei comenzi?_

Reporniți Apache Web Server.

> _Cum se repornește Apache Web Server?_

În browser verificați accesibilitatea site-urilor `http://wordpress.localhost:1080` și `http://phpmyadmin.localhost:1080`. Finalizați instalarea site-urilor.

## Raport

Prezentați raportul despre lucrarea efectuată în fișierul `readme.md`. Raportul trebuie să conțină:

1. Denumirea lucrării de laborator.
2. Numele și prenumele studentului, grupa.
3. Data realizării lucrării.
4. Descrierea sarcinii.
5. Descrierea realizării lucrării.
6. Răspunsuri la întrebările propuse.
7. Concluzii.

Răspundeți la următoarele întrebări:

1. Cum se poate descărca un fișier din consolă folosind utilitarul `wget`?
2. De ce este necesar să creați pentru fiecare site propria bază de date și propriul utilizator?
3. Cum se poate schimba accesul la sistemul de administrare a BD pe portul `1234`?
4. Ce avantaje, din punctul dvs. de vedere, oferă virtualizarea?
5. De ce este necesară setarea timpului / fusului orar pe server?
6. Cât spațiu ocupă OS-ul instalat (discul virtual) pe mașina gazdă?
7. Ce recomandări există pentru partiționarea discului pentru servere? De ce se recomandă această partiționare?

## Prezentare

La prezentarea răspunsului atașați la sarcină link-ul către repository.

## Evaluare

- `1 punct` – raportul conține formularea sarcinii;
- `1 punct` – raportul conține descrierea creării imaginii de disc;
- `1 punct` – raportul conține descrierea instalării OS;
- `1 punct` – raportul conține descrierea instalării LAMP;
- `1 punct` – raportul conține descrierea configurării virtual hosts;
- `1 punct` – raportul conține descrierea instalării WordPress;
- `1 punct` – raportul conține descrierea instalării PhpMyAdmin;
- `1 punct` – raportul conține răspunsuri la întrebări;
- `1 punct` – raportul conține concluzii;
- `1 punct` – raportul este formatat conform cerințelor (format, bibliografie);
- `2 puncte` – susținerea lucrării;
- `-1 punct` – pentru fiecare zi de întârziere la predare;
- `-5 puncte` – pentru copierea codului de la alți studenți.
