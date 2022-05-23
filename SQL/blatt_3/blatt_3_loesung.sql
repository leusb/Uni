/*%%%%head%%{"type":"submission","name":"blatt3","authors":[["Leo Steiner","s3819219@stud.uni-frankfurt.de","7906565"]]}%%*/
/*%%1a%%*/
/* a) */ select name, produzent, preis from medikament where name like 'Anti%'
/* where binary for case sensitivity */

/*%%1b%%*/
/* b) */ select pnr, name from mitarbeiter where trim(name) like '_% _% %_';
/* trim removes leading and trailing spaces */
/* _% makes sure that there is at least on character */


/*%%1c%%*/
/* c) */ select produzent as  Hersteller, count(produzent) as Anzahl, ceil(avg (preis)) as Durchschnittspreis from medikament group by produzent order by Anzahl desc, Durchschnittspreis desc;
/* slicker:  count(*) instead of count(Produzent) etc...*/


/*%%1d%%*/
/* d) */ select fachgebiet, count(fachgebiet) from arzt, mitarbeiter where arzt.pnr = mitarbeiter.pnr and mitarbeiter.gebdat >'1970-01-01' group by arzt.fachgebiet having count(fachgebiet)>1;
/* slicker:  just select fachgebiet, count(*) etc...*/



/*%%1e%%*/
/* e) */ select eingwpatient.patnr, patient.name, eingwpatient.stationid, station.name from eingwpatient, patient, station where eingwpatient.patnr = patient.patnr and eingwpatient.stationid = station.stationid and station.stationid <3 order by station.stationid desc, eingwpatient.patnr asc;




/*%%1f%%*/
/* f) */
select eingwpatient.patnr, patient.name, eingwpatient.stationid, station.name, eingwpatient.wann  from eingwpatient, station, patient  where eingwpatient.patnr = patient.patnr and eingwpatient.stationid = station.stationid and station.stationid >=3 and eingwpatient.patnr in (select eingwpatient.patnr from eingwpatient, patient, station where station.stationid <3 and eingwpatient.patnr = patient.patnr and eingwpatient.stationid = station.stationid);
/* note that the from statement in the where-in clause needs to include all tables necessary for the following nested where condition. otherwise result will be empty*/


/*%%1g%%*/
/* g) */ select name, gebdat, pnr  from mitarbeiter where date_format(gebdat, '%m-%d') in (select date_format(gebdat, '%m-%d') from mitarbeiter group by gebdat having count(gebdat)>2) order by pnr asc;
/* ich konnte bereits die richtigen Daten mit einem select statement finden. Allerdings schaffe ich es in der Kürze der Zeit leider nicht mehr, die pnr werte jeweils noch in die spalte gleicherGeburtstag Wie zu bringen. Vielleicht gibt es ja für das finden der richtigen Werte Teilpunkte... :)*/