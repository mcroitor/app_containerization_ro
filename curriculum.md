# Virtualizare și containerizare

## Cardul cursului

- __Facultatea__: Facultatea de Matematică și Informatică
- __Curs__: Virtualizare și containerizare
- __Ciclul de învățare__: Ciclul 1, Licență
- __Programă / Specialitate__: S.A.35 / Informatică
- __Semestrul__: 4
- __Autor__: Croitor Mihail

## INTRODUCERE

### Prezentare generală a cursului

În lumea tehnologiilor informaționale moderne, virtualizarea și containerizarea au devenit instrumente esențiale pentru dezvoltarea, implementarea și administrarea aplicațiilor. Aceste tehnologii permit utilizarea eficientă a resurselor, asigură izolarea aplicațiilor și simplifică procesele de implementare și scalare. Utilizarea mașinilor virtuale și a containerelor le permite dezvoltatorilor și administratorilor de sistem să creeze soluții flexibile și scalabile, care pot funcționa în diverse medii, de la servere locale până la platforme Cloud. De asemenea, aspectul economic este important, deoarece utilizarea virtualizării și containerizării permite reducerea semnificativă a costurilor pentru echipamente și exploatarea serverelor.

În cadrul acestui curs sunt analizate principalele tehnologii de virtualizare (pe baza _Qemu_) și containerizarea aplicațiilor (pe baza _Docker_). Sunt abordate conceptele de bază, crearea mașinilor virtuale, crearea imaginilor, lansarea containerelor, interacțiunea cu containerele, orchestrarea containerelor, procesele CI/CD, optimizarea imaginilor.

Cursul de _Virtualizare și containerizare_ ocupă un loc important în dezvoltarea competențelor practice și teoretice ale studenților din programul 0613.4 Informatică. Cursul are dependența strictă de la cursuri `Sisteme de operare`, `Baze de date`, `Rețele de calculatoare`.

Studenții vor dobândi competențe precum:

- Înțelegerea conceptelor de bază ale virtualizării și containerizării.
- Abilitatea de a crea și administra mașini virtuale folosind Qemu.
- Abilitatea de a crea și administra containere folosind Docker.
- Cunoașterea elementelor de bază ale orchestrării containerelor cu Docker Compose.
- Înțelegerea principiilor CI/CD și capacitatea de a le aplica în contextul virtualizării și containerizării.
- Abilitatea de a optimiza imaginile containerelor pentru a crește performanța și a reduce dimensiunea acestora.

La finalul cursului, studenții vor cunoaște conceptele de bază ale virtualizării și containerizării, precum și vor putea aplica cunoștințele dobândite în practică. Studenții vor putea crea sisteme informaționale complexe și infrastructura aferentă acestora utilizând cunoștințele acumulate, precum și să optimizeze soluțiile existente.

Cursul este predat în limbile română și rusă, pentru a răspunde nevoilor lingvistice ale studenților din cadrul Universității de Stat din Moldova. Acest aspect asigură accesibilitatea materialelor de studiu și facilitează comunicarea eficientă în timpul activităților didactice și de laborator.

Beneficiarii principali ai acestui curs sunt:

- Studenții programului de licență 0613.4 Informatică, care își vor consolida cunoștințele în DevOps.
- Profesioniști din domeniul IT, interesați de actualizarea competențelor lor în testarea de penetrare și protecția rețelelor.

## I. ADMINISTRAREA DISCIPLINEI

| Forma de învățământ | Codul unității de curs | Denumirea unității de curs     | Responsabil de unitatea de curs | Semestrul | Total | C   | S   | L   | LI  | Evaluare | Credite |
| ------------------- | ---------------------- | ------------------------------ | ------------------------------- | --------- | ----- | --- | --- | --- | --- | -------- | ------- |
| cu frecvență        | S.A.35                 | Virtualizare și Containerizare | M. Croitor, lect. univ.         | IV        | 120   | 26  | 0   | 52  | 52  | E        | 4       |

> __C__ - curs, __S__ - seminar, __L__ - lucrări de laborator, __LI__ – lucrări individuale

## II. TEMELE CURSULUI ȘI REPARTIZAREA ORIENTATIVĂ A ORELOR

