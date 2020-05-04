create table if not exists Author (author_id serial primary key, name text);
create table if not exists Publication (pub_id serial primary key, pub_key text, title text, year int);
create table if not exists Article (pub_id int primary key, journal text, month text, volume text, number text);
create table if not exists Book (pub_id int primary key, publisher text, isbn text);
create table if not exists Incollection (pub_id int primary key, book_title text, publisher text, isbn text);
create table if not exists Inproceedings (pub_id int primary key, book_title text, editor text);
create table if not exists Authored (author_id int, pub_id int);

insert into Author(name)
select distinct f.field_value from field f
where f.field_name = 'author';


insert into Publication(pub_key,title,year)
select distinct f.pub_key, f.field_value, cast(f1.field_value as int) from field f, field f1
where f.field_name in('title','year' )
	and f.pub_key = f1.pub_key
	and f.field_name = 'title'
	and f1.field_name = 'year';

insert into Article(pub_id, journal, month, volume, number)
select p1.pub_id, f.field_value as jnl, f1.field_value as mnth, f2.field_value as vol, f3.field_value as num
from Publication p1, pub p
left join field f
on p.pub_key = f.pub_key
	and f.field_name = 'journal'
left join field f1
on p.pub_key = f1.pub_key
	and f1.field_name = 'month'
left join field f2
on p.pub_key = f2.pub_key
	and f2.field_name = 'volume'
left join field f3
on p.pub_key = f3.pub_key
	and f3.field_name = 'number'
where
	p1.pub_key = p.pub_key
	and p.pub_type = 'article';


insert into Book(pub_id, publisher, isbn)
select p1.pub_id,  f.field_value as pbl, max(f1.field_value) as isbn 
from Publication p1, pub p
left join field f
on p.pub_key = f.pub_key
	and f.field_name = 'publisher'
left join field f1
on p.pub_key = f1.pub_key
	and f1.field_name = 'isbn'
where
	p1.pub_key = p.pub_key
	and p.pub_type = 'book'
group by p1.pub_id, pbl;

insert into Incollection(pub_id, book_title, publisher, isbn)
select p1.pub_id, f.field_value as booktit, f1.field_value as pbl, max(f2.field_value) as isbn 
from Publication p1, pub p
left join field f
on p.pub_key = f.pub_key
	and f.field_name = 'booktitle'
left join field f1
on p.pub_key = f1.pub_key
	and f1.field_name = 'publisher'
left join field f2
on p.pub_key = f2.pub_key
	and f1.field_name = 'isbn'
where
	p1.pub_key = p.pub_key
	and p.pub_type = 'incollection'
group by p1.pub_id, booktit, pbl;

insert into Inproceedings(pub_id, book_title, editor)
select p1.pub_id, f.field_value as booktit, f1.field_value as edtr
from Publication p1, pub p
left join field f
on p.pub_key = f.pub_key
	and f.field_name = 'booktitle'
left join field f1
on p.pub_key = f1.pub_key
	and f1.field_name = 'editor'
where
	p1.pub_key = p.pub_key
	and p.pub_type = 'inproceedings'
group by p1.pub_id, booktit, edtr;

insert into Authored(author_id, pub_id)
select a.author_id, p.pub_id
from Author a, publication p, field f
where p.pub_key = f.pub_key 
	and f.field_name = 'author'
	and f.field_value = a.name

