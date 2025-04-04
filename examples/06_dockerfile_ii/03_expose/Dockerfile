# Usage: docker build -t 06_dockerfile_ii_03_expose .
# Usage: docker run -d -p 8080:80 06_dockerfile_ii_03_expose
# Usage: curl http://localhost:8080

FROM debian

RUN apt-get update && apt-get install -y apache2

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]
# CMD "apache2ctl -D FOREGROUND"
