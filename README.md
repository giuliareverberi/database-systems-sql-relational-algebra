# Database Systems: SQL, Relational Algebra & ER Modeling

Questa repository contiene una serie di esercitazioni pratiche e teoriche sui sistemi di gestione di basi di dati (DBMS). I progetti coprono l'intero ciclo di vita di un database: dalla progettazione concettuale (Modello Entità-Relazione) all'implementazione fisica e all'interrogazione tramite SQL e Algebra Relazionale.

## Contenuti del Progetto

1. **Progettazione Concettuale (Modelli ER):**
   * Analisi dei vincoli di cardinalità e delle regole del modello ER.
   * Progettazione di schemi complessi per sistemi bancari (prestiti, agenzie, tassi di interesse), agenzie immobiliari (vendite, affitti, ristrutturazioni storiche)e reti di distribuzione (macchine erogatrici).

2. **Algebra Relazionale:**
   * Traduzione di interrogazioni complesse in espressioni di algebra relazionale utilizzando operatori di Proiezione ($\pi$), Selezione ($\sigma$), Join Naturale ($\bowtie$), Ridenominazione ($\rho$) e operatori insiemistici come Unione ($\cup$) e Differenza ($-$).

3. **Query SQL e Ottimizzazione:**
   * **Database "Concorso":** Script DDL completi per la creazione di tabelle con vincoli di integrità (`PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `UNIQUE`), popolamento DML e viste complesse.
   * **Database "Persone & Genia":** Query ricorsive e join complessi per la gestione di alberi genealogici (genitori, figli, nonni).
   * **Database "Birre & Bar":** Interrogazioni avanzate con aggregazioni, `EXCEPT`, `INTERSECT`, `GROUP BY` e `HAVING`.

## 🚀 Utilizzo
Gli script SQL sono testati e compatibili con lo standard PostgreSQL (es. `\c nome_database`). Per eseguirli, è sufficiente avviare il client `psql` o un'interfaccia come pgAdmin ed eseguire i file `.sql`.

## 👤 Autore
* **Giulia Reverberi**
