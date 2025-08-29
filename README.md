# Virtualizare și containerizare

Conspectul lecțiilor a cursului "Virtualizare și containerizare". El este preconizat pentru 12 lecții teoretice. Pentru a înțelege materialul, trebuie mai întâi să studiați cursurile "Sisteme de operare", "Rețele de calculatoare", "Baze de date".

În cadrul cursului se studiază scopul virtualizării și containerizării aplicațiilor, domenii de utilizare ale containerelor, crearea imaginilor și rularea containerelor, crearea unui grup de containere și orchestrarea acestora.

După finalizarea cursului studenții vor putea:

- Înțelege conceptele de bază ale virtualizării și containerizării;
- Crea și configura mașini virtuale folosind Qemu;
- Crea și configura containere folosind Docker;
- Utiliza Dockerfile pentru a crea imagini de containere;
- Crea și gestiona aplicații multi-container folosind docker-compose;
- Integra containerele în procesele CI / CD;
- Optimiza imaginile containerelor.

Repository-ul cu materialele cursului este disponibil pe [GitHub](https://github.com/mcroitor/app_containerization_ro).

- [Glosar](glossary.md)

## Teme

1. [Introducere](01_intro/README.md)
2. [Noțiuni de bază](02_definitions/README.md)
3. [Virtualizarea](03_virtual/README.md)
4. [Sintaxa Dockerfile](04_dockerfile_i/README.md)
5. [Pornirea aplicațiilor containerizate](05_docker_run/README.md)
6. [Comenzile suplimentare din Dockerfile](06_dockerfile_ii/README.md)
7. [Interacțiunea containerelor](07_container_usage/README.md)
8. [Crearea unui cluster de containere cu ajutorul Docker Compose](08_docker_compose_i/README.md)
9. [Particularitățile configurării clusterului de containere](09_docker_compose_ii/README.md)
10. [Integrarea continuă și livrarea continuă (CI / CD)](10_CI_CD/README.md)
11. [Optimizarea imaginii containerului](11_image_optimization/README.md)
12. [Gestionarea secretelor](12_secrets_management/README.md)
13. [Practici bune în elaborarea containerelor](13_best_practicies/README.md)

- [Materiale suplimentare](additional/README.md)
- [Exemple](examples/README.md)
- [Glosar](glossary.md)

## Bibliografie

1. Лукша Марко, __Kubernetes в действии__, Москва, 2019
2. Маркелов А. А., __Введение в технологии контейнеров и Kubernetes__ Москва: ДМКб Пресс, 2019.
3. [Finnix, __50 вопросов по Docker, которые задают на собеседованиях, и ответы на них__, Habr.com, 2020](https://habr.com/ru/companies/southbridge/articles/528206/)
4. [1shaman, __Лучшие альтернативы для Docker__, Habr.com, 2022](https://habr.com/ru/companies/first/articles/598337/)
5. [simust, __Основы контейнеризации (обзор Docker и Podman)__, Habr.com, 2022](https://habr.com/ru/articles/659049/)
6. [Bibin Wilson, Shishir Khandelwal, __How to Reduce Docker Image Size: 6 Optimization Methods__, devopscube.com, 2022](https://devopscube.com/reduce-docker-image-size/)
7. Vaibhav Kohli, Rajdeep Dua, John Wooten, __Troubleshooting Docker__, Packt, 2017
8. [kubernetes, Основы Kubernetes, kubernetes.io, 2020](https://kubernetes.io/ru/docs/tutorials/kubernetes-basics/explore/explore-intro/)
