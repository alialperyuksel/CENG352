select table1.plane_tail_number, table1.airline_code as first_owner, table2.airline_code as second_owner
from (
		select ac.airline_code, ac.airline_name, fr.day, fr."month", fr."year", fr.plane_tail_number 
		from airline_codes ac, flight_reports fr 
		where ac.airline_code = fr.airline_code 
		group by ac.airline_code, ac.airline_name, fr.day, fr."month", fr."year", fr.plane_tail_number 
	) as table1,
	(
		select ac2.airline_code, ac2.airline_name, fr2.day, fr2."month", fr2."year", fr2.plane_tail_number 
		from airline_codes ac2, flight_reports fr2
		where ac2.airline_code = fr2.airline_code 
		group by ac2.airline_code, ac2.airline_name, fr2.day, fr2."month", fr2."year", fr2.plane_tail_number 
	) as table2
where (
		(table1.year < table2.year)
		or 
		(table1.year = table2.year and table1.month < table2.month)
		or 
		(table1.year = table2.year and table1.month = table2.month and table1.day < table2.day )
	)
	and table1.airline_name != table2.airline_name
	and table1.plane_tail_number = table2.plane_tail_number
group by table1.airline_code, table2.airline_code , table1.plane_tail_number
order by table1.plane_tail_number, first_owner, second_owner;

		
	