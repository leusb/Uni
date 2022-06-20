/*%%%%head%%{"type":"template","name":"blatt5"}%%*/
/*%%1a%%*/
/* a) */
select name, produzent, preis 
from medikament
where produzent = ("Hexal" or "Bayer") and
name like '%mittel%' and name not like '%kopf%'
order by preis desc;
/* alternativ: where produzent in ('Hexal', 'Bayer') and  */


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
where produzent = "Bayer" and preis >= 10.00;
/* alternativ: where produzent like 'Bayer */

/*%%2c%%*/
/* 2c) */
alter table arzt
	add column mobile varchar(20) after pnr;
    
