/* Reset Script: Blatt 3
 Programmieren von Datenbanken
*/
DROP DATABASE IF EXISTS krankenhaus;
CREATE DATABASE IF NOT EXISTS krankenhaus;
USE krankenhaus;

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



INSERT INTO mitarbeiter 
(geschlecht, name, gebdat, strasse, hausnummer, ort, plz)
VALUES
('m', 'Albert Einstein', '1879-03-14', 'Some Street', 1, 'Mainz', 12345),
('w', 'Marie Curie', '1867-11-07', 'Some Street', 2, 'Wiesbaden', 12335),
('m', 'Alan Turing', '1912-06-23', 'Some Street', 3, 'London', 78945),
('w', 'Ada Lovelace', '1815-12-10', 'Some Street', 4, 'London', 78005),
('m', 'Edsger Wybe Dijkstra', '1930-05-11', 'Some Street', 5, 'Rotterdam', 3001),
('w', 'm', '1953-04-13', 'Some Street', 6, 'London', 17007),
('m','Peter', '1980-01-01','Hauptstrasse','1', 'Frankfurt',11111),
('w','Lara', '1970-06-05','Nebenstrasse','2a', 'Mainz',11111),
('w','Lena','1980-01-01','Hauptweg','3c', 'Bad Homburg',11111 ),
('m','Hans', '1955-12-03','Nebenweg','30', 'Frankfurt',11111 ),
('m','Klaus', '1960-11-05','Kunststrasse','7', 'Bad Homburg',11111 ),
('w','Caroline', '1963-04-11','Kunstweg','3', 'Frankfurt',11111 ),
('w','Theresa', '1954-10-21','Klinikstrasse','9', 'Ruedesheim',11111 ),
('w','Franziska', '1984-03-11','Hauptstrasse','2', 'Neu-Isenburg',11111 ),
('m','Darius', '1983-03-22','Klinikstrasse','4', 'Wiesbaden',12335 ),
('m','Alexander', '1982-08-30','Hauptweg','11a', 'Frankfurt',11111 ),
('m','Lukas', '1967-01-01','Klinikweg','11c', 'Frankfurt',11111 ),
('w','Lavinia', '1976-09-15','Hauptstrasse','21', 'Neu-Isenburg',11111 ),
('m','Tibor', '1977-03-25','Am Main','14', 'Frankfurt',11111 ),
('m','Yannik', '1966-06-17','Am Marktplatzmitarbeiter','12c', 'Neu-Isenburg',11111 ),
('w','Anne', '1988-04-07','Unterm Weg','45', 'Ruedesheim',11111 ),
('m','Vlad', '1989-12-04','Daemmerweg','111', 'Bad Homburg',11111 ),
('w','Clodet', '1968-01-24','Waldeck','1q', 'Wiesbaden',11111 ),
('w','Dorote', '1968-01-24','Unter den Laubbaeumen','2e', 'Bad Homburg',11111 ),
('m','Marius', '1972-03-28','Hauptstrasse','6', 'Wiesbaden',11111 ),
('w','Maxine', '1962-04-27','Hauptstrasse','24', 'Bad Homburg',11111 ),
('m', 'Albert', '1980-01-01', 'Gutleutstrasse', '1', 'Ruedesheim', 63000),
('w', 'Schmidt', '1975-02-01', 'Gutleutstrasse', '10', 'Gross Gerau', 63001),
('m', 'Hinz', '1976-05-04', 'Roemerberg', '5', 'Neu-Isenburg', 63002),
('w', 'Kunz', '1972-06-06', 'Hipdebach', '20', 'Bad Homburg', 63004),
('w', 'Kunibert', '1965-12-07', 'Druebdebach', '34', 'Frankfurt', 63005),
('m', 'Allnatelong', '1985-07-12', 'Kaiserstrasse', '18', 'Bad Homburg', 63006),
('w', 'Missbombastig', '1987-09-09', 'Gutleutstrasse', '13', 'Frankfurt', 63007),
('m', 'Itzeo', '1956-02-07', 'Halligalli', '14', 'Neu-Isenburg', 63008),
('w', 'Kunzmann', '1984-08-13', 'DaimlerBenz', '2', 'Gross Gerau', 63009),
('m', 'Hainer', '1980-05-16', 'TheodorHeussAllee', '20', 'Neu-Isenburg', 63010),
('m', 'Rainer', '1976-08-09', 'WillyBrandtPlatz', '3', 'Bad Vilbel', 63011),
('m', 'Oehlbrecht', '1978-05-14', 'Zeil', '10', 'Gross Gerau', 63012),
('m', 'Heine', '1984-02-09', 'Roemerberg', '5', 'Ruedesheim', 63013),
('w', 'Yang', '1987-09-15', 'AepplerWeg', '12', 'Gross Gerau', 63014),
('m', 'Kunibert', '1964-12-03', 'Druebdebach', '34', 'Mainz', 63015),
('w', 'Adenauer', '1985-12-18', 'MayerStrasse', '12', 'Gross Gerau', 63016),
('m', 'Elcato', '1990-05-16', 'Kaestnerallee', '11', 'Mainz', 63017),
('m', 'Huibu', '1983-12-24', 'AvantiStrasse', '14', 'Gross Gerau', 63018),
('m', 'Kunzmann', '1981-12-04', 'DaimlerBenz', '2', 'Frankfurt', 63019),
('w', 'Mau', '1983-01-04', 'RembrueckerWeg', '14', 'Mainz', 63020);

