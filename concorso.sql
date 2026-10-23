Database Concorso
DDL, DML e Query di estrazione dati


CREATE DATABASE concorso;
\c concorso;

-- ESERCIZIO 1: Creazione Tabelle e Vincoli


CREATE TABLE candidato (
    nome VARCHAR NOT NULL, 
    cognome VARCHAR NOT NULL, 
    datadinascita DATE NOT NULL,
    codicefiscale CHAR(16) NOT NULL PRIMARY KEY,  
    UNIQUE (codicefiscale)
);

CREATE TABLE domanda (
    id INT NOT NULL PRIMARY KEY, 
    materia VARCHAR NOT NULL, 
    testo VARCHAR NOT NULL,
    UNIQUE (id),
    CHECK (
        materia = 'Diritto civile' OR 
        materia = 'Diritto amministrativo' OR 
        materia = 'Diritto penale' OR 
        materia = 'Lingua inglese' OR 
        materia = 'Informatica'
    )
);

CREATE TABLE prova ( 
    data DATE NOT NULL, 
    iddomanda INT NOT NULL, 
    idcandidato CHAR(16) NOT NULL, 
    voto INT, 
    idoneo BOOLEAN, 
    CHECK (voto >= 0 AND voto <= 10), 
    CHECK (
        (voto IS NOT NULL AND idoneo IS NULL) OR 
        (voto IS NULL AND idoneo IS NOT NULL)
    ),
    FOREIGN KEY(iddomanda) REFERENCES domanda(id) ON DELETE CASCADE,  
    FOREIGN KEY(idcandidato) REFERENCES candidato(codicefiscale) ON DELETE CASCADE, 
    PRIMARY KEY(data, iddomanda),
    UNIQUE(iddomanda, idcandidato) 
); 
-- NOTA SUI VINCOLI:
-- È presente un vincolo di inclusione tra candidato e prova (id candidato non chiave).
-- È presente un vincolo di Check per l'implicazione esclusiva tra voto e idoneità.


-- ESERCIZIO 2: Popolamento Tabelle


INSERT INTO candidato (nome, cognome, datadinascita, codicefiscale) VALUES
('Giorgio', 'Rossi', '1990-12-12', 'RSSGRG90R71H501F'),
('Luca', 'Bianchi', '2000-03-03', 'LCUBNC00P71H501Z'),
('Luigi', 'Verdi', '1994-07-23', 'LGUVRD94L65K501T');

INSERT INTO domanda (id, materia, testo) VALUES
(1, 'Informatica', 'VPN'),
(2, 'Diritto penale', 'Notitia criminis'),
(3, 'Diritto amministrativo', 'SpA'),
(4, 'Lingua inglese', 'The narrowest house'),
(5, 'Diritto penale', 'La pena');

INSERT INTO prova (data, iddomanda, idcandidato, voto, idoneo) VALUES
('2022-01-24', 1, 'LGUVRD94L65K501T', NULL, TRUE),
('2022-01-25', 4, 'LCUBNC00P71H501Z', NULL, FALSE),
('2022-01-24', 3, 'LGUVRD94L65K501T', 8, NULL),
('2022-01-25', 3, 'RSSGRG90R71H501F', 9, NULL),
('2022-01-24', 5, 'RSSGRG90R71H501F', 9, NULL),
('2022-01-24', 4, 'RSSGRG90R71H501F', NULL, TRUE),
('2022-01-24', 2, 'LGUVRD94L65K501T', 7, NULL);


-- ESERCIZIO 3: Query SQL

-- 1. Candidati che non hanno ottenuto nessun giudizio di idoneità pari a TRUE
SELECT nome, cognome
FROM candidato
EXCEPT
SELECT c.nome, c.cognome
FROM candidato c JOIN prova p ON c.codicefiscale = p.idcandidato
WHERE p.idoneo = TRUE;

-- 2. Media dei voti assegnati, per ogni giorno e per ogni materia
SELECT p.data, d.materia, AVG(p.voto) AS media_voto
FROM prova p JOIN domanda d ON p.iddomanda = d.id
GROUP BY p.data, d.materia;

-- 3. Materie per le quali sono state poste in uno stesso giorno più di 2 domande
SELECT d.materia
FROM prova p JOIN domanda d ON p.iddomanda = d.id
GROUP BY p.data, d.materia
HAVING COUNT(DISTINCT p.iddomanda) > 2;

-- 4. Candidati che hanno avuto solo voti superiori a 9 e idoneità TRUE
SELECT c.nome, c.cognome
FROM candidato c JOIN prova p ON c.codicefiscale = p.idcandidato
EXCEPT
SELECT c.nome, c.cognome
FROM candidato c JOIN prova p ON c.codicefiscale = p.idcandidato
WHERE (p.voto <= 9 OR p.idoneo = FALSE);

-- 5. Codici fiscali di candidati idonei in almeno una materia con almeno un voto >= 8
SELECT idcandidato 
FROM prova
WHERE voto >= 8
INTERSECT
SELECT idcandidato
FROM prova
WHERE idoneo = TRUE;

-- 6. Studente con voto massimo per ogni materia (che non sia idoneità)
SELECT d.materia, c.nome, c.cognome, p.voto
FROM domanda d 
JOIN prova p ON d.id = p.iddomanda 
JOIN candidato c ON c.codicefiscale = p.idcandidato
WHERE (d.materia, p.voto) IN (
    SELECT materia, MAX(voto)
    FROM prova JOIN domanda ON iddomanda = id
    WHERE voto IS NOT NULL
    GROUP BY materia
);


-- ESERCIZIO 4: Viste

CREATE VIEW SinotticoProveCandidato(nome, cognome, numeroprove, media, numerovoti) AS 
SELECT c.nome, c.cognome, COUNT(*), AVG(p.voto), COUNT(p.voto)
FROM candidato c JOIN prova p ON c.codicefiscale = p.idcandidato
GROUP BY c.codicefiscale, c.nome, c.cognome;