# Virtualizarea

Virtualizarea joacă un rol important în tehnologia informației moderne și ocupă un loc central în domeniul calculului în cloud. Virtualizarea permite rularea mai multor mașini virtuale pe un singur server fizic, ceea ce crește eficiența utilizării hardware-ului și simplifică administrarea serverelor.

De asemenea, virtualizarea permite crearea unor medii izolate pentru dezvoltarea și testarea software-ului, ceea ce facilitează dezvoltarea și îmbunătățește calitatea software-ului.

## Tipuri de virtualizare

Un program care efectuează virtualizarea se numește __hipervizor__. Calculatorul pe care rulează mașina virtuală se numește __gazdă__ (en. host), iar mașina virtuală în raport cu _gazda_ este numită __oaspete__ (en. guest).

În funcție de nivelul de abstractizare la care se realizează virtualizarea, se disting următoarele tipuri de virtualizare:

- __Virtualizare hardware__ - presupune instalarea unui hipervizor fără utilizarea unui sistem de operare gazdă. Virtualizarea hardware oferă performanțe comparabile cu cele ale unui calculator fizic, ceea ce face virtualizarea utilizabilă și duce la o largă răspândire a acesteia.
- __Virtualizare software__ - virtualizarea la nivel de sistem de operare. În acest caz, se virtualizează doar spațiul utilizatorului, iar nucleul sistemului de operare rulează direct pe hardware. Exemple: Docker, LXC.
- __Emulare__ - dispozitiv hardware sau program (__emulator__) care simulează funcționarea altui dispozitiv hardware sau program. De exemplu, unele imprimante emulează funcționarea imprimantelor HP LaserJet, deoarece există o mulțime de programe (și drivere) scrise pentru această familie de imprimante. Un alt exemplu este emularea consolelor de jocuri.

Virtualizarea permite rularea diferitelor sisteme de operare care rulează pe diferite arhitecturi și configurații hardware pe același computer.

## Virtualizare pe baza QEMU

__QEMU__ este un emulator software care permite rularea mașinilor virtuale pe un computer fizic. QEMU suportă diferite arhitecturi de procesoare, inclusiv x86, x86-64, ARM, MIPS și multe altele.

QEMU poate fi utilizat în diferite moduri:

- emularea completă a hardware-ului (procesor, memorie, alte dispozitive) pentru a rula un sistem de operare oaspete. În acest caz, procesorul poate fi emulat complet sau poate folosi emularea unor instrucțiuni (de exemplu, atunci când se utilizează tehnologia _KVM_, _XEN_ sau _Hypervisor.Framework_), ceea ce permite rularea sistemului de operare oaspete direct pe procesorul gazdă.
- QEMU poate rula procese separate, compilate pentru o arhitectură, pe o altă arhitectură. De exemplu, QEMU poate rula programe compilate pentru arhitectura ARM pe un computer cu procesor x86-64.

Hyperisorul QEMU este un set de utilitare de consolă care permit administrarea mașinilor virtuale, crearea, configurarea și ștergerea acestora. Pentru a facilita administrarea mașinilor virtuale, puteți utiliza interfața grafică, de exemplu, __virt-manager__. Virt-manager permite administrarea vizuală a mașinilor virtuale, crearea, configurarea și ștergerea acestora, precum și administrarea resurselor mașinilor virtuale.

## Instalarea QEMU

Instalarea QEMU pe Windows este un proces standard care constă în descărcarea pachetului de instalare de pe site-ul oficial și instalarea acestuia.

Instalarea QEMU pe Linux este, de asemenea, un proces standard care constă în instalarea pachetului din depozitul distribuției. De exemplu, pentru distribuțiile bazate pe Debian (Ubuntu, Mint), instalarea QEMU se face cu următoarea comandă:

```bash
sudo apt install qemu
```

În urma instalării, utilizatorului vor fi disponibile următoarele utilitare:

- `qemu-system-x86_64` - utilitar pentru rularea mașinilor virtuale pe arhitectura x86-64. Pentru alte arhitecturi sunt disponibile utilitare similare pentru rularea mașinilor virtuale: `qemu-system-arm`, `qemu-system-mips`, `qemu-system-ppc` și altele.
- `qemu-img` - utilitar pentru crearea și administrarea imaginilor de disc.
- alte utilitare pentru urmărirea, depanarea și altele.

### Crearea mașinii virtuale

Pentru a crea o mașină virtuală, trebuie să creați un disc virtual pe care va fi instalat sistemul de operare. Pentru a crea un disc virtual, utilizați utilitarul `qemu-img`:

```bash
qemu-img create -f qcow2 disk.qcow2 10G
```

Aceasta comandă creează un disc `disk.qcow2` de 10 GB în format `qcow2`. Pentru informații suplimentare despre formatele imaginilor de disc și modurile de utilizare a `qemu-img`, puteți utiliza comanda:

```bash
qemu-img --help
```

### Instalarea sistemului de operare oaspete

După crearea imaginii de disc, puteți instala sistemul de operare oaspete. Pentru a face acest lucru, trebuie să rulați utilitarul `qemu-system-x86_64` cu calea către imaginea de disc și imaginea discului de instalare a sistemului de operare. De exemplu, pentru a instala sistemul de operare Ubuntu:

```bash
# 2 GB RAM, 2 CPU cores
qemu-system-x86_64 -hda disk.qcow2 -cdrom ubuntu.iso -boot d -m 2G -smp 2
```

În acest caz mașina virtuală va fi pornită cu imaginea de disc `disk.qcow2` și imaginea discului de instalare a sistemului de operare `ubuntu.iso`. Opțiunea `-boot d` indică pornirea de pe discul de instalare. Rețineți că la pornirea mașinii virtuale de pe discul de instalare trebuie să specificați cantitatea de memorie RAM (`-m`), de asemenea puteți specifica numărul de nuclee ale procesorului (`-smp`), alte dispozitive și parametrii acestora (de exemplu, adaptoare de rețea, plăci audio etc.).

### Pornirea mașinii virtuale

După instalarea sistemului de operare oaspete, puteți porni mașina virtuală creată anterior, fără discul de instalare. Pentru a face acest lucru, utilizați comanda:

```bash
# 2 GB RAM, 2 CPU cores, network backend
# port forwarding: host 2222 -> guest 22, host 8080 -> guest 80
qemu-system-x86_64 -hda disk.qcow2 -m 2G -smp 2 -device e1000,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80
```

În acest caz mașina virtuală se va porni cu imaginea de disc `disk.qcow2`, cantitatea de memorie RAM și numărul de nuclee ale procesorului specificate. De asemenea, mașina virtuală va avea un adaptor de rețea conectat la rețeaua virtuală.

## Bibliografie

1. [simust, Основы виртуализации (обзор), habr.com, 2022-03-28](https://habr.com/ru/articles/657677/)
2. [Система виртуализации QEMU, calculate-linux.org, 2020-01-24](https://wiki.calculate-linux.org/ru/qemu)
3. [Welcome to QEMU’s documentation!, qemu.org](https://www.qemu.org/docs/master/)
4. [virtual machine manager, virt-manager.org](https://virt-manager.org/)

## Terminologie

- __Hypervisor__ - o aplicație care permite rularea mai multor mașini virtuale pe un singur server fizic.
- __Mașină virtuală__ - o emulare a unui calculator care rulează pe un computer fizic. Mașina virtuală are propriul sistem de operare și aplicații și este gestionată de un emulator (hypervizor).
- __Oaspete (Guest)__ - o mașină virtuală care rulează pe un hypervisor.
- __Gazdă (Host)__ - un server fizic pe care rulează un hypervisor.
