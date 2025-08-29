# Virtualizare

- [Virtualizare](#virtualizare)
  - [Tipuri de virtualizare](#tipuri-de-virtualizare)
  - [Hipervizoare](#hipervizoare)
  - [Virtualizare cu QEMU](#virtualizare-cu-qemu)
    - [Instalarea QEMU](#instalarea-qemu)
    - [Crearea unei mașini virtuale](#crearea-unei-mașini-virtuale)
    - [Instalarea sistemului de operare invitat](#instalarea-sistemului-de-operare-invitat)
    - [Pornirea mașinii virtuale](#pornirea-mașinii-virtuale)
  - [Open Virtualization Format](#open-virtualization-format)
  - [Bibliografie](#bibliografie)
  - [Termeni](#termeni)

<div class="epigraph">

_- Exact ca niște albine adevărate, s-a gândit Alice._ --- Lewis Carroll, „Alice în Țara Minunilor”

</div>

__Virtualizarea__ reprezintă furnizarea unui set de resurse de calcul sau a unei agregări logice a acestora, abstractizate de implementarea hardware, asigurând totodată izolarea logică între procesele de calcul care rulează pe aceeași resursă fizică.

Un exemplu de utilizare a virtualizării este posibilitatea de a rula mai multe sisteme de operare pe același calculator, fiecare instanță funcționând într-un mediu izolat, folosind propriile resurse logice.

Programul care realizează virtualizarea se numește __hipervizor__. Calculatorul pe care se lansează mașina virtuală se numește __gazdă__ (en. host), iar mașina virtuală, în raport cu gazda, este __invitat__ (en. guest).

## Tipuri de virtualizare

În funcție de nivelul de abstractizare la care are loc virtualizarea, se disting următoarele tipuri de virtualizare:

- __Virtualizare hardware__ – presupune instalarea hipervizorului direct pe hardware, fără utilizarea unui sistem de operare gazdă. Virtualizarea hardware oferă performanță comparabilă cu cea a unei mașini fizice, ceea ce permite utilizarea practică pe scară largă.
- __Virtualizare software__ – virtualizare la nivelul sistemului de operare. În acest caz, se virtualizează doar spațiul utilizatorului, iar nucleul OS rulează direct pe hardware.
- __Paravirtualizare__ – virtualizare care presupune modificarea sistemului de operare invitat pentru a lucra cu hipervizorul. În acest caz, sistemul de operare invitat este conștient că rulează pe o mașină virtuală și poate interacționa direct cu hipervizorul.

## Hipervizoare

Virtualizarea se realizează cu ajutorul unor instrumente software numite __hipervizoare__. Hipervizoarele se împart în mai multe tipuri, în funcție de modul în care rulează și gestionează accesul la hardware:

__Hipervizoarele de tip 1__, cunoscute și ca hipervizoare bare-metal, sunt programe instalate direct pe hardware-ul calculatorului, nu pe sistemul de operare. Din acest motiv, hipervizoarele de tip 1 oferă performanțe superioare și sunt utilizate în mediile enterprise.

Exemple de hipervizoare de tip 1: _VMware ESXi_, _Citrix XenServer_, _KVM_.

__Hipervizoarele de tip 2__, cunoscute și ca hipervizoare hosted, se instalează peste sistemul de operare. Acestea sunt potrivite pentru utilizatorii finali și sunt folosite în principal pentru testare și dezvoltare.

Exemple de hipervizoare de tip 2: _VMware Workstation_, _Oracle VirtualBox_, _QEMU_.

__Hipervizoare hibride__ – termenul este rar folosit, dar uneori descrie soluții care combină caracteristici ale hipervizoarelor de tip 1 și 2. De exemplu, _Xen_ poate funcționa atât ca tip 1, cât și ca tip 2. _Microsoft Hyper-V_ este adesea considerat tip 1, dar pe sistemele client Windows poate rula peste OS.

Astăzi există numeroase instrumente de virtualizare care permit crearea și gestionarea mașinilor virtuale. Cele mai populare instrumente sunt:

- __VMware ESXi__ – unul dintre cele mai populare instrumente de virtualizare folosit în mediile enterprise. Oferit de VMware, este hipervizor de tip 1.
- __VirtualBox__ – instrument gratuit de la Oracle. VirtualBox este hipervizor de tip 2.
- __QEMU__ – emulator și virtualizator care permite rularea mașinilor virtuale pe calculatorul fizic. QEMU poate funcționa în mod de emulare completă (performanță scăzută) sau poate folosi virtualizarea hardware prin KVM (performanță ridicată).
- __KVM__ – modul al nucleului Linux care îl transformă într-un hipervizor de tip 1. În combinație cu QEMU asigură virtualizare hardware.
- __Hyper-V__ – hipervizor de tip 1 de la Microsoft, permite rularea mașinilor virtuale pe Windows.

## Virtualizare cu QEMU

__QEMU__ este un emulator și virtualizator care permite rularea mașinilor virtuale pe calculatorul fizic. QEMU suportă diverse arhitecturi de procesoare, inclusiv x86, x86-64, ARM, MIPS și multe altele.

QEMU poate fi folosit în mai multe moduri:

- Principalul mod – emulare completă a hardware-ului (procesor, memorie, alte dispozitive) pentru rularea sistemului de operare invitat. Procesorul poate fi emulat complet sau se poate folosi virtualizarea hardware prin KVM, Xen sau Hypervisor.Framework, ceea ce permite rularea OS-ului invitat direct pe procesorul gazdei.
- QEMU poate rula și procese individuale compilate pentru o arhitectură pe altă arhitectură. De exemplu, QEMU poate rula programe compilate pentru ARM pe un calculator cu procesor x86-64.

Hipervizorul QEMU este un set de utilitare de linie de comandă care permit gestionarea mașinilor virtuale: creare, configurare, ștergere. Pentru gestionare vizuală se poate folosi interfața grafică __virt-manager__. Virt-manager permite gestionarea vizuală a mașinilor virtuale, crearea, configurarea, ștergerea și administrarea resurselor acestora.

### Instalarea QEMU

Instalarea QEMU pe Windows este o procedură standard: descărcarea pachetului de pe site-ul oficial și instalarea.

Instalarea QEMU pe Linux se face din depozitul distribuției. De exemplu, pentru distribuțiile bazate pe Debian (Ubuntu, Mint), instalarea QEMU se face cu comanda:

```bash
sudo apt install qemu
```

După instalare, utilizatorul va avea la dispoziție următoarele utilitare:

- `qemu-system-x86_64` – utilitar pentru rularea mașinilor virtuale pe arhitectura x86-64. Pentru alte arhitecturi se folosesc utilitare similare: `qemu-system-arm`, `qemu-system-mips`, `qemu-system-ppc` etc.
- `qemu-img` – utilitar pentru creare și gestionare imagini de disc.
- alte utilitare pentru trasare, depanare etc.

### Crearea unei mașini virtuale

Pentru instalarea sistemului de operare invitat, trebuie mai întâi să creați o imagine de disc pe care va fi instalat OS-ul. Imaginea de disc se creează cu utilitarul `qemu-img`:

```bash
qemu-img create -f qcow2 disk.qcow2 10G
```

Această comandă creează imaginea de disc `disk.qcow2` cu dimensiunea de 10 GB în formatul `qcow2`. Pentru informații suplimentare despre formatele imaginilor de disc și modurile de utilizare ale `qemu-img`, folosiți comanda:

```bash
qemu-img --help
```

### Instalarea sistemului de operare invitat

După crearea imaginii de disc, puteți instala sistemul de operare invitat. Pentru aceasta, lansați utilitarul `qemu-system-x86_64` cu calea către imaginea de disc și imaginea ISO a sistemului de operare. De exemplu, pentru instalarea Ubuntu:

```bash
# 2 GB RAM, 2 CPU cores
qemu-system-x86_64 -hda disk.qcow2 -cdrom ubuntu.iso -boot d -m 2G -smp 2
```

În acest caz, mașina virtuală pornește cu imaginea de disc `disk.qcow2` și imaginea ISO `ubuntu.iso`. Opțiunea `-boot d` indică pornirea de pe discul de instalare. La pornirea mașinii virtuale cu discul de instalare, trebuie să specificați memoria RAM (`-m`), numărul de nuclee CPU (`-smp`) și alte dispozitive sau parametri (de exemplu, adaptoare de rețea, plăci de sunet etc.).

### Pornirea mașinii virtuale

După instalarea sistemului de operare, puteți porni mașina virtuală fără discul de instalare:

```bash
# 2 GB RAM, 2 CPU cores, network backend
# port forwarding: host 2222 -> guest 22, host 8080 -> guest 80
qemu-system-x86_64 -hda disk.qcow2 -m 2G -smp 2 -device e1000,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80
```

În acest caz, mașina virtuală pornește cu imaginea de disc `disk.qcow2`, memoria RAM și numărul de nuclee specificate, precum și cu adaptor de rețea conectat la rețeaua virtuală.

## Open Virtualization Format

__Open Virtualization Format (OVF)__ este un format deschis pentru împachetarea și distribuirea mașinilor virtuale. Formatul OVF este un standard care conține toate informațiile necesare pentru implementarea unei mașini virtuale și nu depinde de implementarea hipervizorului sau de arhitectura hardware.

_Pachetul OVF_ este alcătuit din următoarele fișiere:

- descrierea mașinii virtuale în format XML – exact un fișier cu extensia `*.ovf`. Acest fișier se numește __descriptor OVF__. Conține informații despre configurația mașinii virtuale: număr de procesoare, memorie RAM, adaptoare de rețea și alte parametri.
- manifest – fișier opțional cu extensia `*.mf`.
- certificat – fișier opțional cu extensia `*.cert`.
- disc virtual – unul sau mai multe fișiere cu extensiile `*.vmdk`, `*.vdi`, `*.qcow2` etc. Aceste fișiere conțin informații despre discurile mașinii virtuale: dimensiune, format și alte parametri.
- fișiere suplimentare – fișiere opționale care pot conține date suplimentare, de exemplu imagini ISO, scripturi etc.

Mașina virtuală poate fi distribuită ca pachet OVF sau ca un singur fișier arhivă cu extensia `*.ova`, care este un arhiv TAR al pachetului OVF.

## Bibliografie

1. [Ce este virtualizarea?, AWS, aws.amazon.com](https://aws.amazon.com/ru/what-is/virtualization/)
2. [simust, Bazele virtualizării (prezentare), habr.com, 2022-03-28](https://habr.com/ru/articles/657677/)
3. [Sistemul de virtualizare QEMU, calculate-linux.org, 2020-01-24](https://wiki.calculate-linux.org/ru/qemu)
4. [Welcome to QEMU’s documentation!, qemu.org](https://www.qemu.org/docs/master/)
5. [virtual machine manager, virt-manager.org](https://virt-manager.org/)
6. [Open Virtualization Format, Wikipedia](https://en.wikipedia.org/wiki/Open_Virtualization_Format)

## Termeni

- __Hipervizor__ – software (bare-metal sau hosted) care permite rularea și gestionarea mai multor mașini virtuale pe același server fizic.
- __Mașină virtuală__ – mediu software izolat care emulează hardware-ul unui calculator și permite rularea propriului sistem de operare și aplicații.
- __Invitat (guest)__ – mașina virtuală care rulează pe hipervizor.
- __Gazdă (host)__ – serverul fizic pe care rulează hipervizorul.
- __Virtualizare hardware__ – virtualizare în care hipervizorul rulează direct pe hardware (tip 1).
- __Virtualizare software__ – virtualizare în care hipervizorul rulează peste sistemul de operare (tip 2).
- __Paravirtualizare__ – virtualizare în care sistemul de operare invitat este modificat pentru a lucra cu hipervizorul.
- __Emulare__ – imitarea comportamentului unui dispozitiv hardware sau a unui program.
- __OVF__ (Open Virtualization Format) – format deschis pentru împachetarea și distribuirea mașinilor virtuale; OVA – variantă arhivată a OVF.
