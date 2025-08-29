# Întrebări la tema "Rularea aplicațiilor containerizate"

Întrebări de tip _"single choice"_:

1. Ce comandă se utilizează pentru construirea imaginii?
  [x] `docker image build`
  [ ] `docker create`
  [ ] `docker image run`
  [ ] `docker image start`
2. Cu ce comandă se poate vizualiza imaginile existente?
  [x] `docker image ls`
  [ ] `docker image show`
  [ ] `docker view`
  [ ] `docker list`
3. Cu ce comandă se poate șterge imaginea?
  [x] `docker image rm`
  [ ] `docker delete`
  [ ] `docker remove`
  [ ] `docker remove image`
4. Cu ce comandă se poate crea un container?
  [x] `docker container create`
  [ ] `docker image build`
  [ ] `docker container build`
  [ ] `docker container start`
5. Cu ce comandă se poate porni containerul existent?
  [x] `docker container start`
  [ ] `docker container run`
  [ ] `docker container create`
  [ ] `docker container build`
6. Cu ce comandă se poate comunica cu containerul?
  [x] `docker container exec`
  [ ] `docker container run`
  [ ] `docker container start`
  [ ] `docker container stop`
7. Cu ce comandă se poate reporni containerul?
  [x] `docker container restart`
  [ ] `docker container start`
  [ ] `docker container run`
  [ ] `docker container stop`
8. Cu ce comandă se poate copia fișierele în container?
  [x] `docker container cp`
  [ ] `docker container mv`
  [ ] `docker container copy`
  [ ] `docker container move`
9. Cu ce comandă se poate citi log-urile containerului?
  [x] `docker container logs`
  [ ] `docker container show`
  [ ] `docker container view`
  [ ] `docker container list`
10. Cu ce comandă se poate vizualiza lista containerelor?
  [x] `docker container ls`
  [ ] `docker ls container`
  [ ] `docker container view`
  [ ] `docker image list`
11. Cu ce comandă se poate opri containerul?
  [x] `docker container stop`
  [ ] `docker stop container`
  [ ] `docker container remove`
  [ ] `docker container delete`
12. Cu ce comandă se poate șterge containerul?
  [x] `docker container rm`
  [ ] `docker remove container`
  [ ] `docker container delete`
  [ ] `docker container prune`
13. Fie dat fișierul `Dockerfile.sample`. Cu ce comandă se poate construi imaginea cu numele `myimage`?
  [x] `docker image build -t myimage -f Dockerfile.sample .`
  [ ] `docker image build -t myimage Dockerfile.sample`
  [ ] `docker image build --name myimage --file Dockerfile.sample .`
  [ ] `docker build -f Dockerfile.sample -t myimage`
14. Fie dată imaginea `myimage:1.0`. Cu ce comandă se poate crea containerul cu numele `mycontainer`?
  [x] `docker container create --name mycontainer myimage:1.0`
  [ ] `docker container create --name myimage:1.0 mycontainer`
  [ ] `docker create --name mycontainer myimage .`
  [ ] `docker build --name mycontainer myimage:1.0`
15. Fie dat containerul `mycontainer`. Cu ce comandă se poate porni containerul în modul daemon?
  [x] `docker start -d mycontainer`
  [ ] `docker run -d mycontainer`
  [ ] `docker run -d --name mycontainer`
  [ ] `docker start -d --name mycontainer`
16. Fie dat containerul pornit `mycontainer`. Cu ce comandă se poate conecta la container cu comanda `/bin/bash` pentru interacțiunea cu shell-ul?
  [x] `docker exec -it mycontainer /bin/bash`
  [ ] `docker run mycontainer /bin/bash`
  [ ] `docker start mycontainer /bin/bash`
  [ ] `docker container exec mycontainer /bin/bash`
17. Fie dat containerul pornit `mycontainer`. Cu ce comandă se poate citi ultimile 50 linii din log-urile containerului?
  [x] `docker logs -n 50 mycontainer`
  [ ] `docker container logs -f 50 mycontainer`
  [ ] `docker container show 50 mycontainer`
  [ ] `docker logs -f 50 mycontainer`
18. Fie dat containerul pornit `mycontainer`. Cu ce comandă se poate opri containerul?
  [x] `docker stop mycontainer`
  [ ] `docker container stop mycontainer`
  [ ] `docker container rm mycontainer`
  [ ] `docker container delete mycontainer`
19. FIe dată imaginea `myimage`. Cu ce comandă se poate porni containerul cu numele `mycontainer` și portul `8080` redirecționat la portul `80`?
  [x] `docker container run -d --name mycontainer -p 8080:80 myimage`
  [ ] `docker run -d --name mycontainer --ports 8080:80 myimage`
  [ ] `docker run --name mycontainer -p 8080 myimage`
  [ ] `docker run -d --name mycontainer --expose 8080:80 myimage`
20. Fie dat containerul pornit `mycontainer`. Cu ce comandă se poate copia fișierul `file.txt` în rădăcina containerului?
  [x] `docker container cp file.txt mycontainer:/`
  [ ] `docker image cp mycontainer:/file.txt .`
  [ ] `docker cp mycontainer:/file.txt /`
  [ ] `docker container write file.txt mycontainer:/file.txt`

Întrebări de tip _"răspuns scurt"_:

1. Pentru a construi o imagine `myimage` din `Dockerfile`, trebuie să executați comanda:
   - `docker build -t myimage .`
   - `docker build --tag myimage .`
