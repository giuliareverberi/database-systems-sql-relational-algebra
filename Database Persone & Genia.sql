Database Persone & Genia
Query SQL 

-- 1. Nome e regione di nascita di tutte le persone maggiorenni
SELECT p.nome, c.regione 
FROM Persona p JOIN Citta c ON p.cittanascita = c.nome 
WHERE p.eta > 18;

-- 2. Regioni in cui si trova almeno una città in cui è nato un genitore > 50 anni
SELECT DISTINCT c.regione 
FROM Persona p 
JOIN Genia g ON p.nome = g.genitore
JOIN Citta c ON p.cittanascita = c.nome
WHERE p.eta > 50;

-- 4. Lista senza ripetizioni dei nonni (maschi)
SELECT DISTINCT m.genitore 
FROM Genia g 
JOIN Genia m ON g.genitore = m.figlio 
JOIN Persona p ON m.genitore = p.nome 
WHERE p.sesso = 'M';

-- 11. Quante persone sono nate in ogni regione
SELECT c.regione, COUNT(*) AS numero_persone
FROM Persona p JOIN Citta c ON p.cittanascita = c.nome 
GROUP BY c.regione;


Database Birre & Bar
Query SQL 

-- 9. Birra venduta al prezzo massimo
SELECT birra 
FROM Serve 
WHERE prezzo = (SELECT MAX(prezzo) FROM Serve);

-- 12. Bevitori che frequentano tutti i bar della città in cui vivono (Divisione relazionale)
SELECT b.nome 
FROM Bevitore b 
JOIN Frequenta f ON b.nome = f.bevitore 
JOIN Bar ba ON f.bar = ba.nome AND ba.citta = b.citta
GROUP BY b.nome, b.citta
HAVING COUNT(DISTINCT ba.nome) = (
    SELECT COUNT(*) 
    FROM Bar 
    WHERE citta = b.citta
);