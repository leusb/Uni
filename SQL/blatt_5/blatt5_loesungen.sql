/*%%%%head%%{"type":"template","name":"blatt5"}%%*/
/*%%1a%%*/
/* a) */
select name, produzent, preis 
from medikament
where name like '%mittel%' and name not like '%kopf%'
order by preis desc;

/*%%1b%%*/
/* b) */

select mitarbeiter.pnr, mitarbeiter.name 
from mitarbeiter, arzt
where 
	mitarbeiter.pnr = arzt.pnr and 
	arzt.pnr not in (select pfleger.pnr from pfleger) and
	(binary mitarbeiter.name like 'A%' or binary mitarbeiter.name like 'L%');
/* !! most important part here are the paranthesis around the two like operators. otherwise it wont work*/


/*%%1c%%*/
/* c) */

select name, bestand
from medikament
where binary name like 'B%' and
medikament.name not in (select name_1 from ident_mit) and
medikament.name not in (select name_2 from ident_mit);


/*%%1d%%*/
/* d) */

select produzent, sum(bestand*preis) as Warenwert
from medikament
group by produzent
order by warenwert desc
limit 5;


/*%%1e%%*/
/* e) */
select betreut.pnr, mitarbeiter.name
from betreut, mitarbeiter
where 
betreut.pnr = mitarbeiter.pnr and 
betreut.pnr in (select arzt.pnr from arzt) and 
betreut.pnr not in (select pfleger.pnr from pfleger)
group by betreut.pnr
having count(betreut.pnr) >1;

/*%%1f%%*/
/* f) */

select verschreibt.name, medikament.produzent, count(month(tagzeit)) as Verschreibungsanzahl, date_format(verschreibt.tagzeit, '%M %Y') as Wann
from verschreibt, medikament
where verschreibt.name = medikament.name
group by month(verschreibt.tagzeit),year(verschreibt.tagzeit), verschreibt.name
having count(month(verschreibt.tagzeit))>1;


/*%%2a%%*/
/* 2a) */
update mitarbeiter
set ort = "Frankfurt (Oder)"
where ort = "Frankfurt" and (plz = 15230 or plz = 15232 or plz = 15234 or plz = 15236);

/*%%2b%%*/
/* 2b) */
update medikament
set preis = preis + 3
where produzent = "bayer" and preis >= 10.00;

/*%%2c%%*/
/* 2c) */
alter table arzt
	add column mobile varchar(20) after pnr;

/* Anmerkung: Als Datentyp habe ich hier varchar gewählt, da zB bei der Länderkennung von Mobilnummern ein "+" in der Nummer auftauchen kann
Int als Datentyp wäre somit die Falsche Wahl. Auch die Länge lässt sich kürzer fassen. So darf eine natioanle Mobilfunknummer nicht länger als
13 Zeichen und Internationale nicht länger als 15 Zeichen sein. 
(Quelle Bundesnetzagentur: https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Nummerierung/Rufnummern/NP_Nummernraum.pdf?__blob=publicationFile&v=4) 
Ich habe 20 gewählt, da möglicherweise bindestriche oder zusätzliche Leerezeichen
eingetragen werden könnten   */
    
