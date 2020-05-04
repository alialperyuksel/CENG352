select ac5.airline_name, fr5."year", table2.cnt as total_num_flights, count(*) as cancelled_flights
from (select ac4.airline_code, fr4."year", count(*) as cnt
	 from (
		select tmp3.airline_code, count(*)
		from (select tmp2.airline_code, tmp2.year, tmp2.xxx as daily_avg
					from (select tmp.airline_code, tmp.year, avg(ccc2) as xxx
							from (select fr3.year ,ac3.airline_code , count(fr3.is_cancelled ) as ccc2
									from flight_reports fr3, airline_codes ac3 
									where fr3.is_cancelled != 1 
										and ac3.airline_code = fr3.airline_code 
									group by ac3.airline_code  ,  fr3.day, fr3.year 
									order by fr3.day, fr3.year, ccc2 desc) as tmp
							group by tmp.year, tmp.airline_code
							order by xxx desc) as tmp2
					where tmp2.xxx > 2000 
					group by tmp2.airline_code, tmp2.year, tmp2.xxx
					order by tmp2.airline_code, tmp2.year) as tmp3
			group by tmp3.airline_code
			having count(*) = 4
			) as table1, flight_reports fr4, airline_codes ac4
		where table1.airline_code = ac4.airline_code
			and ac4.airline_code = fr4.airline_code 
		group by ac4.airline_code , fr4."year"
		) as table2, flight_reports fr5, airline_codes ac5
where table2.airline_code = ac5.airline_code
		and ac5.airline_code = fr5.airline_code 
		and fr5.is_cancelled = 1
		and table2.year = fr5.year
group by ac5.airline_name ,  table2.cnt,  fr5."year"
order by ac5.airline_name;

	