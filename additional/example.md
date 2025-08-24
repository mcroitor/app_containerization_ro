# Exemplu de sarcina practica Docker Compose

Scrieți un exemplu de fișier `docker-compose.yml` pentru aplicația `WordPress + MariaDB`, care să îndeplinească următoarele cerințe:

1. Fișierul trebuie să descrie două servicii: `wordpress` și `mariadb`
2. Serviciul `wordpress` se bazează pe imaginea `wordpress:latest`
3. Serviciul `wordpress` este accesibil pe portul `80` al sistemului gazdă
4. Serviciul `wordpress` primește fișierul de mediu din fișierul `wordpress.env`
5. Serviciul `wordpress` depinde de serviciul `mariadb`
6. Serviciul `wordpress` rulează în rețeaua `internal`
7. Serviciul `wordpress` montează volumul `public-data` în directorul `/var/www/html/public` al containerului
8. Serviciul `mariadb` se bazează pe imaginea `mariadb:11`
9. Serviciul `mariadb` montează volumul `db-data` în directorul `/var/lib/mysql` al containerului
10. Serviciul `mariadb` primește variabilele de mediu din fișierul `mariadb.env`
11. Serviciul `mariadb` rulează în rețeaua `internal`
12. De asemenea, fișierul descrie volumele `public-data` și `db-data`
13. De asemenea, fișierul descrie rețeaua `internal`
