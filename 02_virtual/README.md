# Virtualizarea

- [Virtualizarea](#virtualizarea)
  - [Tipuri de virtualizare](#tipuri-de-virtualizare)
  - [Hipervizorii](#hipervizorii)
  - [Virtualizarea pe baza QEMU](#virtualizarea-pe-baza-qemu)
    - [Instalarea QEMU](#instalarea-qemu)
    - [Crearea mașinii virtuale](#crearea-mașinii-virtuale)
    - [Instalarea sistemului de operare oaspete](#instalarea-sistemului-de-operare-oaspete)
    - [Pornirea mașinii virtuale](#pornirea-mașinii-virtuale)
  - [Open Virtualization Format](#open-virtualization-format)
  - [Bibliografie](#bibliografie)
  - [Terminologie](#terminologie)

__Virtualizarea__ este oferirea unui set de resurse de calcul sau a unei combinații logice a acestora, abstractizate de la implementarea hardware și asigurând izolarea logică a proceselor de calcul care rulează pe un singur resurs fizic.

Exemplu de utilizare a virualizării este posibilitatea de a rula mai multe sisteme de operare pe un singur calculator, fiecare dintre instanțele de sistem de operare rulând într-un mediu izolat, folosind propriile resurse logice.

Un program care efectuează virtualizarea este numit __hipervizor__. Calculatorul pe care rulează mașina virtuală este numit __gazdă__ (en. host), iar mașina virtuală în raport cu gazda este numită __oaspete__ (en. guest).

## Tipuri de virtualizare

În dependență de nivelul de abstractizare la care se efectuează virtualizarea, se disting următoarele tipuri de virtualizare:

- __Virtualizarea la nivel hardware__ presupune instalarea unui hipervizor direct pe hardware-ul gazdei, fără a folosi un sistem de operare gazdă. Acest tip de virtualizare oferă performanțe comparabile cu cele ale unui sistem fizic, ceea ce face posibilă utilizarea virtualizării în scopuri practice și duce la o largă răspândire a acesteia.
- __Virtualizarea la nivel software__ - virtualizarea la nivelul sistemului de operare. În acest caz, se virtualizează doar spațiul utilizator, iar kernel-ul sistemului de operare rulează direct pe hardware.
- __Paravirtualizarea__ - virtualizarea care presupune modificarea sistemului de operare oaspete pentru a lucra cu hipervizorul. În acest caz, sistemul de operare oaspete știe că rulează pe o mașină virtuală și poate comunica direct cu hipervizorul.

## Hipervizorii

Virtualizarea se realizează cu ajutorul unor instrumente software numite __hipervizori__. Hipervizorii sunt de diferite tipuri, în funcție de modul în care sunt implementați și de nivelul de abstractizare la care lucrează.

__Hipervizorii de tip unu__ sunt cunoscute și sub numele de _hipervizori fără sistem de operare_ și sunt programe hipervizor care sunt instalate direct pe hardware-ul computerului, nu pe un sistem de operare. Prin urmare, hipervizorii de tip unu au performanțe mai bune și sunt de obicei folosiți în aplicații corporative. KVM folosește un hipervizor de tip unu pentru a găzdui mai multe mașini virtuale în sistemul de operare Linux.

Exemple de hipervizori de tip unu includ _VMware ESXi_ și _Citrix XenServer_.

__Hipervizorii de tip doi__ sunt cunoscuți și sub numele de _hipervizori plasați_ și sunt programe hipervizor care se instalează pe un sistem de operare. Hipervizorii de tip doi sunt mai ușor de instalat și de utilizat, dar au performanțe mai slabe decât hipervizorii de tip unu. Hipervizorii de tip doi sunt de obicei folosiți pentru testare și dezvoltare.

Exemple de hipervizori de tip doi includ _VMware Workstation_, _Oracle VirtualBox_ și _QEMU_.

__Hipervizorii hibridi__ sunt o combinație între hipervizorii de tip unu și cei de tip doi, ele sunt compuse dintr-un nucleu minim care controlează accesul la procesor și memorie și un sistem de operare specializat care oferă acces la hardware-ul fizic. Exemple de hipervizori hibridi includ _Microsoft Hyper-V_ și _Xen_.

Pe ziua de azi există o mulțime de instrumente de virtualizare care permit crearea și gestionarea mașinilor virtuale. Cele mai populare instrumente de virtualizare sunt:

- __VMware ESXi__ - unul dintre cele mai populare instrumente de virtualizare utilizate în medii corporative. Este oferit de compania VMware, este un hipervizor de tip unu.
- __VirtualBox__ - un instrument de virtualizare gratuit, de la Oracle. VirtualBox este un hipervizor de tip doi.
- __QEMU__ - un emulator software care permite rularea mașinilor virtuale pe un computer fizic, folosind diferiți hipervizori (de exemplu, KVM).
- __KVM__ - un hipervizor care permite rularea mașinilor virtuale pe baza kernelului Linux.
- __LXC__ - un instrument de virtualizare la nivel de sistem de operare care permite crearea și gestionarea containerelor.
- __Hyper-V__ - un hipervizor care permite rularea mașinilor virtuale pe baza Windows.
- __Docker__ - un instrument de virtualizare la nivel de sistem de operare care permite crearea și gestionarea containerelor.

## Virtualizarea pe baza QEMU

__QEMU__ este un emulator software care permite rularea mașinilor virtuale pe un computer fizic. QEMU suportă o varietate de arhitecturi de procesoare, inclusiv x86, x86-64, ARM, MIPS și multe altele.

QEMU poate fi utilizat în moduri diferite:

- metoda de utilizare de bază a QEMU este emularea completă a hardware-ului (procesor, memorie, alte dispozitive) pentru a rula un sistem de operare oaspete. În acest caz, procesorul poate fi emulat complet sau poate folosi emularea unor instrucțiuni (de exemplu, atunci când se utilizează tehnologiile _KVM_, _XEN_ sau _Hypervisor.Framework_), ceea ce permite rularea sistemului de operare oaspete direct pe procesorul gazdei.
- QEMU poate porni separat procese care sunt compilate pentru o arhitectură pe o altă arhitectură. De exemplu, QEMU poate rula programe compilate pentru arhitectura ARM pe un computer cu procesor x86-64.

Hipervizor QEMU prezintă un set de utilitare de consolă care permit gestionarea mașinilor virtuale, crearea, configurarea și ștergerea acestora. Pentru a facilita gestionarea mașinilor virtuale, se poate folosi interfața grafică, de exemplu, __virt-manager__. Virt-manager permite gestionarea vizuală a mașinilor virtuale, crearea, configurarea și ștergerea acestora, precum și gestionarea resurselor mașinilor virtuale.

### Instalarea QEMU

Instalarea QEMU sub SO Windows este un proces standard care constă în descărcarea pachetului de instalare de pe site-ul oficial și instalarea ulterioară.

Instalarea QEMU  sub SO Linux este, de asemenea, un proces standard care constă în instalarea pachetului din depozitul distribuției. De exemplu, pentru distribuțiile bazate pe Debian (Ubuntu, Mint), instalarea QEMU se face cu următoarea comandă:

```bash
sudo apt install qemu
```

Ca rezultat, după instalare, utilizatorului vor fi disponibile următoarele utilitare:

- `qemu-system-x86_64` - aplicația pentru pornirea mașinilor virtuale pe arhitectura x86-64. Pentru alte arhitecturi se folosesc aplicații pentru pornirea mașinilor virtuale cu nume asemănătoare: `qemu-system-arm`, `qemu-system-mips`, `qemu-system-ppc` și altele.
- `qemu-img` - aplicația pentru crearea și gestionarea imaginilor de disc.
- o serie de alte utilitare, de exemplu, pentru urmărirea, depanarea și altele.

### Crearea mașinii virtuale

Pentru a pregăti o mașină virtuală inițial trebuie să fie creată imaginea discului pe care va fi instalat sistemul de operare. Pentru aceasta se folosește utilitarul `qemu-img`:

```bash
qemu-img create -f qcow2 disk.qcow2 10G
```

Această comandă creează o imagine de disc `disk.qcow2` cu o dimensiune de 10 GB în format `qcow2`. Pentru informații suplimentare despre formatele imaginilor de disc, precum și despre modurile de utilizare a `qemu-img` se poate folosi comanda:

```bash
qemu-img --help
```

### Instalarea sistemului de operare oaspete

După crearea imaginii discului se poate instala sistemul de operare oaspete. Pentru aceasta se pornește aplicația `qemu-system-x86_64` cu spacificația căii către imaginea discului și imaginea discului cu sistemul de operare oaspete. De exemplu, pentru instalarea sistemului de operare Ubuntu:

```bash
# 2 GB RAM, 2 CPU cores
qemu-system-x86_64 -hda disk.qcow2 -cdrom ubuntu.iso -boot d -m 2G -smp 2
```

În acest caz mașina virtuală se pornește cu imaginea discului `disk.qcow2` și imaginea discului de instalare a sistemului de operare `ubuntu.iso`. Opțiunea `-boot d` indică pornirea de pe discul de instalare. Se observă că la pornirea mașinii virtuale de pe discul de instalare este necesar să se specifice cantitatea de memorie (`-m`), de asemenea se poate specifica numărul de nuclee ale procesorului (`-smp`), alte dispozitive și parametrii acestora (de exemplu, adaptoare de rețea, plăci audio etc.).

### Pornirea mașinii virtuale

După instalarea sistemului de operare mașina virtuală poate fi pornită fără discul de instalare.

```bash
# 2 GB RAM, 2 CPU cores, network backend
# port forwarding: host 2222 -> guest 22, host 8080 -> guest 80
qemu-system-x86_64 -hda disk.qcow2 -m 2G -smp 2 -device e1000,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80
```

În acest caz mașina virtuală se pornește cu imaginea discului `disk.qcow2`, cu cantitatea de memorie specificată (`-m`), cu numărul de nuclee ale procesorului (`-smp`), cu un adaptor de rețea (`-device e1000,netdev=net0 -netdev user,id=net0`) și cu specificarea porturilor de redirecționare (`hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80`).

## Open Virtualization Format

__Open Virtualization Format (OVF)__ - este un format deschis pentru împachetarea și distribuirea mașinilor virtuale. OVF este un format standard care permite împachetarea mașinilor virtuale într-un singur fișier care conține toate informațiile necesare pentru implementarea lor. Standardul OVF nu este legat de nicio implementare a hipervizorului sau de arhitectura hardware.

Pachet OVF este compus din mai multe fișiere, de obicei, aflate într-un singur director. Pachetul conține întotdeauna exact un fișier de descriere cu extensia `.ovf`. Acesta este un fișier XML care descrie mașina virtuală împachetată și conține metadatele pachetului, cum ar fi numele, cerințele hardware, referințele la alte fișiere din pachet și descrierile. În plus față de fișierul de descriere, pachetul OVF de obicei conține una sau mai multe imagini de disc și poate include fișiere de certificat și alte fișiere.

Format OVF a fost dezvoltat pentru a simplifica gestionarea mașinilor virtuale și pentru a facilita implementarea lor pe diferite platforme de virtualizare (transfer între hipervizori).

## Bibliografie

1. [Что такое виртуализация?, AWS, aws.amazon.com](https://aws.amazon.com/ru/what-is/virtualization/)
2. [simust, Основы виртуализации (обзор), habr.com, 2022-03-28](https://habr.com/ru/articles/657677/)
3. [Система виртуализации QEMU, calculate-linux.org, 2020-01-24](https://wiki.calculate-linux.org/ru/qemu)
4. [Welcome to QEMU’s documentation!, qemu.org](https://www.qemu.org/docs/master/)
5. [virtual machine manager, virt-manager.org](https://virt-manager.org/)
6. [Open Virtualization Format, Wikipedia](https://en.wikipedia.org/wiki/Open_Virtualization_Format)

## Terminologie

- __Hipervizor__ este un program care permite rularea mai multor mașini virtuale pe un singur computer fizic.
- __Mașină virtuală__  este o emulare software a unui calculator fizic, care rulează pe un computer fizic. Mașina virtuală are propria sa copie a sistemului de operare și a aplicațiilor și este gestionată de hipervizor.
- __Oaspete__ - mașina virtuală care rulează pe un hipervizor.
- __Gazdă__ - computerul fizic pe care rulează hipervizorul.
- __Virtualizare la nivel hardware__ - virtualizare care presupune instalarea unui hipervizor direct pe hardware-ul computerului, fără a folosi un sistem de operare.
- __Virtualizare la nivel software__ - virtualizare care presupune instalarea unui hipervizor pe un sistem de operare.
- __Paravirtualizare__ - virtualizare care presupune modificarea sistemului de operare oaspete pentru a lucra cu hipervizorul.
- __Emulator__ - program care permite rularea unui program sau a unui sistem de operare pe un computer cu o arhitectură hardware diferită.
- __OVF__ - format pentru împachetarea și distribuirea mașinilor virtuale.
