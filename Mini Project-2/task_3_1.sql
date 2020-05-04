select table1.names as author_name, table1.cnt as pub_count
from 
(
select a.name as names, count(*) as cnt
from author a, authored au
where a.author_id = au.author_id
group by a.author_id
) as table1
where cnt >= 150 and cnt < 200
order by cnt, names;