# Lucrare de laborator nr. 6: Interacțiunea containerelor

## Scopul lucrării

După realizarea acestei lucrări, studentul va putea gestiona interacțiunea dintre mai multe containere.

## Sarcină

Creați o aplicație PHP pe baza a două containere: nginx și php-fpm.

## Pregătire

Pentru realizarea acestei lucrări este necesar să aveți instalat pe calculator [Docker](https://www.docker.com/).

Este necesară experiența acumulată la lucrarea de laborator nr. 3.

## Realizare

Creați un repository `containers06` și clonați-l pe calculatorul dvs.

În directorul `containers06` creați directorul `mounts/site`. În acest director copiați site-ul PHP creat în cadrul disciplinei PHP.

Creați fișierul `.gitignore` în rădăcina proiectului și adăugați următoarele linii:

```gitignore
# Ignoră fișierele și directoarele
mounts/site/*
```

Creați în directorul `containers06` fișierul `nginx/default.conf` cu următorul conținut:

```nginx
server {
    listen 80;
    server_name _;
    root /var/www/html;
    index index.php;
    location / {
        try_files $uri $uri/ /index.php?$args;
    }
    location ~ \.php$ {
        fastcgi_pass backend:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

## Lansare și testare

Creați o rețea `internal` pentru containere.

Creați containerul `backend` cu următoarele proprietăți:

- bazat pe imaginea `php:7.4-fpm`;
- directorul `mounts/site` este montat în `/var/www/html` în container;
- funcționează în rețeaua `internal`.

Creați containerul `frontend` cu următoarele proprietăți:

- bazat pe imaginea `nginx:1.23-alpine`;
- directorul `mounts/site` este montat în `/var/www/html` în container;
- fișierul `nginx/default.conf` este montat în `/etc/nginx/conf.d/default.conf`;
- portul 80 al containerului este mapat la portul 80 al gazdei;
- funcționează în rețeaua `internal`.

Verificați funcționarea site-ului în browser, accesând adresa `http://localhost`. Dacă se afișează pagina implicită nginx, reîmprospătați pagina.

## Crearea raportului

Creați în folderul `containers06` fișierul `README.md` care să conțină pașii de realizare a proiectului. Descrierea proiectului trebuie să includă:

1. Denumirea lucrării de laborator.
2. Scopul lucrării.
3. Sarcina.
4. Descrierea realizării lucrării cu răspunsuri la întrebări.
5. Concluzii.

Răspundeți la întrebări:

1. Cum pot interacționa containerele între ele în acest exemplu?
2. Cum văd containerele unul pe celălalt în cadrul rețelei `internal`?
3. De ce a fost necesară suprascrierea configurației `nginx`?

Publicați proiectul pe GitHub.

## Prezentare

La prezentarea răspunsului atașați la sarcină link-ul către repository.

## Evaluare

- `1 punct` – a fost creat repository-ul `containers06`;
- `1 punct` – a fost creat fișierul `.gitignore`;
- `3 puncte` – a fost creat fișierul `nginx/default.conf`;
- `1 punct` – existența scopului lucrării în fișierul `README.md`;
- `1 punct` – existența sarcinii în fișierul `README.md`;
- `1 punct` – descrierea creării rețelei `internal`;
- `1 punct` – descrierea creării containerului `backend`;
- `1 punct` – descrierea creării containerului `frontend`;
- `3 puncte` – existența răspunsurilor la întrebări în fișierul `README.md`;
- `3 puncte` – existența concluziilor în fișierul `README.md`;
- `4 puncte` – susținerea lucrării;
- `-2 puncte` – pentru fiecare zi de întârziere la predare;
- `-10 puncte` – pentru copierea codului de la alte studenți.
