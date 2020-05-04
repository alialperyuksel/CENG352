select ac.airline_name , ac.airline_code, avg(fr.departure_delay ) as avg_delay
from flight_reports fr, airline_codes ac 
where fr.year = 2018 and fr.airline_code = ac.airline_code and 
			fr.is_cancelled != 1
group by ac.airline_name, ac.airline_code 
order by avg(fr.departure_delay ), ac.airline_name 

						
