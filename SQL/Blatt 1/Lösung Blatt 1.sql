create table mitarbeiter(
	id int,
    name varchar(32),
    vorname varchar(32),
    gehalt decimal
);

insert into mitarbeiter (id,name, vorname, gehalt)
values
(1,'mustermann1','max1',null),
(2,'mustermann2','max2',null),
(3,'mustermann3','max3',null);

select id, anzahlbetten from station;

select * from station where station.anzahlbetten <10;

insert into arbeitet_in (mitarbeiter_id, station_id)
values
('1','2'),
('2','2'),
('3','2');