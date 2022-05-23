/*%%%%head%%{"type":"submission","name":"Blatt 1","authors":[["Leo Steiner","s3819219@stud.uni-frankfurt.de","7906565"]]}%%*/
/*%%1a%%*/
/* a) Erstellen Sie eine Tabelle mit dem Namen mitarbeiter, welche folgende 
Attribute enthält: id, name, vorname, gehalt.Tabellennamen werden normalerweise 
immer in Kleinbuchstaben erstellt. Wir verwenden ebenfalls Kleinbuchstaben für 
alle Attribute. Dies dient vor allem dafür Fehler zu vermeiden, da die Relevanz 
der Schreibweise der Attribute neben den Einstellungen auch vom Betriebssystem abhängt. */

create table mitarbeiter(
	id int,
    name varchar(32),
    vorname varchar(32),
    gehalt decimal(6,2)
);

/*%%1b%%*/
/* b) Fügen Sie drei Datensätze in die Tabelle mitarbeiter ein (als ein Statement!). 
Das Gehalt der eingefügten Mitarbeiter soll dabei „null“ sein, also keinen Wert enthalten */

insert into mitarbeiter (id,name, vorname, gehalt)
values
(1,'mustermann1','max1',null),
(2,'mustermann2','max2',null),
(3,'mustermann3','max3',null);


/*%%1c%%*/
/* c) Geben Sie für alle Datensätze der Tabelle station die Attribute: id, anzahlbetten aus. */

select id, anzahlbetten from station;


/*%%1d%%*/
/* d) Geben Sie alle Datensätze der Tabelle station aus, die weniger als 10 Betten haben. 
Ausgegeben werden sollen die Attribute: id, name, anzahlbetten. */

select * from station where station.anzahlbetten <10;

/*%%1e%%*/
/* e) Fügen Sie drei Datensätze in die Tabelle arbeitet_in ein (als ein Statement!) */


insert into arbeitet_in (mitarbeiter_id, station_id)
values
('1','2'),
('2','2'),
('3','2');
