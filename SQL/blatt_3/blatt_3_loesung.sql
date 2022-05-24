	/*%%%%head%%{"type":"submission","name":"blatt3","authors":[["Leo Steiner","s3819219@stud.uni-frankfurt.de","7906565"]]}%%*/
/*%%1a%%*/
/* a) */ 
select name, produzent, preis from medikament where name like 'Anti%'
/* where binary for case sensitivity */

/*%%1b%%*/
/* b) */ 
select pnr, name from mitarbeiter where trim(name) like '_% _% %_';
/* trim removes leading and trailing spaces */
/* _% makes sure that there is at least on character */


/*%%1c%%*/
/* c) */ 
select produzent as  Hersteller, count(produzent) as Anzahl, ceil(avg (preis)) as Durchschnittspreis from medikament group by produzent order by Anzahl desc, Durchschnittspreis desc;
/* slicker:  count(*) instead of count(Produzent) etc...*/


/*%%1d%%*/
/* d) */ 
select fachgebiet, count(fachgebiet) from arzt, mitarbeiter where arzt.pnr = mitarbeiter.pnr and mitarbeiter.gebdat >'1970-01-01' group by arzt.fachgebiet having count(fachgebiet)>1;
/* slicker:  just select fachgebiet, count(*) etc...*/



/*%%1e%%*/
/* e) */ 
select eingwpatient.patnr, patient.name, eingwpatient.stationid, station.name from eingwpatient, patient, station where eingwpatient.patnr = patient.patnr and eingwpatient.stationid = station.stationid and station.stationid <3 order by station.stationid desc, eingwpatient.patnr asc;




/*%%1f%%*/
/* f) */
select eingwpatient.patnr, patient.name, eingwpatient.stationid, station.name, eingwpatient.wann  from eingwpatient, station, patient  where eingwpatient.patnr = patient.patnr and eingwpatient.stationid = station.stationid and station.stationid >=3 and eingwpatient.patnr in (select eingwpatient.patnr from eingwpatient, patient, station where station.stationid <3 and eingwpatient.patnr = patient.patnr and eingwpatient.stationid = station.stationid);
/* note that the from statement in the where-in clause needs to include all tables necessary for the following nested where condition. otherwise result will be empty*/


/*%%1g%%*/
/* g) */ 
select m1.pnr, group_concat(m2.pnr order by m2.pnr) as gleicherGeburtstagWie from mitarbeiter m1, mitarbeiter m2 where (month(m1.gebdat) = month(m2.gebdat) and dayofmonth(m1.gebdat) = dayofmonth(m2.gebdat)) and m1.pnr <> m2.pnr group by m1.pnr having count(*) > 1 order by m1.pnr;
/* */

