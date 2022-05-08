/* Reset Script: Blatt 2
 Programmieren von Datenbanken SS 2022
*/

/* Tabellen: mitarbeiter, pfleger 
medikament, arzt, station, eingwpatient, diagnostiziert */


DROP DATABASE IF EXISTS krankenhaus;
CREATE DATABASE IF NOT EXISTS krankenhaus;

DROP TABLE IF EXISTS krankenhaus.mitarbeiter;
CREATE TABLE krankenhaus.mitarbeiter (
	pnr INT NOT NULL AUTO_INCREMENT,
	geschlecht VARCHAR(45) NOT NULL,
	name VARCHAR(45) NOT NULL,
	gebdat DATE NOT NULL,
	strasse VARCHAR(45),
	hausnummer VARCHAR(45),
	ort VARCHAR(45),
	plz INT,
	PRIMARY KEY (pnr)
);

DROP TABLE IF EXISTS krankenhaus.pfleger;
CREATE TABLE krankenhaus.pfleger (
	pnr INT NOT NULL,
	stationid INT NOT NULL,
	PRIMARY KEY (pnr)
);

DROP TABLE IF EXISTS krankenhaus.arzt;
CREATE TABLE krankenhaus.arzt (
	pnr INT NOT NULL,
	fachgebiet VARCHAR(45),
	PRIMARY KEY (pnr)
);

DROP TABLE IF EXISTS krankenhaus.station;
CREATE TABLE krankenhaus.station (
	stationid INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(45),
	anzahlbetten INT,
	PRIMARY KEY (stationid)
);

DROP TABLE IF EXISTS krankenhaus.patient;
CREATE TABLE krankenhaus.patient (
	patnr INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	gebdat DATE NOT NULL,
	geschlecht VARCHAR(45),
	PRIMARY KEY (patnr)
);

DROP TABLE IF EXISTS krankenhaus.eingwpatient;

CREATE TABLE krankenhaus.eingwpatient (
	patnr INT NOT NULL,
	stationid INT NOT NULL,
	PRIMARY KEY (patnr)
);



DROP TABLE IF EXISTS krankenhaus.medikament;

CREATE TABLE krankenhaus.medikament (
	name VARCHAR(100) NOT NULL,
	produzent VARCHAR(200) NOT NULL,
	bestand INT UNSIGNED NOT NULL,
	preis DECIMAL(8,2),
	PRIMARY KEY (name)
);

DROP TABLE IF EXISTS krankenhaus.diagnostiziert;
CREATE TABLE krankenhaus.diagnostiziert (
	pnr INT NOT NULL,
	patnr INT NOT NULL,
	fachname VARCHAR(100) NOT NULL,
	tagzeit DateTime NOT NULL,
	statusid INT NOT NULL,
	PRIMARY KEY (pnr, patnr, fachname, tagzeit)
);



INSERT INTO krankenhaus.mitarbeiter 
(geschlecht, name, gebdat, strasse, hausnummer, ort, plz)
VALUES
('m', 'Albert Einstein', '1879-03-14', 'Some Street', 1, 'Frankfurt', 12345),
('w', 'Marie Curie', '1867-11-07', 'Some Street', 2, 'Wiesbaden', 12335),
('m', 'Alan Turing', '1912-06-23', 'Some Street', 3, 'Frankfurt', 12345),
('w', 'Ada Lovelace', '1815-12-10', 'Some Street', 4, 'London', 12345),
('m', 'Edsger Wybe Dijkstra', '1930-05-11', 'Some Street', 5, 'Frankfurt', 12345);

INSERT INTO krankenhaus.station
(name, anzahlbetten)
VALUES
('HNO', 20),
('Neurologe', 15),
('Chirurgie', 20),
('Allgemeinmedizin', 40),
('Onkologie', 20);


INSERT INTO krankenhaus.pfleger
(pnr, stationid)
VALUES
(1, 1),
(2, 2),
(3, 4),
(4, 3),
(5, 5);


INSERT INTO krankenhaus.arzt
(pnr, fachgebiet)
VALUES
(1, 'Neurologie'),
(5, 'Innere Medizin');

INSERT INTO krankenhaus.patient
(name, gebdat, geschlecht)
VALUES
('Max Mustermann', '1993-07-15', 'm'),
('Mika Mustermann', '1990-10-03', 'w'),
('Moritz Petersen', '1982-12-21', 'm'),
('Hanna Mai', '1992-04-09', 'w'),
('Kate','1961-01-01','w');

INSERT INTO krankenhaus.medikament
(name, produzent, bestand, preis)
VALUES
('Nasenspray', 'Hexal', 200, 47.00),
('Nasentropfen', 'Hexal', 100, 35.00),
('Ohrtropfen', 'Hexal', 100, 12.00),
('Schlafmittel', 'Hexal', 90, 20.00),
('Sergos', 'Bayer', 100, 72.00),
('Sinupret', 'Bionorica', 323, 33.00),
('Thomapyrn', 'Ratiopharm', 300, 14.00),
('Viagra', 'Bayer', 20, 15.00),
('Wund Und Heil Salbe', 'Bayer', 100, 1111.00);

INSERT INTO krankenhaus.eingwpatient
(patnr, stationid)
VALUES
(1,3),
(2,1),
(3,4),
(4,5);

INSERT INTO krankenhaus.diagnostiziert
(patnr, pnr, fachname, tagzeit, statusid)
VALUES
(1,2, 'Arderum', '2020-02-20 15:33:28.386', 7),
(2,1, 'Effectus', '2020-02-12 03:48:33.366', 6),
(3,2, 'Commotio cerebri', '2020-03-09 17:17:52.776', 7),
(4,1, 'Incidento', '2020-03-04 19:08:56.002', 6),
(5,2, 'Commotio cerebri', '2020-03-30 21:55:07.423', 4);

USE krankenhaus;
