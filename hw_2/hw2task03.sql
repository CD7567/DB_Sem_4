select facid,
       date_part('month', starttime) as month,
       sum(slots) as total_slots
from cd.bookings
where date_part('year', starttime) = 2012
group by facid, month
order by facid, month;