| Nr. | Tema                                                          | Curs | Seminar | Laborator | Lucrul individual |
| --- | ------------------------------------------------------------- | ---- | ------- | --------- | ----------------- |
| 1.  | Introducere                                                   | 2    | 0       | 4         | 4                 |
| 2.  | Noțiuni de bază                                               | 2    | 0       | 0         | 0                 |
| 3.  | Virtualizarea                                                 | 2    | 0       | 4         | 4                 |
| 4.  | Sintaxa Dockerfile                                            | 2    | 0       | 4         | 4                 |
| 5.  | Pornirea aplicatiilor containerizate                          | 2    | 0       | 4         | 4                 |
| 6.  | Comenzile suplimentare din Dockerfile                         | 2    | 0       | 4         | 4                 |
| 7.  | Interacțiunea containerelor                                   | 2    | 0       | 4         | 4                 |
| 8.  | Crearea unui cluster de containere cu ajutorul Docker Compose | 2    | 0       | 0         | 0                 |
| 9.  | Particularitățile configurării clusterului de containere      | 2    | 0       | 8         | 8                 |
| 10. | Integrarea continuă și livrarea continuă (CI / CD)            | 2    | 0       | 4         | 4                 |
| 11. | Optimizarea imaginii containerului                            | 2    | 0       | 4         | 4                 |
| 12. | Gestionarea secretelor                                        | 2    | 0       | 4         | 4                 |
| 13. | Practici bune în elaborarea containerelor                     | 2    | 0       | 0         | 0                 |
|     | Total                                                         | 26   | 0       | 52        | 52                |

## III. COMPETENȚE GENERALE ȘI SPECIALE, REZULTATELE ÎNVĂȚĂRII

| __Competențe generale și profesionale__ | __Rezultate ale învățării conform nivelului CNC__<br>_Absolventul/candidatul la atribuirea calificării poate:_ |
| ------ | ------ |
| **CG 2.** Operarea cu concepte de bază din știința calculatoarelor, tehnologia informației și comunicațiilor | **RÎ3.** aplica conceptele din știința calculatoarelor, tehnologia informației și comunicațiilor pentru proiectarea și administrarea sistemelor informaționale.<br>**RÎ4.** dezvolta sisteme informaționale folosind cunoștințe referitoare la limbaje, medii și tehnologii de programare și instrumente de proiectare. |
| **CP 1.** Descrierea funcțională a sistemului informatic utilizând tehnici, modele și algoritmi din domeniu | **RÎ10.** elabora modelul constructiv-funcțional prin utilizarea tehnicilor, modelelor și algoritmilor din domeniu, aplicând metode de modelare, sinteză, analiză, precum și optimizare a sistemelor. |
| **CP 2.** Proiectarea sistemelor și integrarea componentelor unui sistem informatic | **RÎ11.** proiecta aplicații software de uz general și dedicat, prin aplicarea metodelor de modelare, sinteză, analiză și optimizare a sistemelor informatice.<br />**RÎ12.** dezvolta conceptul de realizare și funcționare a sistemului proiectat, precum și a unor ansambluri parțiale integrate în subsistemul informatic. |
| **CP 3.** Validarea aplicațiilor informatice | **RÎ13.** testa sistemele informatice pentru verificarea integrității, funcționalității generale a sistemului și a interacțiunii între componentele sale.<br />**RÎ14.** realiza simulări pentru validarea corectitudinii modelelor și algoritmilor, asigurând compatibilitatea componentelor cu cerințele și obiectivele stabilite. |
| **CP 4.** Mentenanța și optimizarea sistemului informatic | **RÎ15.** planifica lucrările de mentenanță pentru a asigura buna funcționare a sistemului informatic. |

## IV. UNITĂȚILE DE ÎNVĂȚARE

### Tema 1: Introducere

#### Termeni-cheie

Containerizare, virtualizare, izolarea procesului.

#### Subteme

- Virtualizare;
- Containerizare;
- Istoria dezvoltării virtualizării și containerizării;
- Noțiuni de bază.

#### Activități de laborator

- Crearea contului pe GitHub;
- Pregătirea paginii personale pe GitHub;
- Familiarizarea cu comenzile GIT;
- Familiarizarea cu format Markdown;
- Familiarizarea cu procesele de lucru cu ramuri de cod sursă.

#### Abilități

- Înțelege scopul izolației aplicațiilor;
- Cunoaște principiile containerizării și virtualizării;
- Demonstrează utilizarea comenzilor GIT.

#### Responsabilitate și autonomie

- Crearea unui repozitoriu GIT;
- Gestionarea ramurilor;
- Formatarea textului în Markdown.

### Tema 2: Noțiuni de bază

