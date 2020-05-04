select table1.airline_name
from ((select ac.airline_name
		from flight_reports fr, airline_codes ac 
		where fr.is_cancelled != 1
			and fr.airline_code = ac.airline_code 
			and exists (select * 
						from flight_reports fr2 
						where fr2.airline_code = fr.airline_code
							and fr2.dest_city_name = 'Boston, MA')
			and exists (select * 
						from flight_reports fr3 
						where fr3.airline_code = fr.airline_code
							and fr3.dest_city_name = 'New York, NY')
			and exists (select * 
						from flight_reports fr4
						where fr4.airline_code = fr.airline_code
							and fr4.dest_city_name = 'Portland, ME')
			and exists (select * 
						from flight_reports fr5 
						where fr5.airline_code = fr.airline_code
							and fr5.dest_city_name = 'Washington, DC')
			and exists (select * 
						from flight_reports fr6 
						where fr6.airline_code = fr.airline_code
							and fr6.dest_city_name = 'Philadelphia, PA')
		group by ac.airline_name)
except
		(select ac.airline_name
		from flight_reports fr, airline_codes ac 
		where fr.is_cancelled != 1
			and fr.airline_code = ac.airline_code 
			and exists (select * 
						from flight_reports fr2 
						where fr2.airline_code = fr.airline_code
							and fr2.dest_city_name = 'Boston, MA'
							and fr2.year < 2018)
			and exists (select * 
						from flight_reports fr3 
						where fr3.airline_code = fr.airline_code
							and fr3.dest_city_name = 'New York, NY'
							and fr3.year < 2018)
			and exists (select * 
						from flight_reports fr4
						where fr4.airline_code = fr.airline_code
							and fr4.dest_city_name = 'Portland, ME'
							and fr4.year < 2018)
			and exists (select * 
						from flight_reports fr5 
						where fr5.airline_code = fr.airline_code
							and fr5.dest_city_name = 'Washington, DC'
							and fr5.year < 2018)
			and exists (select * 
						from flight_reports fr6 
						where fr6.airline_code = fr.airline_code
							and fr6.dest_city_name = 'Philadelphia, PA'
							and fr6.year < 2018)
		group by ac.airline_name)) as table1
order by table1.airline_name;
		





