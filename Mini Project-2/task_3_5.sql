--I created this temp table to count collaborations on multiple publications
-- as 1.

create temporary table author_match(author1 int, author2 int, cnt int);

insert into author_match(author1,author2, cnt)
select au1.author_id, au2.author_id, count(*)
from authored au1, authored au2
where au2.pub_id = au1.pub_id
	and au1.author_id != au2.author_id
group by au1.author_id, au2.author_id;

update author_match
set cnt = 1;


select a.name as name, count(*) as collab_count
from author_match, author a
	where 
		author_match.author1 = a.author_id
group by a.name
order by collab_count desc, a.name
limit 1000;





