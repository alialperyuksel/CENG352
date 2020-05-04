select table1.year, table1.airline_code, table1.cnt1 as boston_flight_count, table1.perc as boston_flight_percentage
from (
	select boston_flights.year, boston_flights.airline_code, cnt1, (cnt1*1.0/cnt2)*100 as perc
	from (
			select fr."year", ac.airline_code, count(*) as cnt1
			from airline_codes ac, flight_reports fr 
			where fr.dest_city_name = 'Boston, MA'
				and 
					fr.airline_code = ac.airline_code 
				and fr.is_cancelled != 1
			group by fr."year", ac.airline_code 
		) as boston_flights,
		(
			select fr."year", ac.airline_code, count(*) as cnt2
			from airline_codes ac, flight_reports fr 
			where fr.is_cancelled != 1
				and 
					fr.airline_code = ac.airline_code 
			group by fr."year", ac.airline_code 
		) as all_flights
	where
		boston_flights.year = all_flights.year
		and boston_flights.airline_code = all_flights.airline_code
	) as table1
where table1.perc > 1
group by table1.year, table1.airline_code, table1.cnt1, table1.perc
order by table1.year, table1.airline_code;