#### Termeni-cheie

Imagine, container, orchestrare, serviciu, microserviciu, client, server.

#### Subteme

- Noțiuni de hardware;
- Noțiuni de rețea;
- Noțiuni de arhitectură;
- Noțiuni de Cloud Computing.

#### Abilități

- Înțelege conceptele de bază ale arhitecturii sistemelor informatice;
- Înțelege principiile de bază ale Cloud Computing;
- Poate descrie diferențele dintre imagine, container, serviciu.

#### Responsabilitate și autonomie

- Familiarizarea cu dicționarul domeniului.

### Tema 3: Virtualizarea SO

#### Termeni-cheie

Virtualizare, emulare, hipervizor, Open Virtualization Format.

#### Subteme

- Noțiunea de virtualizare;
- Tipuri de virtualizare;
- Hipervizorii;
- Virtualizarea pe baza QEMU;
- Open Virtualization Format.

#### Activități de laborator

- Instalarea QEMU;
- Crearea imaginii de disc;
- Instalarea Debian în mașina virtuala;
- Instalarea și configurarea LAMP;
- Instalarea Drupal;
- Instalarea PhpMyAdmin.

#### Abilități

- Înțelege conceptele de bază ale virtualizării sistemelor de operare;
- Poate crea și gestiona mașini virtuale utilizând QEMU;
- Poate configura SO Debian în proces de instalare;
- Poate configura un server web în baza LAMP.

#### Responsabilitate și autonomie

- Crearea unui mediu de dezvoltare virtualizat;
- Gestionarea resurselor alocate mașinilor virtuale;
- Asigurarea securității și izolării aplicațiilor în medii virtualizate;
- Configurarea serverului web în baza LAMP.

### Tema 4: Sintaxa Dockerfile

#### Termeni-cheie

Imagine, Docker, container, dockerfile, strat, context.

#### Subteme

- Ce este Docker;
- Arhitectura fișierului Dockerfile;
- Instrucțiuni Dockerfile: FROM, COPY, ADD, RUN, CMD, ENTRYPOINT, WORKDIR, USER.

#### Activități de laborator

- Crearea unei imagini al containerului;
- Crearea containerului;
- Pornirea containerului;
- Conectarea la container și perfectarea unor evaluări;
- Oprirea și ștergerea containerului.

#### Abilități

- Înțelege conceptele de bază ale Docker și containerizării;
- Poate crea și gestiona imagini Docker;
- Poate afla informație despre instrumentele Docker din linia de comandă;
- Poate scrie fișiere Dockerfile.

#### Responsabilitate și autonomie

- Elaborează un fișier Dockerfile pentru o aplicație simplă;
- Crează, lansează și comunică cu un container Docker;
- Cunoaște procesul de construire a imaginilor containerelor.

### Tema 5: Pornirea aplicatiilor containerizate

#### Termeni-cheie

Imagine, container, serviciu.

#### Subteme

- Instrumente Docker;
- Asamblarea imaginilor;
- Managementul imaginilor;
- Managementul containerelor;
- Comunicarea cu containere.

#### Activități de laborator

- Utilizarea containerelor ca medii de execuție;
- Familiarizarea cu comenzile de bază Ubuntu / Debian.

#### Abilități

- Cunoaște instrumentele Docker și comenzile de bază;
- Poate gestiona imaginile containerelor;
- Poate gestiona containerele Docker;
- Cunoaște comenzile Ubuntu / Debian de bază.

#### Responsabilitate și autonomie

- Gestionarea imaginilor și containerelor Docker;
- Utilizarea containerelor ca medii de execuție pentru testarea aplicațiilor.

### Tema 6: Comenzile suplimentare din Dockerfile

#### Termeni-cheie

Variabila de sistem, argument de construire, metadate.

#### Subteme

- Variabile la construirea imaginii;
- Interacțiunea cu containerul;
- Metadatele imaginii;
- Comenzile suplimentare.

#### Activități de laborator

- Crearea structurii unui proiect complex;
- Configurarea Apache HTTP Server;
- Configurarea PHP;
- Configurarea MariaDB;
- Configurarea supervisor;
- Instalarea WordPress.

#### Abilități

- Înțelege diferența dintre variabilele de mediu și argumentele de construire;
- Poate utiliza corect variabilele de mediu și argumentele de construire în Dockerfile;
- Poate crea un Dockerfile complex utilizând variabile de mediu și argumente de construire;
- Poate defini metadate pentru imaginea Docker;
- Poate schimba utilizatorul care rulează aplicația în container.