2. Pentru a construi o imagine `webserver` din `Dockerfile.nginx`, trebuie să executați comanda:
   - `docker build -t webserver -f Dockerfile.nginx .`
   - `docker build -t webserver --file Dockerfile.nginx .`
   - `docker build --tag webserver -f Dockerfile.nginx .`
   - `docker build --tag webserver --file Dockerfile.nginx .`
   - `docker build --file Dockerfile.nginx --tag webserver .`
   - `docker build -f Dockerfile.nginx --tag webserver .`
   - `docker build --file Dockerfile.nginx -t webserver .`
   - `docker build -f Dockerfile.nginx -t webserver .`
3. Pentru a construi o imagine `sample` cu eticheta `1.0` din `Dockerfile`, trebuie să executați comanda:
   - `docker build -t sample:1.0 .`
   - `docker build --tag sample:1.0 .`
4. Pentru a construi o imagine `sample` din `Dockerfile`, care se află în directorul `php-fpm`, trebuie să executați comanda:
   - `docker build -t sample:1.0 php-fpm`
   - `docker build --tag sample:1.0 php-fpm`
   - `docker build -t sample:1.0 ./php-fpm`
   - `docker build --tag sample:1.0 ./php-fpm`
   - `docker build -t sample:1.0 php-fpm/`
   - `docker build --tag sample:1.0 php-fpm/`
   - `docker build -t sample:1.0 ./php-fpm/`
   - `docker build --tag sample:1.0 ./php-fpm/`
5. Pentru vizualizarea listei de imagini existente, utilizați comanda:
   - `docker images`
   - `docker image ls`
   - `docker image list`
6. Pentru a șterge imaginea `sample`, utilizați comanda:
   - `docker rmi sample`
   - `docker image rm sample`
   - `docker image remove sample`
7. Pentru a șterge imaginile `sample` și `webserver`, utilizați comanda:
   - `docker rmi sample webserver`
   - `docker rmi webserver sample`
   - `docker image rm sample webserver`
   - `docker image rm webserver sample`
   - `docker image remove sample webserver`
   - `docker image remove webserver sample`
8. Pentru a crea un container `mycontainer` pe baza imaginii `myimage`, utilizați comanda:
   - `docker create --name mycontainer myimage`
9. Pentru a porni containerul `mycontainer`, utilizați comanda:
   - `docker start mycontainer`
10. Pentru a crea un container pe baza imaginii `mariadb` și a-l porni imediat, utilizați comanda:
    - `docker run mariadb`
11. Pentru a crea un container pe baza imaginii `mariadb` cu numele `mydb` și a-l porni imediat, utilizați comanda:
    - `docker run --name mydb mariadb`
12. Pentru a crea un container pe baza imaginii `nginx` cu numele `web` și a-l porni imediat în fundal, utilizați comanda:
    - `docker run --name web -d nginx`
    - `docker run -d --name web nginx`
13. Vizualizarea listei de containere care rulează se poate face cu ajutorul comenzii:
    - `docker ps`
14. Vizualizarea listei de toate containerele se poate face cu ajutorul comenzii:
    - `docker ps -a`
15. Executarea comenzii `/etc/init.d/nginx reload` în containerul `nginx` care rulează se poate face cu ajutorul comenzii:
    - `docker exec nginx /etc/init.d/nginx reload`
16. Executarea comenzii `php /var/www/html/cli/cleancache.php` în containerul `php-fpm` care rulează se poate face cu ajutorul comenzii:
    - `docker exec php-fpm php /var/www/html/cli/cleancache.php`
17. Pentru a porni aplicatia `bash` în containerul `debian` care rulează cu modul interactiv activat, se utilizează comanda:
    - `docker exec -it debian bash`
    - `docker exec -i -t debian bash`
    - `docker exec -t -i debian bash`
    - `docker exec -t -i debian bash`
    - `docker exec -ti debian bash`
18. Pentru a opri containerul `mycontainer`, se utilizează comanda:
    - `docker stop mycontainer`
19. Pentru a șterge containerul `mycontainer`, se utilizează comanda:
    - `docker rm mycontainer`
20. Pentru a reporni containerul `mc`, se utilizează comanda:
    - `docker restart mc`
21. Pentru vizualizarea jurnalelor containerului `php-fpm`, se utilizează comanda:
    - `docker logs php-fpm`
22. Pentru vizualizarea jurnalelor containerului `web` în modul `follow`, se utilizează comanda:
    - `docker logs -f web`
    - `docker logs --follow web`
23. Pentru copierea fișierului `index.html` din containerul `web` din directorul `/var/www/html` în directorul local `./html`, se utilizează comanda:
    - `docker cp web:/var/www/html/index.html ./html`
    - `docker cp web:/var/www/html/index.html ./html/`
    - `docker cp web:/var/www/html/index.html html/`
    - `docker cp web:/var/www/html/index.html html`
24. Pentru copierea fișierului `index.html` din directorul local `./html` în directorul `/var/www/html` al containerului `web`, se utilizează comanda:
    - `docker cp ./html/index.html web:/var/www/html`
    - `docker cp ./html/index.html web:/var/www/html/`
    - `docker cp html/index.html web:/var/www/html`
    - `docker cp html/index.html web:/var/www/html/`
25. În container în baza imaginii `myserver` poate fi pornită comanda `/bin/sh` cu ajutorul comenzii:
    - `docker run -it myserver /bin/sh`
    - `docker run -i -t myserver /bin/sh`
    - `docker run -t -i myserver /bin/sh`
    - `docker run -ti myserver /bin/sh`
