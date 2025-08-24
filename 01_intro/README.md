# Introducere

- [Introducere](#introducere)
  - [Virtualizare](#virtualizare)
    - [Noțiunea de virtualizare](#noțiunea-de-virtualizare)
    - [Motivele apariției virtualizării](#motivele-apariției-virtualizării)
    - [Domenii de aplicare](#domenii-de-aplicare)
    - [Avantaje și dezavantaje](#avantaje-și-dezavantaje)
  - [Containerizare](#containerizare)
    - [Ideea izolării proceselor](#ideea-izolării-proceselor)
    - [Noțiunea de containerizare](#noțiunea-de-containerizare)
    - [Domenii de aplicare](#domenii-de-aplicare-1)
    - [Avantaje și dezavantaje](#avantaje-și-dezavantaje-1)
  - [Istoria dezvoltării virtualizării și containerizării](#istoria-dezvoltării-virtualizării-și-containerizării)
  - [Bibliografie](#bibliografie)
  - [Lista de termeni](#lista-de-termeni)

<div class="epigraph">

_Stăteau sub copac, îmbrățișați pe după umeri, și Alice a înțeles imediat cine este Tweedledum și cine este Tweedledee, pentru că pe gulerul unuia era brodat „TWEEDLE”, iar pe al celuilalt – „DEE”._ --- Lewis Carroll, „Alice în Țara Oglinzilor”

</div>

## Virtualizare

Virtualizarea joacă un rol important în tehnologiile informaționale moderne și ocupă un loc central în domeniul cloud computing. Ea permite rularea mai multor mașini virtuale pe un singur server fizic, ceea ce crește eficiența utilizării resurselor hardware și simplifică gestionarea infrastructurii.

De asemenea, virtualizarea este folosită pentru crearea de medii izolate de dezvoltare și testare a software-ului, ceea ce contribuie la creșterea calității și securității aplicațiilor.

### Noțiunea de virtualizare

__Virtualizarea__ este o tehnologie care permite rularea unei instanțe a unui sistem de operare în cadrul altui sistem de operare (numit __gazdă__). Pentru aceasta se folosește un __hipervizor__ — un program care emulează resursele hardware (procesor, memorie, spațiu pe disc, interfețe de rețea etc.) și creează mașini virtuale pe care se instalează sisteme de operare.

Fiecare mașină virtuală este complet izolată, are propriile procese, sistem de fișiere, interfețe de rețea, utilizatori și nucleu de sistem de operare. Mașinile virtuale pot rula sisteme de operare diferite față de gazdă.

### Motivele apariției virtualizării

Virtualizarea a apărut din necesitatea de a distribui eficient resursele de calcul între mai mulți utilizatori pe o singură mașină fizică. În timp, a devenit baza pentru cloud computing și infrastructurile IT moderne.

### Domenii de aplicare

Virtualizarea este folosită pentru consolidarea serverelor, creșterea rezilienței și scalabilității, optimizarea utilizării resurselor hardware, precum și pentru crearea de medii izolate de dezvoltare și testare.

### Avantaje și dezavantaje

| Avantaje                                               | Dezavantaje                          |
| ------------------------------------------------------ | ------------------------------------ |
| Posibilitatea de a rula mai multe OS pe un singur PC   | Cerințe crescute de resurse          |
| Scalabilitate                                          | Necesitatea unor cunoștințe speciale |
| Izolare                                                | Probleme de licențiere               |
| Gestionare flexibilă a resurselor                      |                                      |

## Containerizare

Containerizarea este o tehnologie de izolare a aplicațiilor la nivelul sistemului de operare, folosind nucleul comun al gazdei și mecanismele nucleului OS (namespaces, cgroups etc.) pentru izolare și gestionarea resurselor. Spre deosebire de virtualizare, containerele nu emulează hardware-ul și nu necesită rularea unui sistem de operare invitat separat pentru fiecare aplicație.

Containerizarea permite rularea mai multor instanțe izolate de aplicații (containere) pe o singură gazdă, ceea ce crește eficiența utilizării resurselor hardware și simplifică gestionarea infrastructurii.

### Ideea izolării proceselor

Aplicațiile moderne folosesc adesea o arhitectură modulară și necesită anumite biblioteci și dependențe. Containerizarea permite livrarea aplicației împreună cu toate dependențele necesare, asigurând funcționarea acesteia indiferent de mediul gazdei.

Izolarea se realizează cu ajutorul mecanismelor nucleului OS, precum namespaces și cgroups, permițând rularea mai multor procese în cadrul unui singur sistem de operare, dar cu resurse izolate unele de altele.

### Noțiunea de containerizare

__Containerizarea__ este o tehnologie prin care aplicațiile sunt rulate în containere separate, folosind nucleul comun al gazdei. Containerele asigură izolarea proceselor și resurselor, dar nu emulează hardware-ul.

Containerele permit crearea de aplicații care funcționează pe orice sistem cu suport pentru containere și nucleu compatibil (de exemplu, containerele Linux — doar pe Linux). Acest lucru asigură portabilitate, standardizare și accelerează procesele de dezvoltare, testare și implementare.

Totuși, containerele nu oferă același nivel de izolare și securitate ca mașinile virtuale, deoarece folosesc nucleul comun al gazdei. Capacitățile lor sunt limitate de nucleul sistemului de operare.

![Virtualizare versus Containerizare](images/01001_virtual_ws_container.png)

Containerizarea, spre deosebire de virtualizare, consumă semnificativ mai puține resurse, deoarece:

- folosește nucleul comun al OS, în timp ce virtualizarea necesită un nucleu separat pentru fiecare mașină virtuală;
- nu emulează hardware-ul, ci folosește mecanismele nucleului OS pentru izolare și gestionarea resurselor;
- nu creează un sistem de operare invitat, care ar consuma resurse suplimentare.

### Domenii de aplicare

Astăzi, containerele sunt folosite în principal pentru dezvoltarea, testarea și implementarea aplicațiilor. Ele permit crearea de medii portabile și standardizate, ceea ce este deosebit de important pentru procesele DevOps, arhitectura de tip microservicii și platformele cloud.

Domenii de aplicare a containerelor:

- _Dezvoltare_ — crearea de aplicații pentru diverse sisteme de operare;
- _Testare_ — depanare rapidă și sigură a programelor;
- _Build_ — compilarea în containere evită problemele cu dependențele;
- _Implementare_ — automatizarea și scalarea aplicațiilor în producție.

### Avantaje și dezavantaje

| Avantaje                  | Dezavantaje                                            |
| ------------------------- | ----------------------------------------------------- |
| Simplitate în creare      | Capacități limitate (dependență de nucleul OS)        |
| Mediu flexibil            | Complexitate crescută în gestionarea clusterelor      |
| Consum redus de resurse   | Necesitatea unor cunoștințe speciale                  |
| Portabilitate             | Izolare și securitate mai scăzute față de VM          |
| Standardizare             | Suport limitat pentru diverse OS pe aceeași gazdă     |
| Izolarea proceselor       |                                                       |
| Scalare rapidă            |                                                       |

__Explicații pentru avantaje:__

- _Simplitate în creare_ — containerele sunt ușor de creat, rulat și șters;
- _Mediu flexibil_ — operațiile cu containere sunt mult mai rapide decât cu mașinile virtuale;
- _Consum redus de resurse_ — containerele folosesc nucleul comun al OS, permițând rularea unui număr mare de instanțe;
- _Portabilitate_ — containerul conține toate dependențele necesare și poate fi rulat pe orice sistem cu suport pentru containere și nucleu compatibil;
- _Standardizare_ — bazat pe standarde deschise;
- _Izolarea proceselor_ — fiecare container izolează procesele sale de celelalte și de gazdă;
- _Scalare rapidă_ — containerele pot fi pornite și oprite rapid.

__Explicații pentru dezavantaje:__

- _Capacități limitate_ — containerele nu pot interacționa direct cu hardware-ul, fiind limitate de nucleul OS gazdă;
- _Complexitate crescută în gestionarea clusterelor de containere_ — necesită instrumente și cunoștințe speciale;
- _Izolare și securitate mai scăzute față de mașinile virtuale_ — containerele folosesc nucleul comun, ceea ce poate fi o vulnerabilitate dacă nu sunt configurate corect;
- _Suport limitat pentru diverse OS pe aceeași gazdă_ — pe o gazdă pot rula doar containere compatibile cu nucleul acelei OS.

Aceste dezavantaje sunt depășite treptat odată cu dezvoltarea tehnologiilor de containerizare și apariția unor noi instrumente de management.

## Istoria dezvoltării virtualizării și containerizării

La începuturile informaticii, calculatoarele erau foarte scumpe și accesibile doar organizațiilor mari. Resursele de calcul trebuiau economisite prin orice mijloace. Primii programatori scriau cod pe cartele perforate și le predau operatorului, care le introducea pe rând în mașină. Utilizarea resurselor era ineficientă.

Primele încercări de virtualizare au fost făcute în anii 1960. Inginerii IBM au propus rularea mai multor mașini virtuale cu propriile sisteme de operare pe un singur calculator. În 1966 a fost creată prima mașină virtuală IBM VM/370. Virtualizarea a permis crearea de programe independente de hardware și a facilitat portabilitatea codului.

Un moment de cotitură pentru containerizare a fost anul 1979, când la AT&T și Bell Laboratories, în versiunea a 7-a de Unix, a apărut apelul de sistem __chroot__, care schimba directorul rădăcină al procesului. Acesta a pus bazele izolării la nivel de fișiere. În 1999, în FreeBSD a apărut tehnologia __Jail__, care permitea rularea mai multor copii izolate ale OS cu același nucleu. În 2005, Sun Microsystems a prezentat __Solaris Containers__, iar în 2007 Google a dezvoltat tehnologia __cgroups__ pentru limitarea resurselor proceselor. În 2008, cgroups a fost inclus în nucleul Linux.

În 2013, compania Docker a prezentat sistemul de containerizare __Docker__, care a simplificat crearea, rularea și gestionarea containerelor. Docker a devenit baza ecosistemului modern de containere, iar Kubernetes — cel mai popular instrument de orchestrare a containerelor.

> _În cadrul acestui curs vor fi studiate containerele Docker._

În 2014, Google a prezentat sistemul de management al containerelor __Kubernetes__, care a devenit rapid standardul pentru automatizarea implementării, scalării și gestionării aplicațiilor containerizate.

Containerizarea și orchestrarea containerelor au devenit baza infrastructurii software moderne, iar Kubernetes este folosit în majoritatea proiectelor mari din mediul enterprise.

## Bibliografie

- [CyberPaul, În izolare. Istoria apariției și dezvoltării containerelor, Serverspace, Habr.com](https://habr.com/ru/companies/serverspace/articles/741874/)
- [Docker, Istoria Docker](https://docs.docker.com/engine/docker-overview/#docker-engine)
- [Wikipedia, FreeBSD Jail](https://en.wikipedia.org/wiki/FreeBSD_jail)
- [Wikipedia, Solaris Containers](https://en.wikipedia.org/wiki/Solaris_Containers)
- [Wikipedia, Docker](https://en.wikipedia.org/wiki/Docker_(software))
- [chroot, Wikipedia](https://en.wikipedia.org/wiki/Chroot)
- [cgroups, Wikipedia](https://en.wikipedia.org/wiki/Cgroups)
- [Kubernetes, Wikipedia](https://en.wikipedia.org/wiki/Kubernetes)

## Lista de termeni

- __virtualizare__ — tehnologie care permite rularea unei instanțe a unui sistem de operare în cadrul altui sistem de operare.
- __containerizare__ — tehnologie de izolare a aplicațiilor la nivelul sistemului de operare, folosind nucleul comun al gazdei și mecanismele nucleului OS.
- __izolarea proceselor__ — posibilitatea de a rula mai multe procese în cadrul unui singur sistem de operare, dar cu resurse izolate unele de altele.
- __chroot__ — apel de sistem Unix care schimbă locația directorului rădăcină al procesului și al proceselor copil ale acestuia.
- __hipervizor__ — program de virtualizare care realizează emularea resurselor hardware.
- __mașină virtuală__ — instanță a unui sistem de operare, rulată în cadrul altui sistem de operare cu ajutorul unui hipervizor.
- __container__ — mediu izolat care include aplicația și toate dependențele sale, rulat folosind nucleul comun al sistemului de operare, de obicei creat pe baza unei imagini (image).
