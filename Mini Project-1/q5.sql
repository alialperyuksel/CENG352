select concat(to_b.day, '/', to_b."month", '/', to_b."year" ) as flight_date, 
	to_b.plane_tail_number,
	from_s.arrival_time as flight1_arrival_time,
	to_b.departure_time as flight2_departure_time,
	from_s.origin_city_name,
	from_s.dest_city_name as stop_city_name,
	to_b.dest_city_name,
	from_s.flight_time + from_s.taxi_out_time + to_b.taxi_in_time + to_b.flight_time as total_time,
	from_s.flight_distance + to_b.flight_distance as total_distance
from (
	select fr.day, fr.month, fr.year,
		fr.origin_city_name,
		fr.dest_city_name,
		fr.arrival_time,
		fr.flight_time,
		fr.taxi_out_time,
		fr.flight_distance,
		fr.plane_tail_number 
	from flight_reports fr 
	where fr.origin_city_name like 'Seattle%'
		and fr.dest_city_name not like 'Boston%'
		and fr.is_cancelled != 1
	) as from_s,
	(
	select fr.day, fr.month, fr.year,
		fr.origin_city_name,
		fr.dest_city_name,
		fr.departure_time ,
		fr.flight_time,
		fr.taxi_in_time,
		fr.flight_distance,
		fr.plane_tail_number 
	from flight_reports fr 
	where fr.dest_city_name like 'Boston%'
		and fr.origin_city_name not like 'Seattle%'
		and fr.is_cancelled != 1
	) as to_b
where from_s.day = to_b.day
	and from_s.month = to_b.month
	and from_s.year = to_b.year
	and from_s.dest_city_name = to_b.origin_city_name
	and from_s.plane_tail_number = to_b.plane_tail_number
	and from_s.arrival_time < to_b.departure_time
order by total_time, total_distance, to_b.plane_tail_number, stop_city_name
	