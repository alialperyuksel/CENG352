select table1.name, table1.pub_count
from
(
	select ff1.field_value as name , count(*) as pub_count
	from 
	(
		(select f2.field_value as ff 
		from field f, field f2
		where f.field_name = 'journal'
			and f.field_value = 'IEEE Trans. Wireless Communications'
			and f2.field_name = 'author'
			and f.pub_key = f2.pub_key 
		group by f2.field_value)
		except 
		(select f2.field_value as ff 
		from field f, field f2
		where f.field_name = 'journal'
			and f.field_value = 'IEEE Wireless Commun. Letters'
			and f2.field_name = 'author'
			and f.pub_key = f2.pub_key 
		group by f2.field_value)
	) as tb1, field f1, field ff1
	where f1.field_name = 'journal'
			and f1.field_value = 'IEEE Trans. Wireless Communications'
			and ff1.field_name = 'author'
			and f1.pub_key = ff1.pub_key
			and tb1.ff = ff1.field_value 
	group by ff1.field_value
) as table1
where
	table1.pub_count >= 10
order by table1.pub_count desc, table1.name;

