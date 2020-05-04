--I created this temp table to save the years between 2021-2030 and
--it's count as zero.

create temporary table tmp_years(years int, cnt int);

insert into tmp_years(years, cnt)
select p.year, count(*)
from publication p
group by p.year;

insert into tmp_years(years, cnt)
values(2021,0),(2022,0);

insert into tmp_years(years, cnt)
values(2023,0),(2024,0),(2025,0),(2026,0),(2027,0),(2028,0),(2029,0);

select concat(t1.years, '-', t10.years+1) as decade, 
t1.cnt+t2.cnt+t3.cnt+t4.cnt+t5.cnt+t6.cnt+t7.cnt+t8.cnt+t9.cnt+t10.cnt as total
from tmp_years t1,
	tmp_years t2,
	tmp_years t3,
	tmp_years t4,
	tmp_years t5,
	tmp_years t6,
	tmp_years t7,
	tmp_years t8,
	tmp_years t9,
	tmp_years t10
where 
	t1.years >= 1940
	and t1.years + 1 = t2.years
	and t1.years + 2 = t3.years
	and t1.years + 3 = t4.years
	and t1.years + 4 = t5.years
	and t1.years + 5 = t6.years
	and t1.years + 6 = t7.years
	and t1.years + 7 = t8.years
	and t1.years + 8 = t9.years
	and t1.years + 9 = t10.years;




