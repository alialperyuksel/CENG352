select ai2.airport_desc
from (
	select fr.dest_airport_id, count(*) as cnt1
	from flight_reports fr, airport_ids ai 
	where fr.dest_airport_id = ai.airport_id 
	group by fr.dest_airport_id 
	) as dest_cnt,
	(
	select fr.origin_airport_id, count(*) as cnt2
	from flight_reports fr, airport_ids ai 
	where fr.origin_airport_id = ai.airport_id 
	group by fr.origin_airport_id 
	) as origin_cnt, airport_ids ai2
where dest_cnt.dest_airport_id = origin_cnt.origin_airport_id
	and ai2.airport_id = dest_cnt.dest_airport_id
group by ai2.airport_desc, cnt1+cnt2
order by cnt1+cnt2 desc, ai2.airport_desc
limit 5;


