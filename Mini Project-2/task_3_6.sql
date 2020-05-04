select table1.year as year, table1.name as name, table2.cnt2 as count
from 
(
	select a.name as name, p.year as year, count(*) as cnt
	from author a, authored au, publication p
	where 
		a.author_id = au.author_id
		and au.pub_id = p.pub_id
		and p.year >= 1940 and p.year < 1991
	group by a.name, p.year
	order by p.year, cnt desc
	) as table1,
(
	select tb1.year as year2,  max(cnt) as cnt2
	from 
	(
		select a.name as name, p.year as year, count(*) as cnt
		from author a, authored au, publication p
		where 
			a.author_id = au.author_id
			and au.pub_id = p.pub_id
			and p.year >= 1940 and p.year < 1991
		group by a.name, p.year
		order by p.year, cnt desc
	) as tb1
	group by tb1.year
	order by tb1.year, cnt2 desc
) as table2
where 
	table1.year = table2.year2
	and table1.cnt = table2.cnt2
order by table1.year, table1.name;