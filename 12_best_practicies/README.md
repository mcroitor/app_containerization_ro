# Practici bune în elaborarea containerelor

- [Practici bune în elaborarea containerelor](#practici-bune-în-elaborarea-containerelor)
  - [Privilegii excesive](#privilegii-excesive)
    - [Rularea aplicațiilor cu utilizator non-root](#rularea-aplicațiilor-cu-utilizator-non-root)
    - [Interzicerea modificării fișierelor executabile](#interzicerea-modificării-fișierelor-executabile)
  - [Dependențe](#dependențe)
    - [Utilizarea build-urilor multi-stage](#utilizarea-build-urilor-multi-stage)
    - [Imagini de bază verificate](#imagini-de-bază-verificate)
    - [Actualizarea la timp a imaginilor](#actualizarea-la-timp-a-imaginilor)
    - [Porturi deschise](#porturi-deschise)
  - [Protecția datelor](#protecția-datelor)
    - [Date sensibile](#date-sensibile)
    - [ADD și COPY](#add-și-copy)
    - [Contextul build-ului](#contextul-build-ului)
    - [Jurnale](#jurnale)
  - [Diverse](#diverse)
    - [Ordinea layerelor](#ordinea-layerelor)
    - [Metadate](#metadate)
    - [Scanarea imaginilor pentru vulnerabilități](#scanarea-imaginilor-pentru-vulnerabilități)
  - [Concluzii](#concluzii)
  - [Bibliografie](#bibliografie)

Un `Dockerfile` bine pregătit elimină necesitatea utilizării containerelor privilegiate, deschiderii porturilor inutile, includerii pachetelor suplimentare și evită scurgerea datelor sensibile. Aceste probleme trebuie rezolvate din start pentru a reduce efortul de mentenanță al aplicațiilor dezvoltate.

## Privilegii excesive

### Rularea aplicațiilor cu utilizator non-root

__Rulați aplicațiile cu un utilizator cu privilegii minime.__

Conform raportului [Sysdig 2021 container security and usage report](https://sysdig.com/blog/sysdig-2021-container-security-usage-report/), 58% dintre containere sunt lansate cu utilizatorul `root`. Utilizarea `root` în containere poate duce la vulnerabilități grave de securitate. Se recomandă rularea aplicațiilor cu un utilizator cu privilegii minime, folosind directiva `USER` în Dockerfile.

Pentru a configura un utilizator non-root, trebuie să:

- vă asigurați că utilizatorul există în imagine (creați-l);
- setați permisiunile necesare pe fișierele și directoarele folosite de aplicație.

Exemplu Dockerfile:

```Dockerfile
FROM ubuntu:20.04

# Crearea utilizatorului și setarea permisiunilor
RUN adduser --no-create-home --disabled-login myuser && \
    chown -R myuser:myuser /app-data

# Copierea aplicației
COPY app /app

# Setarea utilizatorului de lucru
USER myuser

ENTRYPOINT ["/app"]
```

### Interzicerea modificării fișierelor executabile

__Interziceți modificarea fișierelor executabile.__

În containerele Docker, fișierele cu atributul `+x` pot fi modificate la rulare. Acest lucru poate duce la modificarea fișierelor executabile și la vulnerabilități. Pentru a preveni modificarea fișierelor executabile, se recomandă utilizarea directivei `COPY` în loc de `ADD` și setarea atributelor fișierelor după copiere.

Este recomandat ca root să fie proprietarul fișierelor executabile, astfel acestea nu vor putea fi modificate de alți utilizatori. Astfel, containerul va fi imutabil și sigur, evitând modificări accidentale sau malițioase ale aplicației.

Utilizatorul containerului trebuie să aibă doar drepturi de citire și execuție.

```Dockerfile
FROM ubuntu:20.04

# Crearea utilizatorului
RUN adduser --no-create-home --disabled-login myuser && \
    chown -R myuser:myuser /app-data

# Copierea aplicației
COPY app /app

RUN chmod +x-w /app

# Setarea utilizatorului de lucru
USER myuser

ENTRYPOINT ["/app"]
```

## Dependențe

__Minimizați dimensiunea imaginii.__

Evitați instalarea pachetelor neutilizate sau deschiderea porturilor suplimentare – acestea pot crește suprafața de atac. Cu cât includeți mai multe componente în container, cu atât sistemul va fi mai vulnerabil și mai dificil de întreținut, mai ales pentru componentele care nu sunt sub controlul dvs.

### Utilizarea build-urilor multi-stage

__Utilizați build-uri multi-stage.__

O metodă eficientă de a reduce dimensiunea imaginii este utilizarea build-urilor multi-stage. Acest lucru permite separarea procesului de build și rulare pe mai multe etape, fiecare cu propria imagine. De exemplu, puteți folosi o imagine pentru build și alta pentru rulare.

Astfel, se creează un container intermediar cu toate dependențele necesare pentru build (instrumente, pachete, fișiere temporare). În imaginea finală rămân doar fișierele executabile și bibliotecile necesare pentru rulare. Build-ul multi-stage nu doar reduce dimensiunea imaginii, ci și crește securitatea, deoarece un atacator nu va avea acces la instrumentele de build și fișierele temporare.

### Imagini de bază verificate

__Alegeți cu atenție imaginile de bază.__

Containerele bazate pe imagini neverificate sau neactualizate vor moșteni toate problemele și vulnerabilitățile acestor imagini.

Ideal este să creați imaginea de la zero (`scratch`), dar acest lucru este potrivit doar pentru binare statice.

O alternativă bună este utilizarea imaginilor `Distroless`, care conțin doar bibliotecile și instrumentele minime necesare pentru rularea aplicației. Acest lucru reduce dimensiunea imaginii și suprafața de atac.

- [Google Distroless Container Tools](https://github.com/GoogleContainerTools/distroless) – bazate pe Debian, pentru C/C++, Go, Rust, Java, Python, Node.js.
- [Chainguard Images](https://github.com/chainguard-images) – imagini mici și sigure, bazate pe Alpine Linux, pentru .NET, php, Ruby etc.

Se recomandă și utilizarea imaginilor oficiale, deoarece acestea sunt actualizate și verificate periodic.

### Actualizarea la timp a imaginilor

__Utilizați imagini de bază actualizate și actualizați regulat propriile imagini.__

Procesul de identificare a vulnerabilităților este continuu, deci este important să actualizați regulat imaginile cu ultimele patch-uri de securitate.

Nu este necesar să folosiți mereu cea mai nouă versiune, care poate conține vulnerabilități critice, dar trebuie să urmați o strategie de versionare:

- Folosiți versiuni stabile sau cu suport pe termen lung, care primesc rapid patch-uri de securitate;
- Fiți pregătiți să migrați la versiuni noi înainte de expirarea suportului pentru imaginea de bază;
- Periodic reconstruiți propriile imagini pentru a obține ultimele pachete din distribuții, Node, Golang, Python etc. Majoritatea managerilor de pachete (composer, npm, go mod, pip, poetry) permit setarea intervalelor de versiuni pentru a urmări ultimele actualizări de securitate.

### Porturi deschise

__Deschideți doar porturile necesare.__

Fiecare port deschis în container este o poartă spre sistemul dvs. Lăsați deschise doar porturile necesare aplicației și evitați porturi precum `SSH (22)`.

Comanda `EXPOSE` din Dockerfile are rol informativ. Deschiderea porturilor nu permite automat conectarea la ele la rularea containerului (dacă nu folosiți `docker run --publish-all`), deci trebuie să specificați porturile la lansare.

Folosiți `EXPOSE` doar pentru documentare și utilizați porturile respective la lansarea containerelor.

## Protecția datelor

Fiți atenți la lucrul cu containerele pentru a evita scurgerea accidentală a datelor.

### Date sensibile

__Nu includeți niciodată date sensibile (parole, chei, certificate) în Dockerfile.__

Imaginea creată poate fi citită ușor, iar datele pot fi extrase de atacatori.

Fiți atenți la copierea fișierelor în container. Chiar dacă un fișier important este șters în layerele ulterioare, el poate fi accesat în layerele anterioare.

Recomandări:

- Dacă aplicația suportă variabile de mediu, folosiți-le pentru transmiterea datelor sensibile sau utilizați Docker Secrets;
- Folosiți fișiere de configurare și montați-le la rularea containerului.

Imaginile nu trebuie să conțină informații sensibile sau parametri de configurare specifici mediului (`dev`, `qa`, `prod` etc.).

### ADD și COPY

__Preferă comanda `COPY` în loc de `ADD`.__

Instrucțiunile `ADD` și `COPY` au funcții similare – copiază fișiere din contextul build-ului în imagine. Totuși, `COPY` este preferată, deoarece procesul este predictibil și mai sigur.

`ADD` are funcții suplimentare, precum dezarhivarea automată și descărcarea fișierelor de pe URL, ceea ce poate fi periculos și poate duce la scurgeri de date sau vulnerabilități.

Pentru descărcarea pachetelor de pe link, este mai bine să folosiți `RUN` cu `wget` sau `curl`, să dezarhivați și să ștergeți arhiva, reducând numărul de layere.

Build-urile multi-stage rezolvă această problemă și permit copierea fișierelor din arhive dezarhivate în etape anterioare.

### Contextul build-ului

__Evitați copierea întregului context de build în imagine.__

Este o practică proastă să copiați tot contextul build-ului, deoarece poate duce la scurgerea datelor sensibile.

Conform best practices, creați un folder cu fișierele ce trebuie copiate în imagine și folosiți-l ca context de build. Astfel, evitați copierea accidentală a datelor sensibile și reduceți dimensiunea contextului.

Folosiți fișierul `.dockerignore` pentru a exclude fișierele și directoarele inutile din contextul build-ului.

### Jurnale

__Verificați jurnalele pentru date sensibile.__

Jurnalele pot conține date sensibile, precum parole, chei sau informații personale. Fiți atenți la scrierea jurnalelor în container.

Folosiți variabile de mediu pentru configurarea nivelului de jurnalizare și montați directoare pentru jurnale în afara containerului.

## Diverse

### Ordinea layerelor

__Așezați instrucțiunile în Dockerfile în ordinea descrescătoare a frecvenței modificărilor.__

Ordinea instrucțiunilor din Dockerfile influențează cache-ul layerelor. La modificarea unei instrucțiuni, toate cele ulterioare vor fi reconstruite, crescând timpul de build.

Instrucțiunile care se modifică rar (instalarea dependențelor, copierea fișierelor) trebuie plasate la început, iar cele care se modifică des (compilarea codului, instalarea pachetelor) la final.

Ordine greșită:

```Dockerfile
FROM ubuntu:20.04

COPY . /app

RUN apt-get update && apt-get install -y python3

CMD ["python3", "/app/app.py"]
```

Ordine corectă:

```Dockerfile
FROM ubuntu:20.04

RUN apt-get update && apt-get install -y python3

COPY . /app

CMD ["python3", "/app/app.py"]
```

### Metadate

__Includeți metadate în imagine.__

Este recomandat să includeți metadate la crearea imaginii. Metadatele ajută la identificarea imaginii, conțin informații despre versiune, autor, licență și alte atribute importante.

### Scanarea imaginilor pentru vulnerabilități

__Verificați regulat imaginile pentru vulnerabilități.__

Testați regulat imaginile pentru erori și vulnerabilități. Există multe instrumente care automatizează acest proces:

- [Docker Scout](https://docs.docker.com/scout/)
- [Trivy](https://trivy.dev)
- [Clair](https://www.redhat.com/en/topics/containers/what-is-clair)

## Concluzii

Respectarea recomandărilor la scrierea Dockerfile-urilor va îmbunătăți securitatea și fiabilitatea containerelor. Veți evita multe probleme legate de scurgerea datelor, vulnerabilități și dificultăți de mentenanță.

Există multe alte recomandări (de exemplu, semnarea imaginilor, utilizarea `HEALTHCHECK`) care nu au fost acoperite aici, deci consultați literatura din bibliografie.

## Bibliografie

1. [Overview of best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
2. [Docker Security](https://docs.docker.com/engine/security/)
3. [Newcomb Aaron, Sysdig 2021 container security and usage report: Shifting left is not enough, 2021](https://sysdig.com/blog/sysdig-2021-container-security-usage-report/)
4. [Iradier Álvaro, Top 20 Dockerfile best practices, 2021](https://sysdig.com/blog/dockerfile-best-practices/)
5. [antonkh, Distroless контейнеры, habr.com, 2023](https://habr.com/ru/articles/710968/)
