select tmp2.plane_tail_number, tmp2.year, tmp2.xxx as daily_avg
from (select tmp.plane_tail_number, tmp.year, avg(ccc2) as xxx
		from (select fr3.year ,fr3.plane_tail_number, count(fr3.is_cancelled ) as ccc2
				from flight_reports fr3 
				where fr3.is_cancelled != 1 
				group by fr3.plane_tail_number ,  fr3.day, fr3.year 
				order by fr3.day, fr3.year, ccc2 desc) as tmp
		group by tmp.year, tmp.plane_tail_number
		order by xxx desc) as tmp2
where tmp2.xxx > 5
group by tmp2.plane_tail_number, tmp2.year, tmp2.xxx
order by tmp2.plane_tail_number, tmp2.year;
	
	