/*static*/

INSERT INTO station
(name, anzahlbetten)
VALUES
('HNO', 20),
('Neurologe', 15),
('Chirurgie', 20),
('Allgemeinmedizin', 40),
('Onkologie', 20),
('Augenheilkunde', 25),
('Herzchirurgie', 25),
('Gefaesschirurgie', 25),
('Orthopaedie', 25),
('Unfallchirurgie', 25),
('Gefaesschirurgie', 25),
('Hals Nasen Ohr Spezialist', 25),
('Innere Medizin', 25);


INSERT INTO pfleger
(pnr, stationid)
VALUES
(1, 1),
(2, 2),
(6, 3),
(3, 4),
(7, 5),
(11, 6),
(21, 7),
(22, 8),
(36, 9),
(31, 5),
(32, 11),
(46, 5),
(26, 13),
(9, 1),
(10, 2),
(15, 3),
(16, 4),
(17, 5),
(19, 6),
(18, 7),
(28, 8),
(41, 9),
(42, 10),
(39, 11),
(20, 12),
(30, 13),
(27, 4),
(29, 4),
(38, 10),
(37, 10),
(25, 13),
(24, 13);


INSERT INTO arzt
(pnr, fachgebiet)
VALUES
(8, 'Chirurgie'),
(4, 'Neurologie'),
(5, 'Innere Medizin'),
(14, 'Allgemeinmedizin'),
(12, 'Orthopaedie'),
(13, 'Anaesthesie'),
(35, 'Allgemeinmedizin'),
(40, 'Anaesthesie'),
(23, 'Orthopaedie'),
(43, 'Chirurgie'),
(33, 'Herzchirurgie'),
(34, 'HNO'),
(45, 'Allgemeinmedizin');

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
('Chris Meier','1954-05-08','m'),
('Janina Suppe','1982-04-15','w'),
('Jens Mokker','1965-03-29','m'),
('Lara Seibert','2018-02-28','w'),
('Bert Vogel','1963-01-09','m'),
('Sina Jung','1958-11-15','w'),
('Simon Wert','1990-08-07','m'),
('Jessica Schmitt','1974-09-15','w'),
('Lukas Poldi','1990-10-06','m'),
('Paula', '1994-07-13','w'),
('Melanie','1994-09-16','w'),
('Bettina','1998-11-03','w'),
('Felin','1999-09-02','w'),
('Martina','1994-04-01','w'),
('Rolland','1968-03-25','m'),
('Paul','1983-08-04','m'),
('Marc','1988-07-07','m'),
('Günter','1966-12-12','m'),
('Florian','1977-08-18','m'),
('Heidi Klum','1973-06-01','w'),
('Max Mustermann','1935-09-04','m'),
('Ute Mustermann','1999-03-07','w'),
('Muster Patient','1989-07-14','m'),
('Max Muster','1952-02-25','m'),
('Sophie Musterfrau','1987-01-19','w'),
('Lisa Baum','1979-10-07','m'),
('Carl Mustermensch','1953-12-27','m'),
('Bill Gates','1955-10-28','m'),
('Mark Zuckerberg','1984-05-14','m');


