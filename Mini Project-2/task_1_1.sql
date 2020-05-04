select p.pub_type, count(*) as cnt 
from pub p 
group by p.pub_type
order by cnt desc;

