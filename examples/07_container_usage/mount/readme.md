# mount sample

Doua containere `read` si `write` monteaza acelasi volum. In containerul `write` se creeaza un fisier, containerul `read` il citeste si il afiseaza in consola. Containerul `read` este creat pe baza fisierului `dockerfile.read`, containerul `write` pe baza fisierului `dockerfile.write`.

```bash
docker image build -t read --arg-build TIMEOUT=7 -f dockerfile.read .
docker image build -t write -f dockerfile.write .
docker volume create opt
docker container run -d -v opt:/opt --name write write
docker container run -d -v opt:/opt --name read read
```
