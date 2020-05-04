select f1.field_value as author_name, count(*) as pub_count
from field f, field f1
where f.field_name = 'journal'
	and f1.field_name = 'author'
	and f.field_value like 'IEEE%'
	and f1.pub_key = f.pub_key 
group by f1.field_value 
order by pub_count desc, author_name
limit 50;


