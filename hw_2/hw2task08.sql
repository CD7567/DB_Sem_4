select distinct concat(firstname, ' ', surname) as member,
                name as facility
from
(cd.bookings bookings inner join cd.facilities facilities on bookings.facid = facilities.facid) full_facilities
inner join cd.members on cd.members.memid = full_facilities.memid
where name like 'Tennis%'
group by member, facility
order by member, facility;