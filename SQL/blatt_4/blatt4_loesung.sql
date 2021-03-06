/*%%%%head%%{"type":"template","name":"blatt4"}%%*/
/*%%1a%%*/
/* a) */
create view eingewiesene_patienten as
select eingwpatient.patnr, patient.name, eingwpatient.stationid, station.name as stations_name, eingwpatient.wann, station.anzahlbetten 
from eingwpatient, patient, station where eingwpatient.patnr = patient.patnr and eingwpatient.stationid = station.stationid
order by stationid;

/*%%1b%%*/
/* b) */

create view medikament_vergleich as
select m.name, m.produzent, m.bestand, m.preis, alt.name_alternativ, alt.produzent_alternativ, alt.bestand_alternativ, alt.preis_alternativ
from medikament m,
(select 
	ident_mit.name_1,
    medikament.name as name_alternativ, 
	medikament.produzent as produzent_alternativ, 
    medikament.bestand as bestand_alternativ,
    medikament.preis as preis_alternativ
from medikament, ident_mit
where ident_mit.name_2 = medikament.name) alt
where m.name = alt.name_1;

 
 
/*%%1c%%*/
/* c) */
create view arzt_patient as
select 
	betreut.pnr, 
    mitarbeiter.name as arzt_name, 
    arzt.fachgebiet, 
    betreut.tagzeit, 
    betreut.patnr, 
    patient.name as patienten_name
from betreut, mitarbeiter, arzt, patient
where 
	mitarbeiter.pnr = betreut.pnr and 
	arzt.pnr = mitarbeiter.pnr and 
	patient.patnr = betreut.patnr;



/*%%2a%%*/
/* a) */

select pnr, count(*) as Anzahl
from betreut
group by pnr
having Anzahl >=2;

/*%%2b%%*/
/* b) */

select name, produzent, preis, name_alternativ, produzent_alternativ, preis_alternativ, (preis - preis_alternativ) as Ersparnis
from medikament_vergleich
having preis_alternativ < preis
order by Ersparnis desc;

/*%%2c%%*/
/* c) */

select stationid, stations_name, anzahlbetten, (count(stations_name)/anzahlbetten) as Auslastung 
from eingewiesene_patienten 
group by stationid
having Auslastung > 0.35;

/*%%2d%%*/ 
/* d) */
select 
	alt.name, 
    alt.name_alternativ, 
    verschreibt.pnr, 
    verschreibt.patnr, 
    verschreibt.dosierung,
    (preis - preis_alternativ) as Preisunterschied,
    ((preis - preis_alternativ) * dosierung) as Ersparnis
from medikament_vergleich alt, verschreibt
where 
preis > preis_alternativ and 
verschreibt.name = alt.name;




