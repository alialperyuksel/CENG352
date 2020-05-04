select table1.plane_tail_number, avg((fr1.flight_distance*1.0)/(fr1.flight_time*1.0)) as avg_speed 
from (
		(select fr.plane_tail_number
			from flight_reports fr, weekdays w2 
			where fr."month" = 1
				and fr.is_cancelled != 1
				and fr."year" = 2016
				and fr.weekday_id = w2.weekday_id
				and (w2.weekday_id = 6 or w2.weekday_id = 7)
				group by fr.plane_tail_number)
		except
		(select fr.plane_tail_number
			from flight_reports fr, weekdays w2 
			where fr."month" = 1
				and fr.is_cancelled != 1
				and fr."year" = 2016
				and fr.weekday_id = w2.weekday_id
				and (w2.weekday_id < 6 or w2.weekday_id > 7)
			group by fr.plane_tail_number)
	) as table1, flight_reports fr1
where table1.plane_tail_number = fr1.plane_tail_number 
	and fr1."month" = 1
	and fr1.is_cancelled != 1
	and fr1."year" = 2016
group by table1.plane_tail_number
order by avg_speed desc;


