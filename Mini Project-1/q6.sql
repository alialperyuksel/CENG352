select w2.weekday_id, w2.weekday_name, w2.avgd as avg_delay
from (select w.weekday_id, w.weekday_name , avg(fr.arrival_delay + fr.departure_delay) as avgd
		from weekdays w, flight_reports fr 
		where fr.dest_city_name = 'Boston, MA'
			and fr.origin_city_name = 'San Francisco, CA'
			and fr.weekday_id = w.weekday_id 
		group by w.weekday_id, w.weekday_name) as w2
group by w2.weekday_id, w2.weekday_name, w2.avgd
order by w2.avgd
limit 1;