INSERT INTO medikament
(name, produzent, bestand, preis)
VALUES
(' Nasenspray b1', 'Bayer', 214, 80.95),
('nasenspray b2', 'Bayer', 50, 200.15),
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
('Betablocker', 'Bayer', 40, 10.00),
('Blutungshaemmer1', 'Bayer', 100, 3.00),
('Blutungshaemmer2', 'Bayer', 100, 3.00),
('Botox', 'Hexal', 10, 2.00),
('Boxa Gripal', 'Ratiopharm', 250, 2.00),
('Dolormin', 'Bayer', 123, 2.00),
('Fusspilzsalbe1', 'Hexal', 310, 3.00),
('Fusspilzsalbe12', 'Hexal', 310, 3.00),
('Geringungsmittel', 'Hexal', 100, 1.00),
('Geringungsmittel2', 'Hexal', 100, 1.00),
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

INSERT INTO eingwpatient
(patnr, stationid)
VALUES
(1,13),
(2,11),
(3,12),
(7,10),
(5,9),
(6,4),
(7,1),
(7,6),
(9,2),
(22,11),
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
(28,7),
(29,12),
(30,11),
(31,2),
(32,1),
(33,13),
(34,7),
(35,4);


INSERT INTO eingwpatient
(patnr, stationid, wann)
VALUES
(1,13, '2022-05-08'),
(37,8, '2022-05-07'),
(3,12, '2022-05-06'),
(39,9, '2022-05-05'),
(40,4, '2022-05-04'),
(3,12, '2022-05-08'),
(42,13, '2022-05-07'),
(43,6, '2022-05-06'),
(44,1, '2022-05-05'),
(45,2, '2022-05-04'),
(46,3, '2022-05-03'),
(47,11, '2022-05-03'),
(47,13, '2022-05-05'),
(47,10, '2022-05-08'),
(50,13, '2022-05-08');




INSERT INTO ident_mit
(name_1, name_2)
VALUES
('Iberogast', 'Insulin'),
('Gripostat C', 'Medikament4'),
(' Nasenspray b1', 'Medikament5'),
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
(1,12, now(), 'Hier steht ein Kommentar'),
(1,45, now(), 'Hier steht ein Kommentar'),
(2,35, now(), 'Hier steht ein Kommentar'),
(3,34, now(), 'Hier steht ein Kommentar'),
(4,8, now(), 'Hier steht ein Kommentar'),
(5,12, now(), 'Hier steht ein Kommentar'),
(6,13, now(), 'Hier steht ein Kommentar'),
(7,35, now(), 'Hier steht ein Kommentar'),
(8,13, now(), 'Hier steht ein Kommentar'),
(9,40, now(), 'Hier steht ein Kommentar'),
(10,8, now(), 'Hier steht ein Kommentar'),
(11,43, now(), 'Hier steht ein Kommentar'),
(12,23, now(), 'Hier steht ein Kommentar'),
(13,8, now(), 'Hier steht ein Kommentar'),
(14,23, now(), 'Hier steht ein Kommentar'),
(15,5, now(), 'Hier steht ein Kommentar'),
(16,33, now(), 'Hier steht ein Kommentar'),
(17,23, now(), 'Hier steht ein Kommentar'),
(18,13, now(), 'Hier steht ein Kommentar'),
(19,12, now(), 'Hier steht ein Kommentar'),
(20,14, now(), 'Hier steht ein Kommentar'),
(21,12, now(), 'Hier steht ein Kommentar'),
(22,4, now(), 'Hier steht ein Kommentar'),
(23,4, now(), 'Hier steht ein Kommentar'),
(24,40, now(), 'Hier steht ein Kommentar'),
(25,4, now(), 'Hier steht ein Kommentar'),
(26,13, now(), 'Hier steht ein Kommentar'),
(27,43, now(), 'Hier steht ein Kommentar'),
(28,12, now(), 'Hier steht ein Kommentar'),
(29,33, now(), 'Hier steht ein Kommentar'),
(30,4, now(), 'Hier steht ein Kommentar'),
(31,35, now(), 'Hier steht ein Kommentar'),
(32,35, now(), 'Hier steht ein Kommentar'),
(33,40, now(), 'Hier steht ein Kommentar'),
(34,14, now(), 'Hier steht ein Kommentar'),
(35,33, now(), 'Hier steht ein Kommentar'),
(36,5, now(), 'Hier steht ein Kommentar'),
(37,34, now(), 'Hier steht ein Kommentar'),
(38,14, now(), 'Hier steht ein Kommentar'),
(39,34, now(), 'Hier steht ein Kommentar'),
(40,5, now(), 'Hier steht ein Kommentar'),
(41,34, now(), 'Hier steht ein Kommentar'),
(42,8, now(), 'Hier steht ein Kommentar'),
(43,34, now(), 'Hier steht ein Kommentar'),
(44,34, now(), 'Hier steht ein Kommentar'),
(45,43, now(), 'Hier steht ein Kommentar'),
(46,34, now(), 'Hier steht ein Kommentar'),
(47,33, now(), 'Hier steht ein Kommentar'),
(48,13, now(), 'Hier steht ein Kommentar'),
(49,35, now(), 'Hier steht ein Kommentar'),
(50,33, now(), 'Hier steht ein Kommentar');

