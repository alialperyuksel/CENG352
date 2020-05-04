(select f.field_name 
from pub p, field f 
where p.pub_key = f.pub_key 
	and p.pub_type = 'article'
order by f.field_name )
intersect 
(select f.field_name 
from pub p, field f 
where p.pub_key = f.pub_key 
	and p.pub_type = 'incollection'
order by f.field_name)
intersect 
(select f.field_name 
from pub p, field f 
where p.pub_key = f.pub_key 
	and p.pub_type = 'inproceedings'
order by f.field_name)
intersect 
(select f.field_name 
from pub p, field f 
where p.pub_key = f.pub_key 
	and p.pub_type = 'proceedings'
order by f.field_name)
intersect 
(select f.field_name 
from pub p, field f 
where p.pub_key = f.pub_key 
	and p.pub_type = 'book'
order by f.field_name )
intersect 
(select f.field_name 
from pub p, field f 
where p.pub_key = f.pub_key 
	and p.pub_type = 'www'
order by f.field_name)
intersect 
(select f.field_name 
from pub p, field f 
where p.pub_key = f.pub_key 
	and p.pub_type = 'mastersthesis'
order by f.field_name);







