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
  - [Termeni de bază](#termeni-de-bază)
    - [API](#api)
    - [CI/CD](#cicd)
    - [DevOps](#devops)
    - [YAML](#yaml)
    - [Virtualizare](#virtualizare-1)
    - [Imutabilitate](#imutabilitate)
    - [Cluster](#cluster)
    - [Container](#container)
    - [Scalare](#scalare)
    - [Microserviciu](#microserviciu)
    - [Arhitectură multicomponentă](#arhitectură-multicomponentă)
    - [Arhitectură monolitică](#arhitectură-monolitică)
    - [Cloud](#cloud)
    - [Imagine](#imagine)
    - [Orchestrare](#orchestrare)
    - [Repository](#repository)
    - [Secret](#secret)
    - [Serviciu](#serviciu)
    - [Server](#server)
    - [Web service](#web-service)
    - [Rețea](#rețea)
    - [Volum](#volum)
  - [Istoria dezvoltării virtualizării și containerizării](#istoria-dezvoltării-virtualizării-și-containerizării)
  - [Bibliografie](#bibliografie)

<div class="epigraph">

_Stăteau sub copac, îmbrățișați pe după umeri, și Alice a înțeles imediat cine este Tweedledum și cine este Tweedledee, pentru că pe gulerul unuia era brodat „TWEEDLE”, iar pe al celuilalt – „DEE”._ --- Lewis Carroll, „Alice în Țara Oglinzilor”

</div>

## Virtualizare

Virtualizarea joacă un rol important în tehnologia informației moderne și ocupă un loc central în domeniul cloud computing. Ea permite rularea mai multor mașini virtuale pe un singur server fizic, ceea ce crește eficiența utilizării resurselor hardware și simplifică gestionarea infrastructurii.

De asemenea, virtualizarea este folosită pentru crearea de medii izolate de dezvoltare și testare a software-ului, ceea ce contribuie la creșterea calității și securității aplicațiilor.

### Noțiunea de virtualizare

__Virtualizarea__ este o tehnologie care permite rularea unei instanțe a unui sistem de operare în cadrul altui sistem de operare (numit __gazdă__). Pentru aceasta se folosește un __hipervizor__ — un program care emulează resursele hardware (procesor, memorie, spațiu pe disc, interfețe de rețea etc.) și creează mașini virtuale pe care se instalează sisteme de operare.

Fiecare mașină virtuală este complet izolată, are propriile procese, sistem de fișiere, interfețe de rețea, utilizatori și nucleu de sistem de operare. Mașinile virtuale pot rula sisteme de operare diferite față de gazdă.

### Motivele apariției virtualizării

Virtualizarea a apărut din necesitatea de a distribui eficient resursele de calcul între mai mulți utilizatori pe o singură mașină fizică. În timp, a devenit baza pentru cloud computing și infrastructurile IT moderne.

### Domenii de aplicare

Virtualizarea este folosită pentru consolidarea serverelor, creșterea rezilienței și scalabilității, optimizarea utilizării resurselor hardware, precum și pentru crearea de medii izolate de dezvoltare și testare.

### Avantaje și dezavantaje

| Avantaje                                             | Dezavantaje                          |
| ---------------------------------------------------- | ------------------------------------ |
| Posibilitatea de a rula mai multe OS pe un singur PC | Cerințe crescute de resurse          |
| Scalabilitate                                        | Necesitatea unor cunoștințe speciale |
| Izolare                                              | Probleme de licențiere               |
| Gestionare flexibilă a resurselor                    |                                      |

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

Domenii de aplicare ale containerelor:

- _Dezvoltare_ — crearea de aplicații pentru diverse sisteme de operare;
- _Testare_ — depanare rapidă și sigură a programelor;
- _Build_ — compilarea în containere evită problemele cu dependențele;
- _Implementare_ — automatizarea și scalarea aplicațiilor în producție.

### Avantaje și dezavantaje

| Avantaje                | Dezavantaje                                       |
| ----------------------- | ------------------------------------------------- |
| Simplitate în creare    | Capacități limitate (dependență de nucleul OS)    |
| Mediu flexibil          | Complexitate crescută în gestionarea clusterelor  |
| Consum redus de resurse | Necesitatea unor cunoștințe speciale              |
| Portabilitate           | Izolare și securitate mai scăzute față de VM      |
| Standardizare           | Suport limitat pentru diverse OS pe aceeași gazdă |
| Izolarea proceselor     |                                                   |
| Scalare rapidă          |                                                   |

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

## Termeni de bază

Pentru a înțelege o anumită arie, este necesar să ai un vocabular de termeni specific. În această secțiune sunt definite principalele concepte folosite în curs.

### API

__API__ (Application Programming Interface) — interfață de programare a aplicațiilor, care permite diferitelor programe să interacționeze între ele. API definește un set de funcții și proceduri care pot fi folosite de dezvoltatori pentru a crea aplicații.

### CI/CD

__CI/CD__ (Continuous Integration/Continuous Deployment) — practică de dezvoltare software care include integrarea continuă a modificărilor în cod și implementarea continuă a aplicațiilor. CI/CD permite automatizarea procesului de dezvoltare, testare și implementare a aplicațiilor, ceea ce accelerează lansarea de noi versiuni și crește calitatea software-ului.

### DevOps

__DevOps__ — metodologie de dezvoltare software care unește dezvoltatorii (Dev) și echipele de operațiuni (Ops) pentru a îmbunătăți colaborarea și automatizarea proceselor. DevOps are ca scop accelerarea lansării software-ului, creșterea calității și îmbunătățirea colaborării între echipe.

### YAML

__YAML__ (YAML Ain't Markup Language) — format de serializare a datelor, folosit pentru descrierea configurațiilor într-un mod ușor de citit de către oameni. YAML este utilizat pe scară largă în orchestratoarele de containere, precum Kubernetes, pentru descrierea manifestelor și configurațiilor.

### Virtualizare

__Virtualizare__ — tehnologie care permite rularea mai multor instanțe izolate de sisteme de operare (mașini virtuale) pe un singur server fizic, cu ajutorul unui software special — hipervizorul. Mașinile virtuale sunt complet izolate unele de altele și pot rula sisteme de operare diferite.

### Imutabilitate

__Imutabilitate__ — concept conform căruia datele sau obiectele nu pot fi modificate după crearea lor. În contextul containerizării și tehnologiilor cloud, imutabilitatea înseamnă că imaginile containerelor și infrastructura nu se modifică după ce au fost create, ceea ce asigură predictibilitate și repetabilitate la implementare.

### Cluster

__Cluster__ — grup de servere (noduri) unite pentru a îndeplini împreună anumite sarcini. În containerizare, un cluster este un grup de noduri pe care orchestratorul gestionează containerele.

### Container

__Container__ — mediu izolat, pornit pe baza unei imagini, care include aplicația și toate dependențele sale, folosind nucleul comun al sistemului de operare al gazdei.

### Scalare

__Scalare__ — procesul de creștere a performanței aplicației prin alocarea unui număr mai mare de resurse. În sistemele moderne, accentul se pune pe scalarea orizontală — creșterea numărului de servere sau containere.

### Microserviciu

__Microserviciu__ — serviciu mic, independent și izolat, care îndeplinește o funcție specifică într-o aplicație. Microserviciile comunică între ele prin API și pot fi implementate și scalate independent.

### Arhitectură multicomponentă

__Arhitectură multicomponentă__ — arhitectură în care aplicația este formată din mai multe componente, fiecare putând fi pornită într-un proces sau container separat.

Aplicațiile moderne sunt sisteme complexe, formate din multe componente. Fiecare componentă îndeplinește o funcție, iar interacțiunea dintre componente permite realizarea funcționalității necesare. Componentele pot fi scrise în diverse limbaje de programare, pot folosi baze de date diferite și protocoale variate de comunicare. Toate acestea fac dezvoltarea și mentenanța unor astfel de aplicații o sarcină complexă. Dacă aplicația este formată din mai multe componente, se spune că are o __arhitectură multicomponentă__ sau __modulară__.

Dezvoltarea aplicațiilor cu arhitectură multicomponentă este o provocare, dar are mai multe avantaje:

- __înțelegere__ — fiecare componentă are o funcție clară, ceea ce simplifică înțelegerea aplicației;
- __mentenanță__ — nu este nevoie să cunoști tot codul aplicației, ci doar componenta pe care o întreții;
- __scalare__ — scalarea aplicației cu arhitectură multicomponentă este orizontală, ceea ce permite creșterea performanței prin adăugarea de componente;
- __actualizare__ — se actualizează doar componentele care au fost modificate.

Un caz particular al arhitecturii multicomponentă este __arhitectura de tip microservicii__, unde modulele sunt reprezentate de web servicii (microservicii).

Pentru a simplifica dezvoltarea și mentenanța aplicațiilor se folosesc containere. Fiecare componentă a aplicației rulează într-un container separat, ceea ce permite dezvoltatorilor să se concentreze pe funcționalitatea componentei, nu pe integrarea cu alte componente. Pentru a porni aplicația, trebuie pornit fiecare container care conține componentele aplicației și configurată interacțiunea dintre ele.

### Arhitectură monolitică

__Arhitectură monolitică__ — arhitectură în care tot codul și toate componentele rulează într-un singur proces (sau container).

### Cloud

__Cloud__ — grup de calculatoare unite într-o rețea cu software specializat, care oferă resurse și servicii utilizatorilor la cerere, cu posibilitatea de scalare.

### Imagine

__Imagine__ — șablon imutabil care conține tot ce este necesar pentru rularea aplicației: aplicația propriu-zisă, dependențe, fișiere de configurare și date. Pe baza imaginii se creează containerele.

### Orchestrare

__Orchestrare__ — automatizarea gestionării ciclului de viață al containerelor: implementare, scalare, actualizare, recuperare și interacțiune între containere.

### Repository

__Repository__ este un depozit de fișiere, dar în contextul containerizării, aceste depozite conțin imagini. Repository-urile pot fi publice sau private. Cele publice sunt disponibile pentru descărcare tuturor, cele private — doar anumitor utilizatori.

Cel mai popular repository public este [Docker Hub](https://hub.docker.com/), unde sunt stocate imagini create de comunitate.

### Secret

__Secret__ — informație necesară pentru acces, cum ar fi parole sau chei (pot fi și logini sau orice date confidențiale) și care trebuie protejată. Secretele pot fi statice (parole) sau dinamice (token-uri de acces). În containerizare, secretele sunt folosite pentru stocarea datelor confidențiale, cum ar fi parole, chei API și alte date care nu trebuie să fie accesibile tuturor utilizatorilor sau containerelor. Secretele pot fi stocate în depozite speciale sau transmise containerelor la pornire.

### Serviciu

Orice program ajută utilizatorul să rezolve o anumită sarcină. Totuși, programele pot fi de uz general, adică să ofere servicii mai multor utilizatori simultan. Aceste servicii pot fi diverse, de exemplu, căutare de informații pe Internet, trimitere de mesaje, stocare de date etc.

__Serviciu__ este un program, de obicei pornit pe un server, care oferă servicii specializate clienților.

În contextul programării web, un site poate fi:

- sub forma unui singur serviciu (monolit, o singură cale de acces),
- sub forma mai multor servicii independente (fiecare pagină este complet independentă),
- sub forma mai multor servicii interconectate (arhitectură de tip microservicii).

### Server

Serverul, în funcție de context, are mai multe semnificații.

- __Server__ ca hardware, este un calculator specializat pe care rulează software de server. Aceste calculatoare au performanță, fiabilitate și disponibilitate ridicate, ceea ce permite funcționarea aplicațiilor pe termen lung.
- __Server__ ca software, este un program care oferă servicii clienților. Serverul poate fi pornit pe orice calculator, dar pentru disponibilitate și fiabilitate ridicate, serverele rulează pe hardware specializat. Serverele rulează în sistemul de operare în fundal, în Linux sunt numite demoni, în Windows — servicii.

Cerința principală pentru servere este __fiabilitatea__, deoarece trebuie să ofere servicii clienților continuu, fără întreruperi. Serverul poate avea și alte caracteristici, în funcție de sarcinile sale, de exemplu:

- __Performanță__ — capacitatea serverului de a procesa cererile clienților rapid.
- __Scalabilitate__ — capacitatea serverului de a crește performanța prin alocarea de resurse suplimentare.
- __Gestionabilitate__ — capacitatea serverului de a fi administrat de la distanță, fără prezența fizică a administratorului.

### Web service

__Web service__ este un serviciu care oferă funcționalități prin protocolul HTTP. Web service-urile pot fi accesate atât în rețele locale, cât și în Internet. Pe baza interacțiunii serviciilor se dezvoltă aplicații cu arhitectură de tip microservicii.

### Rețea

__Rețea__ — sistem care permite calculatoarelor să facă schimb de date și resurse. În containerizare, rețeaua asigură interacțiunea între containere, noduri și sisteme externe.

### Volum

__Volum__ — mecanism în containerizare care permite containerelor să păstreze date în afara ciclului lor de viață. Volumele pot fi folosite pentru stocarea datelor care trebuie păstrate între reporniri ale containerelor.

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
- [Care este diferența dintre imaginile Docker și containere?, AWS Amazon](https://aws.amazon.com/ru/compare/the-difference-between-docker-images-and-containers/)
- [Ce este containerizarea?, AWS Amazon](https://aws.amazon.com/ru/what-is/containerization/)
- [Microservicii .NET: Arhitectura aplicațiilor containerizate .NET, learn.microsoft.com, 2022](https://learn.microsoft.com/ru-ru/dotnet/architecture/microservices/)
- [simust, __Основы контейнеризации (обзор Docker и Podman)__, Habr.com, 2022](https://habr.com/ru/articles/659049/)