INSERT INTO verschreibt
(patnr, pnr, name, tagzeit, dauer, dosierung)
VALUES
(1,5, 'Wund Und Heil Salbe', '2019-07-12 20:20:42.607', '532:11:11', 9),
(2,23, 'Wund Und Heil Salbe', '2018-12-07 06:32:41.966', '401:19:19', 17),
(3,43, 'Geringungsmittel', '2017-10-15 13:15:45.725', '527:24:24', 46),
(4,34, 'Aspirin Complex', '2019-07-26 01:18:13.213', '493:7:7', 29),
(5,33, 'Medikament4', '2019-11-07 18:48:47.265', '547:15:15', 49),
(6,13, 'Aspirin', '2018-11-29 13:55:17.825', '224:14:14', 23),
(7,13, 'Viagra', '2018-06-29 20:25:55.381', '791:1:1', 25),
(8,23, 'Nasenspray', '2018-12-14 15:50:33.573', '411:22:22', 30),
(9,43, 'Boxa Gripal', '2019-07-15 06:26:20.872', '711:32:32', 44),
(10,14, 'Ibupropeth', '2018-04-03 18:58:55.198', '811:8:8', 19),
(11,5, 'Blutungshaemmer2', '2017-03-18 23:32:46.845', '592:52:52', 42),
(12,4, 'Serobentin', '2019-10-29 10:38:29.558', '144:15:15', 33),
(13,12, 'Insulin', '2017-12-16 23:22:15.113', '619:53:53', 22),
(14,43, 'Viagra', '2018-09-20 05:49:58.815', '239:35:35', 3),
(15,13, 'Serobentin', '2018-06-15 12:57:22.63', '783:31:31', 33),
(16,43, 'Dopanium', '2019-07-31 23:08:19.705', '361:29:29', 26),
(17,35, 'Wund Und Heil Salbe', '2019-07-15 22:33:29.119', '542:58:58', 45),
(18,5, 'Ritalin', '2018-03-26 16:29:27.954', '310:58:58', 6),
(19,12, 'Blutungshaemmer2', '2018-11-26 12:25:14.047', '8:49:49', 3),
(20,40, ' Nasenspray b1', '2018-09-06 21:47:04.433', '28:42:42', 43),
(21,8, 'Nasenspray', '2018-04-25 22:16:09.247', '461:57:57', 19),
(22,13, 'Nasentropfen', '2019-12-01 07:35:12.645', '126:6:6', 45),
(23,34, 'Aspirin', '2018-05-06 04:10:56.173', '745:49:49', 49),
(24,35, 'Antibabypille3', '2019-04-09 11:10:19.219', '385:44:44', 27),
(25,4, 'Betablocker', '2019-04-14 22:57:55.503', '593:1:1', 19),
(26,35, ' Nasenspray b1', '2019-03-30 12:30:37.879', '220:14:14', 31),
(27,5, 'Serobentin', '2019-07-21 07:47:59.653', '89:35:35', 14),
(28,4, 'Dolormin', '2019-12-02 23:42:23.583', '559:8:8', 11),
(29,13, 'Botox', '2019-04-26 00:33:53.942', '417:9:9', 32),
(30,43, 'nasenspray b2', '2019-11-17 12:48:14.547', '611:17:17', 40),
(31,5, 'Betablocker', '2019-03-01 22:47:58.213', '224:22:22', 27),
(32,43, 'Ohrtropfen', '2019-12-01 07:06:31.856', '539:32:32', 45),
(33,33, 'Iberogast', '2017-07-13 10:48:16.639', '536:24:24', 45),
(34,34, 'Gripostat C', '2018-04-09 02:36:30.693', '450:10:10', 38),
(35,35, 'Miakum', '2018-04-11 18:04:07.666', '454:46:46', 11),
(36,14, 'Sorium', '2019-05-18 03:07:20.78', '806:12:12', 21),
(37,13, 'Fusspilzsalbe12', '2017-07-14 11:22:14.509', '723:44:44', 14),
(38,13, 'Altriserium', '2018-09-04 10:12:10.255', '681:53:53', 27),
(39,12, 'Medikament4', '2019-01-24 06:56:40.672', '608:7:7', 43),
(40,35, 'Didextrotrin', '2017-08-17 18:11:52.068', '311:56:56', 43),
(41,40, 'Aspirin', '2018-05-30 23:35:36.129', '630:11:11', 3),
(42,8, 'Viagra', '2017-08-05 12:10:01.002', '1:11:11', 8),
(43,8, 'Botox', '2019-04-09 09:14:44.113', '822:3:3', 30),
(44,4, 'Nasenspray', '2017-12-10 13:31:24.067', '49:41:41', 22),
(45,14, 'nasenspray b2', '2019-12-06 18:59:32.326', '250:21:21', 9),
(46,5, 'Acc Acut 600', '2017-11-21 04:27:43.931', '136:45:45', 46),
(47,14, 'Antibabypille3', '2019-09-06 13:04:33.73', '639:4:4', 33),
(48,13, 'Nasenspray', '2018-06-24 22:38:44.673', '636:8:8', 37),
(49,33, 'Ibupropeth', '2018-07-18 07:34:46.037', '324:48:48', 27),
(50,5, 'Viagra', '2017-12-26 20:40:44.56', '732:24:24', 18),
(1,14, 'Botox', '2019-02-11 03:43:59.465', '639:54:54', 46),
(2,4, 'Dolormin', '2018-09-05 07:24:34.112', '390:55:55', 39),
(3,5, 'Placebo', '2017-11-04 02:25:40.398', '222:26:26', 48),
(4,4, 'Sinupret', '2017-03-17 12:15:14.843', '465:19:19', 5),
(5,40, 'Botox', '2019-07-26 09:50:57.067', '415:33:33', 25),
(6,4, 'Fusspilzsalbe12', '2019-03-08 17:08:10.691', '231:45:45', 18),
(7,12, 'Aspirin Complex', '2019-04-01 16:21:27.118', '193:42:42', 40),
(8,4, 'Maltrodextrin', '2017-02-15 18:55:12.026', '12:9:9', 38),
(9,34, ' Nasenspray b1', '2018-03-06 02:31:09.323', '210:55:55', 36),
(10,33, 'Viagra', '2019-06-22 18:43:05.54', '228:17:17', 19),
(11,35, 'Placebo', '2017-06-02 07:54:33.355', '154:45:45', 9),
(12,33, 'Antidoxin', '2018-07-07 13:20:00.438', '318:38:38', 34),
(13,34, 'Fusspilzsalbe12', '2017-08-20 13:07:51.819', '651:8:8', 22),
(14,33, 'Aspirin', '2017-06-21 11:11:45.139', '513:37:37', 13),
(15,35, 'Sorium', '2019-11-12 15:48:09.694', '797:53:53', 47),
(16,43, 'Geringungsmittel2', '2019-10-23 06:42:33.996', '607:21:21', 30),
(17,12, 'Medikament3', '2017-05-16 02:42:39.325', '240:11:11', 25),
(18,4, ' Nasenspray b1', '2019-09-27 00:48:34.882', '596:0:0', 25),
(19,4, 'Iberogast', '2018-12-08 17:02:30.216', '225:6:6', 15),
(20,34, ' Nasenspray b1', '2017-09-29 14:11:32.283', '159:31:31', 29),
(21,40, 'Altriserium', '2019-01-25 13:48:28.973', '182:30:30', 45),
(22,5, 'Aspirin', '2018-04-30 21:12:44.8', '365:21:21', 34),
(23,33, 'Sinupret', '2018-03-28 16:26:48.292', '94:25:25', 4),
(24,35, 'Insulin', '2018-08-05 17:47:14.156', '781:50:50', 21),
(25,8, 'Blutungshaemmer2', '2018-02-18 10:29:37.833', '438:25:25', 7),
(26,12, 'Dopanium', '2018-07-17 14:02:18.969', '410:44:44', 10),
(27,34, 'Wund Und Heil Salbe', '2018-06-28 10:40:48.223', '12:50:50', 43),
(28,34, 'Thomapirn', '2017-02-22 05:07:21.81', '323:58:58', 25),
(29,8, 'Sorium', '2017-04-26 18:27:38.402', '223:0:0', 9),
(30,8, 'Antidoxin', '2019-02-17 20:12:17.864', '612:2:2', 22),
(31,5, 'nasenspray b2', '2017-03-24 05:27:48.88', '261:42:42', 22),
(32,4, 'Sergos', '2019-03-13 05:18:42.285', '157:4:4', 35),
(33,40, 'Nasentropfen', '2018-12-24 08:41:11.258', '680:40:40', 6),
(34,4, ' Nasenspray b1', '2018-02-11 04:39:27.994', '807:51:51', 37),
(35,13, 'Fusspilzsalbe1', '2017-07-07 06:18:07.493', '790:42:42', 42),
(36,33, 'Medikament5', '2017-09-28 13:36:12.344', '2:28:28', 2),
(37,43, 'Antibabypille3', '2019-10-29 06:52:50.379', '535:1:1', 34),
(38,23, 'Blutungshaemmer1', '2019-07-31 19:48:06.73', '162:27:27', 10),
(39,34, 'Schlafmittel', '2017-07-16 13:53:39.87', '339:5:5', 36),
(40,34, 'Thomapirn', '2019-03-21 08:11:54.697', '473:7:7', 39),
(41,4, 'Insulin', '2019-01-17 12:55:32.932', '343:46:46', 6),
(42,43, 'Medikament5', '2018-02-27 13:40:50.262', '38:32:32', 23),
(43,40, 'Sergos', '2017-07-17 00:31:11.852', '251:41:41', 4),
(44,12, 'Iberogast', '2019-06-11 04:32:15.097', '779:19:19', 16),
(45,12, 'Kopfschmerzmittel', '2019-10-03 00:45:20.991', '238:13:13', 2),
(46,35, 'Medikament5', '2019-11-26 14:00:43.934', '391:57:57', 3),
(47,23, 'Sergos', '2019-12-10 21:04:49.951', '524:54:54', 7),
(48,8, 'Geringungsmittel', '2018-11-24 03:31:42.93', '134:28:28', 48),
(49,8, 'Serobentin', '2019-07-22 09:37:11.34', '443:2:2', 7),
(50,33, 'Sorium', '2017-04-25 11:30:11.547', '352:25:25', 4),
(1,4, 'Aspirin Complex', '2019-12-02 23:15:41.432', '561:14:14', 4),
(2,14, 'Placebo', '2017-06-20 13:39:04.805', '93:25:25', 5),
(3,23, 'Antibabypille3', '2019-12-21 17:37:35.497', '277:3:3', 4),
(4,8, 'Geringungsmittel', '2017-08-26 02:15:50.723', '107:38:38', 33),
(5,35, 'Ritalin', '2018-06-08 18:03:04.015', '335:34:34', 23),
(6,4, 'Dolormin', '2017-03-19 01:17:07.05', '484:57:57', 29),
(7,14, 'Sorium', '2019-10-09 13:28:53.898', '286:31:31', 40),
(8,5, 'Placebo', '2018-07-13 13:55:03.943', '199:15:15', 5),
(9,34, 'Antidoxin', '2018-02-24 19:52:28.723', '263:47:47', 12),
(10,8, 'Medikament4', '2018-09-27 13:29:35.665', '274:29:29', 20),
(11,33, 'Medikament5', '2018-06-28 02:28:00.946', '678:23:23', 33),
(12,40, 'Viagra', '2018-07-21 10:46:58.342', '113:16:16', 17),
(13,34, 'Ohrtropfen', '2019-11-16 15:32:09.381', '477:17:17', 43),
(14,5, 'Dolormin', '2019-11-16 14:10:06.242', '319:10:10', 47),
(15,23, 'Meditonsin', '2018-02-26 07:58:16.072', '687:5:5', 5),
(16,14, 'Nasentropfen', '2017-10-06 13:45:08.773', '525:17:17', 39),
(17,40, 'Medikament3', '2019-07-18 07:38:19.875', '192:19:19', 20),
(18,14, 'Ritalin', '2019-03-11 18:31:33.352', '339:23:23', 47),
(19,40, 'Meditonsin', '2019-04-01 19:43:08.126', '163:55:55', 8),
(20,40, 'Aspirin', '2017-08-05 01:50:32.678', '60:22:22', 50),
(21,43, ' Nasenspray b1', '2019-12-31 01:19:29.092', '251:28:28', 38),
(22,40, 'Fusspilzsalbe1', '2019-02-21 05:27:10.348', '700:10:10', 1),
(23,35, 'Aspirin Complex', '2019-09-06 03:37:34.388', '270:41:41', 15),
(24,14, ' Nasenspray b1', '2019-11-24 14:40:37.238', '110:24:24', 43),
(25,43, 'Ohrtropfen', '2017-09-05 09:53:01.486', '486:29:29', 9),
(26,34, 'Kopfschmerzmittel', '2019-08-23 18:03:53.629', '268:50:50', 43),
(27,40, 'Sorium', '2019-07-29 20:28:27.819', '251:1:1', 24),
(28,34, 'Antidoxin', '2017-05-18 19:49:21.154', '353:14:14', 42),
(29,43, 'Aspirin', '2018-10-13 09:53:21.945', '88:33:33', 42),
(30,40, 'Thomapirn', '2019-11-25 16:37:55.972', '475:57:57', 27),
(31,5, 'Insulin', '2019-08-16 23:11:33.316', '52:1:1', 40),
(32,12, 'Antibabypille2', '2019-11-14 01:20:07.233', '721:43:43', 21),
(33,23, 'Medikament4', '2017-06-10 22:36:12.029', '563:26:26', 14),
(34,43, 'Sorium', '2018-07-12 04:47:09.871', '276:13:13', 19),
(35,34, 'Ritalin', '2019-06-30 05:20:03.984', '226:34:34', 38),
(36,23, 'Antibabypille2', '2017-06-10 20:14:35.231', '484:9:9', 48),
(37,33, 'Antidoxin', '2019-12-29 17:51:53.64', '484:25:25', 44),
(38,5, 'Viagra', '2019-09-08 06:50:00.057', '397:57:57', 31),
(39,5, 'Viagra', '2018-12-06 19:20:14.402', '10:45:45', 22),
(40,13, 'Ohrtropfen', '2017-03-10 10:15:32.935', '451:29:29', 44),
(41,23, 'Blutungshaemmer1', '2017-02-08 00:16:15.298', '670:7:7', 49),
(42,13, 'Fusspilzsalbe12', '2017-12-23 18:15:11.244', '827:15:15', 21),
(43,35, 'Miakum', '2017-09-02 21:26:45.716', '801:4:4', 11),
(44,40, 'Medikament3', '2017-08-11 16:51:18.768', '165:2:2', 15),
(45,34, 'Meditonsin', '2018-10-10 05:22:39.312', '309:9:9', 19),
(46,33, 'Thomapirn', '2019-03-20 17:53:23.627', '216:55:55', 31),
(47,14, 'Altriserium', '2018-02-08 23:40:19.076', '638:57:57', 46),
(48,35, 'Didextrotrin', '2017-04-07 23:55:24.155', '799:42:42', 30),
(49,12, 'Fusspilzsalbe12', '2019-10-06 01:47:48.608', '399:42:42', 39),
(50,5, 'Nasenspray', '2019-12-14 12:04:13.134', '691:44:44', 38);




