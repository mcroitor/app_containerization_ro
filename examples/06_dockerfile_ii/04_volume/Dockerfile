# Usage: docker build -t ex_apache_volume .
# Usage: docker run -d -p 8080:80 \
#       -v html:/var/www/html \
#       --name ex_apache_volume ex_apache_volume
#       docker run -d -p 8080:80 --name ex_apache_volume ex_apache_volume
# Usage: docker exec -it ex_apache_volume bash
FROM debian

RUN apt-get update && apt-get install -y apache2

EXPOSE 80

VOLUME /var/www/html

CMD ["apache2ctl", "-D", "FOREGROUND"]

