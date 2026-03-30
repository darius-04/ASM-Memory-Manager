# x86 Memory & Disk Manager Simulator

## 📝 Descriere
Acest proiect este un simulator de gestionare a memoriei (sau a spațiului pe disc) scris integral în **Assembly x86 (AT&T Syntax)**. Programul gestionează un spațiu de memorie virtual de 1024 de unități, permițând alocarea, regăsirea, ștergerea și optimizarea fișierelor prin operații low-level.

Este un proiect care demonstrează înțelegerea profundă a modului în care sistemele de operare gestionează resursele hardware și memoria contiguă.

## 🚀 Funcționalități
Simulatorul suportă 4 operații principale:
1.  **ADD**: Alocă spațiu pentru fișiere noi. Calculează dimensiunea necesară (conversie din KB în blocuri de 8 unități) și caută primul spațiu liber contiguu (**First Fit**).
2.  **GET**: Identifică intervalul de memorie (start, end) ocupat de un anumit descriptor de fișier.
3.  **DELETE**: Eliberează memoria ocupată de un fișier și marchează spațiul ca fiind liber.
4.  **DEFRAG**: Optimizează spațiul prin mutarea tuturor fișierelor la începutul memoriei, eliminând "găurile" (fragmentarea externă) pentru a face loc unor alocări noi mai mari.

## 🛠 Detalii Tehnice
* **Arhitectură:** x86 32-bit.
* **Sintaxă:** AT&T.
* **Gestiune Memorie:** Vector de 4096 bytes (1024 elemente x 4 bytes).
* **Apeluri de Sistem:** Utilizarea `printf` și `scanf` din biblioteca standard C pentru I/O, integrat prin stivă.
* **Optimizare:** Implementarea unui algoritm de defragmentare in-place pentru gestionarea eficientă a spațiului.

## 📊 Exemplu de utilizare
Programul citește numărul de task-uri, apoi codul task-ului (1-4):
- `1` (ADD): Urmează numărul de fișiere, apoi pentru fiecare: `ID` și `Dimensiune`.
- `4` (DEFRAG): Reorganizează memoria și afișează noua stare.

## 💻 Cum se rulează
Pentru a compila și rula pe un sistem Linux pe 32 de biți (sau folosind biblioteci 32-bit pe 64-bit):

```bash
gcc -m32 main.s -o simulator
./simulator
