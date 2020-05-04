create table if not exists ActiveAuthors(name text);

insert into ActiveAuthors(name)
select distinct a.name
from author a, publication p, authored au
where a.author_id = au.author_id
	and au.pub_id = p.pub_id
	and p.year in (2018,2019,2020);


create or replace function check_active()
returns trigger as 
$BODY$
BEGIN
         insert into activeAuthors(name)
         select a.name
         from author a
         where a.author_id = NEW.author_id 
         			and NEW.pub_id in (select p.pub_id from publication p where p.year >= 2018 )
    				and a.name not in (select name from activeAuthors);
         RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';
 
CREATE trigger newActiveAuthors 
  AFTER INSERT
  ON Authored
  FOR EACH ROW
  EXECUTE PROCEDURE check_active();
  

