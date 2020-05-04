select ac2.airline_name, cnt_monday as monday_flights, cnt_sunday as sunday_flights
from (
		select ac.airline_code, count(*) as cnt_monday
		from airline_codes ac, flight_reports fr, weekdays w2 
		where fr.is_cancelled != 1
			and ac.airline_code = fr.airline_code 
			and fr.weekday_id = w2.weekday_id 
			and w2.weekday_id = 1
		group by ac.airline_code
	) as mon_fl,
	(
		select ac.airline_code, count(*) as cnt_sunday
		from airline_codes ac, flight_reports fr, weekdays w2 
		where fr.is_cancelled != 1
			and ac.airline_code = fr.airline_code 
			and fr.weekday_id = w2.weekday_id 
			and w2.weekday_id = 7
		group by ac.airline_code
	) as sun_fl, airline_codes ac2
where ac2.airline_code = sun_fl.airline_code
	and sun_fl.airline_code = mon_fl.airline_code
group by ac2.airline_name, cnt_monday, cnt_sunday
order by ac2.airline_name;



