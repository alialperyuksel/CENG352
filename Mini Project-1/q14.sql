select max_reason.year, w3.weekday_name, cr.reason_desc as reason, cnt1 as number_of_cancellations
from (select reason_cnt.year, reason_cnt.weekday_id, max(reason_cnt.count) as cnt1
		from(
			select fr.year, fr.weekday_id, fr.cancellation_reason, count(*)
			from flight_reports fr, weekdays w2 
			where fr.weekday_id = w2.weekday_id 
				and fr.is_cancelled = 1
			group by fr.year, fr.weekday_id, fr.cancellation_reason) as reason_cnt
		group by reason_cnt.year, reason_cnt.weekday_id) as max_reason,
	(
		select fr.year, fr.weekday_id, fr.cancellation_reason, count(*) as cnt2
		from flight_reports fr, weekdays w2 
		where fr.weekday_id = w2.weekday_id 
			and fr.is_cancelled = 1
		group by fr.year, fr.weekday_id, fr.cancellation_reason
	) as cnt_reason,
	cancellation_reasons cr, weekdays w3
where 
	cnt1 = cnt2
	and max_reason.year = cnt_reason.year
	and max_reason.weekday_id = cnt_reason.weekday_id
	and cnt_reason.cancellation_reason = cr.reason_code
	and w3.weekday_id = max_reason.weekday_id
order by max_reason.year, w3.weekday_id;
