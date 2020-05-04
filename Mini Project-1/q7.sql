select fr1.airline_name, ((fr1.f_cancel*1.0)/(fr2.f_done*1.0))*100.0 as percentage
from (
		select ac.airline_name, count(*) as f_cancel 
		from airline_codes ac, flight_reports fr 
		where fr.origin_city_name = 'Boston, MA'
			and ac.airline_code = fr.airline_code
			and fr.is_cancelled = 1
		group by ac.airline_name
	 ) as fr1,
	 (
		select ac2.airline_name, count(*) as f_done 
		from airline_codes ac2, flight_reports fr3 
		where fr3.origin_city_name = 'Boston, MA'
			and ac2.airline_code = fr3.airline_code
		group by ac2.airline_name
	 ) as fr2
where fr1.airline_name = fr2.airline_name
	and (((fr1.f_cancel*1.0)/(fr2.f_done*1.0))*100.0) > 10.0
group by fr1.airline_name, ((fr1.f_cancel*1.0)/(fr2.f_done*1.0))*100.0
order by ((fr1.f_cancel*1.0)/(fr2.f_done*1.0))*100.0 desc;
	