#### Responsabilitate și autonomie

- Crearea unei imagini containerului complexe;
- Familiarizarea cu configurația Apache HTTP Server;
- Familiarizarea cu configurația PHP;
- Familiarizarea cu configurația MariaDB;
- Familiarizarea cu configurația Supervisor;
- Familiarizarea cu proces de instalare și configurare WordPress.

### Tema 7: Interacțiunea containerelor

#### Termeni-cheie

Volum, montare, rețea virtuală.

#### Subteme

- Sistem de fișiere;
- Rețea.

#### Activități de laborator

- Crearea rețelelor;
- Crearea volumelor;
- Montarea volumelor;
- Organizarea comunicării dintre containere.

#### Abilități

#### Responsabilitate și autonomie

### Tema 8: Crearea unui cluster de containere cu ajutorul Docker Compose

#### Termeni-cheie

Cluster de containere, docker-compose.yml, orchestrare.

#### Subteme

- Scopul Docker Compose;
- Sintaxa docker-compose.yml;
- Un exemplu de cluster de containere;
- Gestionarea clusterului de containere.

#### Abilități

#### Responsabilitate și autonomie

### Tema 9: Particularitățile configurării clusterului de containere

#### Termeni-cheie

Fișiere de mediu, variabile de mediu, resursă, healthcheck.

#### Subteme

- Argumente la construirea imaginii;
- Variabile de mediu;
- Limitarea resurselor;
- Acces către procesor grafic;
- Verificarea stării containerului (healthcheck).

#### Activități de laborator

- Familiarizarea cu format docker-compose.yml;
- Configurarea Nginx;
- Configurarea PHP-FPM;
- Crearea serviciilor cu ajutorul containerilor;
- Montarea volumelor și directoriilor;
- Utilizarea variabilelor de sistem;
- Utilizarea secretelor;
- Configurarea healthcheck.

#### Abilități

#### Responsabilitate și autonomie

### Tema 10: Integrarea continuă și livrarea continuă (CI / CD)

#### Termeni-cheie

Integrarea continuă, livrarea continuă, pipeline, testare automată, continuous integration (CI), continuous deployment (CD), continuous delivery.

#### Subteme

- Integrarea continuă;
- Livrarea continuă;
- Un exemplu de proces CI / CD;
- Utilizarea containerelor în procesele CI / CD.

#### Activități de laborator

- Definirea procesului CI
- Familiarizarea cu GitHub Actions;
- Utilizarea containerelor în CI.

#### Abilități

#### Responsabilitate și autonomie

### Tema 11: Optimizarea imaginii containerului

#### Termeni-cheie

Imagine de bază minimă, strat, .dockerignore, multistage building.

#### Subteme

- Informație despre imagine;
- Imaginea de bază minimă;
- Construirea în mai multe etape;
- Ștergerea fișierelor neutilizate;
- Reducerea numărului de straturi;
- Repachetarea imaginii;
- Utilizarea .dockerignore;
- Păstrarea datelor în afara imaginii;
- Utilizarea cache-ului pentru straturile imaginii.

#### Activități de laborator

- Ștergerea fișierelor temporare și a dependențelor neutilizate;
- Reducerea numărului de straturi;
- Utilizarea unei imagini de bază minime;
- Reambalarea imaginii.

#### Abilități

#### Responsabilitate și autonomie

### Tema 12: Gestionarea secretelor

#### Termeni-cheie

Secret, datele sensibile, Pod Security Standard, Network Policy.

#### Subteme

- Metode de bază a securității;
- Utilizarea secretelor în Docker;
- Utilizarea secretelor în Docker Compose.

#### Activități de laborator

- Utilizarea secretelor;
- utilizarea fișierelor de mediu.

#### Abilități

#### Responsabilitate și autonomie

### Tema 13: Practici bune în elaborarea containerelor

#### Termeni-cheie

Rootless, minimizarea dependențelor, securizarea datelor, context.

#### Subteme

- Privilegii excesive;
- Dependențe;
- Securizarea datelor;
- Optimizarea imaginii containerului.

#### Abilități

#### Responsabilitate și autonomie

## V. LUCRĂRI INDIVIDUALE

## VI. RECOMANDĂRI METODOLOGICE PENTRU PREDARE, ÎNVĂȚARE ȘI EVALUARE

## VII. LITERATURA RECOMANDATĂ
