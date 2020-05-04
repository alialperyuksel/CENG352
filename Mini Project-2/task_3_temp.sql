--I created this temp table to save the years between 2021-2030 and
--it's count as zero. (task_3_4)

create temporary table tmp_years(years int, cnt int);

insert into tmp_years(years, cnt)
select p.year, count(*)
from publication p
group by p.year;

insert into tmp_years(years, cnt)
values(2021,0),(2022,0);

insert into tmp_years(years, cnt)
values(2023,0),(2024,0),(2025,0),(2026,0),(2027,0),(2028,0),(2029,0);

--I created this temp table to count collaborations on multiple publications
-- as 1. (task_3_5)

create temporary table author_match(author1 int, author2 int, cnt int);

insert into author_match(author1,author2, cnt)
select au1.author_id, au2.author_id, count(*)
from authored au1, authored au2
where au2.pub_id = au1.pub_id
	and au1.author_id != au2.author_id
group by au1.author_id, au2.author_id;

update author_match
set cnt = 1;

