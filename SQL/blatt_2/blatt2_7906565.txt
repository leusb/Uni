/*%%%%head%%{"type":"submission","name":"blatt2","authors":[["Leo Steiner","s3819219@stud.uni-frankfurt.de","7906565"]]}%%*/
/*%%1a%%*/
/* a) */select pnr, geschlecht from mitarbeiter where geschlecht="w" && gebdat>'1900-01-01';

/*%%1b%%*/
/* b) */select unique plz from mitarbeiter where geschlecht="w" && gebdat>'1900-01-01';

/*%%1c%%*/
/* c) */select pnr from pfleger where stationid in (select stationid from station where name = 'Chirurgie');


/*%%1d%%*/
/* d) */ select pfleger.pnr, mitarbeiter.name from pfleger inner join mitarbeiter on pfleger.pnr=mitarbeiter.pnr where mitarbeiter.ort = 'London';  

/*%%1e%%*/
/* e) */select min(preis) as 'niedrigste Preis' from medikament;

/*%%1f%%*/
/* f) */select name, preis from medikament where preis in(select min(preis) from medikament);

/*%%1g%%*/
/* g) */select produzent, name from medikament where preis > 2*(select avg(preis) from medikament);

/*%%1h%%*/
/* h) */select unique diagnostiziert.fachname from diagnostiziert inner join arzt on diagnostiziert.pnr=arzt.pnr;

/*%%1i%%*/
/* i) */ select mitarbeiter.pnr, mitarbeiter.name from mitarbeiter where mitarbeiter.pnr in (select arzt.pnr from arzt where arzt.pnr in(select pfleger.pnr from pfleger));
