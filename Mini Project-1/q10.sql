select ac2.airline_name , (count(*)) as flight_count
from ((select fr.plane_tail_number, ac.airline_code 
		from flight_reports fr, airline_codes ac
		where fr.airline_code = ac.airline_code 
			and fr.dest_wac_id = 74)
		except 
		(select fr.plane_tail_number, ac.airline_code 
		from flight_reports fr, airline_codes ac
		where fr.airline_code = ac.airline_code 
			and fr.dest_wac_id != 74)) as table1,
	flight_reports fr2, airline_codes ac2
where table1.plane_tail_number = fr2.plane_tail_number 
	and fr2.is_cancelled != 1
	and fr2.dest_wac_id = 74
	and table1.airline_code = ac2.airline_code 
group by ac2.airline_name 
order by ac2.airline_name;
	