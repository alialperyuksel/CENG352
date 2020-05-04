select ac.airport_code, ac.airport_desc, count(fr.is_cancelled) as cancel_count
from airport_codes ac, flight_reports fr 
where fr.origin_airport_code = ac.airport_code 
	and fr.is_cancelled = 1
	and fr.cancellation_reason = 'D'
group by ac.airport_code 
order by count(fr.is_cancelled) desc, ac.airport_code;

