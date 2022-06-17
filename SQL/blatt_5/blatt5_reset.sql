/* Reset Script: Blatt 5
 Programmieren von Datenbanken SS 2022
*/

DROP DATABASE IF EXISTS krankenhaus;
CREATE DATABASE IF NOT EXISTS krankenhaus;
use krankenhaus;

DROP TABLE IF EXISTS mitarbeiter;
CREATE TABLE mitarbeiter (
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

DROP TABLE IF EXISTS pfleger;
CREATE TABLE pfleger (
	pnr INT NOT NULL,
	stationid INT NOT NULL,
	PRIMARY KEY (pnr)
);

DROP TABLE IF EXISTS arzt;
CREATE TABLE arzt (
	pnr INT NOT NULL,
	fachgebiet VARCHAR(45),
	PRIMARY KEY (pnr)
);

DROP TABLE IF EXISTS station;
CREATE TABLE station (
	stationid INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(45),
	anzahlbetten INT,
	PRIMARY KEY (stationid)
);

DROP TABLE IF EXISTS patient;
CREATE TABLE patient (
	patnr INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	gebdat DATE NOT NULL,
	geschlecht VARCHAR(45),
	PRIMARY KEY (patnr)
);

DROP TABLE IF EXISTS eingwpatient;

CREATE TABLE eingwpatient (
	patnr INT NOT NULL,
	stationid INT NOT NULL,
    wann DATE default now(),
	PRIMARY KEY (patnr, stationid, wann)
);

DROP TABLE IF EXISTS symptome;
CREATE TABLE symptome (
	sympid INT NOT NULL AUTO_INCREMENT,
	beschreibung TEXT,
	PRIMARY KEY (sympid)
);

DROP TABLE IF EXISTS krankheit;

CREATE TABLE krankheit (
	fachname VARCHAR(100) NOT NULL,
	umgangsname VARCHAR(100),
	PRIMARY KEY (fachname)
);

DROP TABLE IF EXISTS medikament;

CREATE TABLE medikament (
	name VARCHAR(100) NOT NULL,
	produzent VARCHAR(200) NOT NULL,
	bestand INT UNSIGNED NOT NULL,
	preis DECIMAL(8,2),
	PRIMARY KEY (name)
);

DROP TABLE IF EXISTS ident_mit;
CREATE TABLE ident_mit (
	name_1 VARCHAR(100) NOT NULL,
	name_2 VARCHAR(100) NOT NULL,
	PRIMARY KEY (name_1, name_2)
);

DROP TABLE IF EXISTS zugeordnet;
CREATE TABLE zugeordnet (
	name VARCHAR(100) NOT NULL,
	fachname VARCHAR(100) NOT NULL,
	PRIMARY KEY (name, fachname)
);

DROP TABLE IF EXISTS treten_auf;
CREATE TABLE treten_auf (
	fachname VARCHAR(100) NOT NULL,
	sympid INT NOT NULL,
	PRIMARY KEY (fachname, sympid)
);

DROP TABLE IF EXISTS betreut;
CREATE TABLE betreut (
	pnr INT NOT NULL,
	patnr INT NOT NULL,
	tagzeit DateTime,
    kommentar VARCHAR(200),
	PRIMARY KEY (pnr, patnr, tagzeit, Kommentar)
);

DROP TABLE IF EXISTS verschreibt;
CREATE TABLE verschreibt (
	pnr INT NOT NULL,
	patnr INT NOT NULL,
	name VARCHAR(100) NOT NULL,
	tagzeit DateTime NOT NULL,
	dauer TIME,
	dosierung INT NOT NULL,
	PRIMARY KEY (pnr, patnr, name, tagzeit)
);

DROP TABLE IF EXISTS diagnostiziert;
CREATE TABLE diagnostiziert (
	pnr INT NOT NULL,
	patnr INT NOT NULL,
	fachname VARCHAR(100) NOT NULL,
	tagzeit DateTime NOT NULL,
	statusid INT NOT NULL,
	PRIMARY KEY (pnr, patnr, fachname, tagzeit)
);

DROP TABLE IF EXISTS status;
CREATE TABLE status (
	statusid INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    beschreibung VARCHAR(2000),
    PRIMARY KEY (statusid)
);

ALTER TABLE arzt 
ADD CONSTRAINT arzt_mitarbeiter
  FOREIGN KEY (pnr)
  REFERENCES mitarbeiter (pnr)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE pfleger
ADD CONSTRAINT pfleger_mitarbeiter
  FOREIGN KEY (pnr)
  REFERENCES mitarbeiter (pnr)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT pfleger_station
  FOREIGN KEY (stationid)
  REFERENCES station (stationid)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE eingwpatient
ADD CONSTRAINT eingwpatient_patient
  FOREIGN KEY (patnr)
  REFERENCES patient (patnr)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT eingwpatient_station
  FOREIGN KEY (stationid)
  REFERENCES station (stationid)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE betreut 
ADD CONSTRAINT betreut_arzt
  FOREIGN KEY (pnr)
  REFERENCES arzt (pnr)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT betreut_patient
  FOREIGN KEY (patnr)
  REFERENCES patient (patnr)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE treten_auf 
ADD CONSTRAINT tretenauf_symptome
  FOREIGN KEY (sympid)
  REFERENCES symptome (sympid)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT tretenauf_krankheit
  FOREIGN KEY (fachname)
  REFERENCES krankheit (fachname)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE verschreibt
ADD CONSTRAINT verschreibt_patient
  FOREIGN KEY (patnr)
  REFERENCES patient (patnr)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT verschreibt_arzt
  FOREIGN KEY (pnr)
  REFERENCES arzt (pnr)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT verschreibt_medikament
  FOREIGN KEY (name)
  REFERENCES medikament (name)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE ident_mit
ADD CONSTRAINT ident_mit_medikament1
  FOREIGN KEY (name_1)
  REFERENCES medikament (name)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT ident_mit_medikament2
  FOREIGN KEY (name_2)
  REFERENCES medikament (name)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE diagnostiziert
ADD CONSTRAINT diagnostiziert_patient
  FOREIGN KEY (patnr)
  REFERENCES patient (patnr)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT diagnostiziert_arzt
  FOREIGN KEY (pnr)
  REFERENCES arzt (pnr)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT diagnostiziert_krankheit
  FOREIGN KEY (fachname)
  REFERENCES krankheit (fachname)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT diagnostiziert_status
  FOREIGN KEY (statusid)
  REFERENCES status (statusid)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
 
ALTER TABLE zugeordnet
ADD CONSTRAINT zugeordnet_medikament
  FOREIGN KEY (name)
  REFERENCES medikament (name)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT zugeordnet_krankheit
  FOREIGN KEY (fachname)
  REFERENCES krankheit (fachname)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


INSERT INTO mitarbeiter 
(geschlecht, name, gebdat, strasse, hausnummer, ort, plz)
VALUES
('m', 'Albert Einstein', '1879-03-14', 'Some Street', 1, 'Mainz', 12345),
('w', 'Marie Curie', '1867-11-07', 'Some Street', 2, 'Wiesbaden', 12335),
('m', 'Alan Turing', '1912-06-23', 'Some Street', 3, 'London', 78945),
('w', 'Ada Lovelace', '1815-12-10', 'Some Street', 4, 'London', 78005),
('m', 'Edsger Wybe Dijkstra', '1930-05-11', 'Some Street', 5, 'Rotterdam', 3001),
('w', 'm', '1953-04-13', 'Some Street', 6, 'London', 17007),
('m','Peter', '1980-01-01','Hauptstrasse','1', 'Frankfurt',15236),
('w','Lara', '1970-06-05','Nebenstrasse','2a', 'Mainz',11111),
('w','Lena','1980-01-01','Hauptweg','3c', 'Bad Homburg',11111 ),
('m','Hans', '1955-12-03','Nebenweg','30', 'Frankfurt',11111 ),
('m','Klaus', '1960-11-05','Kunststrasse','7', 'Bad Homburg',11111 ),
('w','Caroline', '1963-04-11','Kunstweg','3', 'Frankfurt',15230 ),
('w','Theresa', '1954-10-21','Klinikstrasse','9', 'Ruedesheim',11111 ),
('w','Franziska', '1984-03-11','Hauptstrasse','2', 'Neu-Isenburg',11111 ),
('m','Darius', '1983-03-22','Klinikstrasse','4', 'Wiesbaden',12335 ),
('m','Alexander', '1982-08-30','Hauptweg','11a', 'Frankfurt',15232 ),
('m','Lukas', '1967-01-01','Klinikweg','11c', 'Frankfurt',15234 ),
('w','Lavinia', '1976-09-15','Hauptstrasse','21', 'Neu-Isenburg',11111 ),
('m','Tibor', '1977-03-25','Am Main','14', 'Frankfurt',11111 ),
('m','Yannik', '1966-06-17','Am Marktplatzmitarbeiter','12c', 'Neu-Isenburg',11111 ),
('w','Anne', '1988-04-07','Unterm Weg','45', 'Ruedesheim',11111 ),
('m','Vlad', '1989-12-04','Daemmerweg','111', 'Bad Homburg',11111 ),
('w','Clodet', '1968-01-24','Waldeck','1q', 'Wiesbaden',11111 ),
('w','Dorote', '1968-01-24','Unter den Laubbaeumen','2e', 'Bad Homburg',11111 ),
('m','Marius', '1972-03-28','Hauptstrasse','6', 'Wiesbaden',11111 ),
('w','Maxine', '1962-04-27','Hauptstrasse','24', 'Bad Homburg',11111 )
;

/*static*/

INSERT INTO station
(name, anzahlbetten)
VALUES
('HNO', 10),
('Neurologe', 15),
('Chirurgie', 20),
('Allgemeinmedizin', 40),
('Onkologie', 8),
('Augenheilkunde', 15),
('Herzchirurgie', 5),
('Gefaesschirurgie', 6),
('Orthopaedie', 5),
('Unfallchirurgie', 12),
('Gefaesschirurgie', 5),
('Hals Nasen Ohr Spezialist', 9),
('Innere Medizin', 7);


INSERT INTO pfleger
(pnr, stationid)
VALUES
(1, 1),
(2, 2),
(6, 3),
(3, 2),
(11, 2),
(22, 1);


INSERT INTO arzt
(pnr, fachgebiet)
VALUES
(8, 'Chirurgie'),
(4, 'Neurologie'),
(5, 'Innere Medizin'),
(14, 'Allgemeinmedizin'),
(12, 'Orthopaedie'),
(13, 'Anaesthesie');

INSERT INTO patient
(name, gebdat, geschlecht)
VALUES
('Max Mustermann', '1993-07-15', 'm'),
('Mika Mustermann', '1990-10-03', 'w'),
('Moritz Petersen', '1982-12-21', 'm'),
('Hanna Mai', '1992-04-09', 'w'),
('Kate','1961-01-01','w'),
('Harry','1992-04-27','m'),
('Harro','1965-02-22','m'),
('Nathaniel','1978-07-23','m'),
('Odette','1992-11-11','w'),
('Anne','1969-12-19','w'),
('Anja','1973-08-12','w'),
('Hursel','1981-04-08','m'),
('Bond','1980-04-30','m'),
('Dora','1992-03-09','w'),
('Marco', '1987-08-04', 'm'),
('Dele', '1990-12-03', 'w'),
('Peter', '1976-01-04', 'm'),
('Julian', '1990-05-16', 'm'),
('Blabla', '1995-02-06', 'w'),
('Inferno', '1977-05-02', 'w'),
('Grey', '2019-02-10', 'm'),
('Gisela', '1987-08-04', 'w'),
('Robert', '1980-10-04', 'm'),
('Hans', '1957-08-04', 'm'),
('Monika Reich','1970-08-29','w'),
('Johannes Mirk','1975-07-19','m'),
('Vera Pohl','1987-06-07','w'),
('Chris Meier','1954-05-08','m');

INSERT INTO symptome
(beschreibung)
VALUES
('Heiserkeit'), 
('Erbrechen'), 
('Kopfschmerzen'), 
('Husten'), 
('Hautausschlag'), 
('Schwellung'), 
('Laehmmung'), 
('Müdigkeit'),
('Vergesslichkeit'),
('Ausschlag'),
('Verfolgungswahn'),
('Depressionen'),
('Taubheitsgefuehle'),
('Stechender Schmerz'),
('Juckreiz');

INSERT INTO krankheit
(fachname, umgangsname)
VALUES
('Gastroenteritis', 'Magen-Darm-Grippe'),
('Fraktur', 'Knochenbruch'),
('Lebensmittelintoxikation', 'Lebensmittelvergiftung'),
('Apoplex', 'Schlaganfall'),
('Commotio cerebri', 'Gehirnerschuetterung'),
('Effectus', 'Infekt'),
('Fussi Juckus', 'Fusspilz'),
('Gripus', 'Grippe'),
('Hatschi', 'Schnupfen'),
('Husterus', 'Starker Husten'),
('Incidento', 'Unfaelle'),
('Infarkt', 'Infarkt'),
('Kopf Aua', 'Kopfschmerzen'),
('Nervus Klemus', 'Nerven eingeklemmt'),
('Ohrus', 'Ohrenschmerzen'),
('Wundus', 'Offene Wunden'),
('Insomnia', 'Schlaflosigkeit'),
('Alternaria', 'Zeckeninfektion'),
('HIV', 'Aids'),
('Sarati', 'Grippe'),
('Malitosus', 'Burnout'),
('Namrium', 'Alzhaimer'),
('Propus', 'Alkoholsucht'),
('Arderum', 'Lebensmittelvergiftung'),
('Everin', 'Gelbsucht'),
('Solares', 'Verrückt');

INSERT INTO medikament
(name, produzent, bestand, preis)
VALUES
('Medikament1', 'Bayer', 214, 80.95),
('Medikament2', 'Bayer', 50, 200.15),
('Medikament3', 'Novartis', 172, 64.80),
('Medikament4', 'Merck & Co.', 122, 78.31),
('Medikament5', 'Merck & Co.', 198, 215.17),
('Ritalin','Rita',200,20.99),
('Serobentin','Phano',10,10.99),
('Altriserium','Rita',13,50.99),
('Maltrodextrin','Phano',120,49.99),
('Didextrotrin','Derso',50,5.99),
('Antidoxin','Rita',50,9.99),
('Miakum','Rita',5,21.99),
('Sorium','Deraso',10,26.99),
('Placebo','Phano',250,2.99),
('Dopanium','Rita',90,99.99),
('Acc Acut 600', 'Hexal', 50, 1.00),
('Antibabypille2', 'Hexal', 100, 2.00),
('Antibabypille3', 'Bayer', 100, 5.00),
('Aspirin', 'Hexal', 60, 2.00),
('Aspirin Complex', 'Hexal', 150, 22.00),
('Bepanthen', 'Hexal', 100, 1.00),
('Betablocker', 'Bayer', 40, 10.00),
('Blutungshaemmer1', 'Bayer', 100, 3.00),
('Blutungshaemmer2', 'Bayer', 100, 3.00),
('Botox', 'Hexal', 10, 2.00),
('Boxa Gripal', 'Ratiopharm', 250, 2.00),
('Dolormin', 'Bayer', 123, 2.00),
('Fusspilzsalbe1', 'Hexal', 310, 3.00),
('Fusspilzsalbe12', 'Hexal', 310, 3.00),
('Geringungsmittel', 'Hexal', 100, 1.00),
('Geringungsmittel2', 'Hexal', 100, 3.00),
('Gripostat C', 'Hexal', 100, 2.00),
('Iberogast', 'Hexal', 100, 35.00),
('Ibupropeth', 'Bayer', 200, 141.00),
('Insulin', 'Hexal', 300, 3.00),
('Kopfschmerzmittel', 'Hexal', 100, 22.00),
('Meditonsin', 'Bayer', 320, 52.00),
('Nasenspray', 'Hexal', 200, 47.00),
('Nasentropfen', 'Hexal', 100, 35.00),
('Ohrtropfen', 'Hexal', 100, 12.00),
('Schlafmittel', 'Hexal', 90, 20.00),
('Sergos', 'Bayer', 100, 72.00),
('Sinupret', 'Bayer', 323, 33.00),
('Thomapirn', 'Rationpharm', 300, 14.00),
('Viagra', 'Bayer', 20, 15.00),
('Wund Und Heil Salbe', 'Bayer', 100, 1111.00);

# Erzeugt eine Warnung (Data truncated), da nur das Datum von now() benötigt wird.
# Diese kann aber ignoriert werden. 
INSERT INTO eingwpatient
(patnr, stationid)
VALUES
(1,13),
(2,11),
(3,12),
(4,10),
(5,9),
(6,4),
(7,1),
(8,6),
(9,2),
(10,11),
(11,4),
(12,3),
(13,9),
(14,12),
(15,5),
(16,7),
(17,3),
(18,1),
(19,8),
(20,10),
(21,12),
(22,1),
(23,5),
(24,1),
(25,6),
(26,6),
(27,1),
(28,7);

INSERT INTO eingwpatient
(patnr, stationid, wann)
VALUES
(1,10, '2022-05-08'),
(3,10, '2022-05-06'),
(3,6, '2022-05-08');



INSERT INTO status
(statusid, name, beschreibung)
VALUES
(1, 'geheilt', 'kann entlassen werden'),
(2, 'sehr gute Heilung', 'kurz vorm Entlassen'),
(3, 'gute Heilung', 'beobachten'),
(4, 'Heilungsprozess gestartet', 'wurde vor kurzem eingeliefert'),
(5, 'Befriedigende Heilung', 'ggf nochmal operieren?'),
(6, 'schlecht', 'fuer die Intensiv vorbereiten'),
(7, 'langsame Heilung', 'ggf andere Medikamente'),
(8, 'tod', 'Angehoerige informieren'),
(9, 'ansteckend', 'Schleuse anbringen'),
(10, 'noch nicht feststellbar', 'OPBericht abwarten');

INSERT INTO treten_auf
(fachname, sympid)
VALUES
('Gastroenteritis', 2),
('Gastroenteritis', 3),
('Gastroenteritis', 4),
('Lebensmittelintoxikation', 2),
('Fraktur', 6),
('Apoplex', 7),
('Commotio cerebri', 3),
('Apoplex',5),
('Arderum',9),
('Commotio cerebri',6),
('Effectus',3),
('Everin',13),
('Fraktur',12),
('Fussi Juckus',11),
('Gastroenteritis',9),
('Gripus',13),
('Hatschi',13),
('HIV',2),
('Husterus',1),
('Incidento',4),
('Infarkt',4),
('Insomnia',10),
('Apoplex',13),
('Arderum',11),
('Commotio cerebri',2),
('Effectus',1),
('Everin',1),
('Fraktur',1),
('Fussi Juckus',9),
('Gastroenteritis',7),
('Gripus',6),
('Hatschi',6),
('HIV',4),
('Husterus',6),
('Incidento',5),
('Infarkt',8),
('Insomnia',2);

INSERT INTO ident_mit
(name_1, name_2)
VALUES
('Iberogast', 'Insulin'),
('Gripostat C', 'Medikament4'),
('Medikament2', 'Medikament5'),
('Medikament3', 'Medikament4'),
('Gripostat C', 'Medikament3'),
('Sergos', 'Sinupret'),
('Dolormin', 'Boxa Gripal'),
('Ibupropeth', 'Insulin'),
('Iberogast', 'Aspirin'),
('Fusspilzsalbe1', 'Fusspilzsalbe12');


INSERT INTO betreut
(patnr, pnr, tagzeit, kommentar)
VALUES
/* arzte */
(1,12, '2022-05-08 12:34:15', 'Hier steht ein Kommentar'),
(5,12, '2022-05-08 11:34:15', 'Hier steht ein Kommentar'),
(6,13, '2022-05-08 10:34:15', 'Hier steht ein Kommentar'),
(8,13, '2022-05-08 12:30:15', 'Hier steht ein Kommentar'),
(10,8, '2022-05-08 15:34:15', 'Hier steht ein Kommentar'),
(13,8, '2022-05-08 14:34:15', 'Hier steht ein Kommentar'),
(15,5, '2022-05-08 12:14:15', 'Hier steht ein Kommentar');

INSERT INTO verschreibt
(patnr, pnr, name, tagzeit, dauer, dosierung)
VALUES
(1,5, 'Wund Und Heil Salbe', '2022-04-12 20:20:42.607', '532:11:11', 9),
(6,13, 'Aspirin', '2018-11-29 13:55:17.825', '224:14:14', 23),
(1,13, 'Viagra', '2018-06-29 20:25:55.381', '791:1:1', 25),
(1,14, 'Ibupropeth', '2022-03-03 18:58:55.198', '811:8:8', 19),
(11,5, 'Blutungshaemmer2', '2017-03-18 23:32:46.845', '592:52:52', 42),
(12,4, 'Aspirin', '2022-04-12 10:38:29.558', '144:15:15', 33),
(18,5, 'Ibupropeth', '2018-03-26 16:29:27.954', '310:58:58', 6),
(25,4, 'Aspirin', '2022-04-12 22:57:55.503', '593:1:1', 19);


INSERT INTO diagnostiziert
(patnr, pnr, fachname, tagzeit, statusid)
VALUES
(9,13, 'Namrium', '2017-04-26 06:03:14.005', 6),
(12,5, 'Hatschi', '2017-05-29 00:57:37.116', 6),
(16,14, 'Fraktur', '2018-07-02 07:56:09.38', 7),
(17,8, 'Hatschi', '2018-01-25 21:53:37.138', 10),
(18,12, 'Arderum', '2017-07-17 03:56:05.004', 9),
(19,4, 'Solares', '2019-08-17 22:17:46.183', 1),
(23,4, 'Arderum', '2019-11-25 03:41:15.785', 7);


INSERT INTO zugeordnet
(name, fachname)
VALUES
('Altriserium', 'Nervus Klemus'),
('Antibabypille2', 'Malitosus'),
('Antibabypille3', 'Effectus'),
('Antidoxin', 'Fraktur'),
('Aspirin', 'Incidento'),
('Aspirin Complex', 'Malitosus'),
('Bepanthen', 'Insomnia'),
('Betablocker', 'Hatschi'),
('Blutungshaemmer1', 'Fraktur'),
('Blutungshaemmer2', 'Commotio cerebri'),
('Botox', 'Propus'),
('Boxa Gripal', 'Apoplex'),
('Didextrotrin', 'Propus'),
('Dolormin', 'Apoplex'),
('Dopanium', 'Gastroenteritis'),
('Fusspilzsalbe1', 'Gripus'),
('Fusspilzsalbe12', 'Everin'),
('Geringungsmittel', 'Effectus'),
('Geringungsmittel2', 'Alternaria'),
('Gripostat C', 'Hatschi'),
('Iberogast', 'Fussi Juckus'),
('Ibupropeth', 'Lebensmittelintoxikation'),
('Insulin', 'Nervus Klemus'),
('Kopfschmerzmittel', 'Incidento'),
('Maltrodextrin', 'Lebensmittelintoxikation'),
('Medikament1', 'Incidento'),
('Medikament2', 'Effectus'),
('Medikament3', 'Arderum'),
('Medikament4', 'Infarkt'),
('Medikament5', 'Sarati'),
('Meditonsin', 'Husterus'),
('Miakum', 'Malitosus'),
('Nasenspray', 'Fussi Juckus'),
('Nasentropfen', 'Apoplex'),
('Ohrtropfen', 'Insomnia'),
('Placebo', 'Fussi Juckus'),
('Ritalin', 'Fraktur'),
('Schlafmittel', 'Everin'),
('Sergos', 'Solares'),
('Serobentin', 'Malitosus'),
('Sinupret', 'Nervus Klemus'),
('Sorium', 'Gastroenteritis'),
('Thomapirn', 'Arderum'),
('Viagra', 'Kopf Aua'),
('Wund Und Heil Salbe', 'Malitosus');

ALTER TABLE `verschreibt` DROP COLUMN `dauer`;