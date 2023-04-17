select cd.members.surname,
       cd.members.firstname,
       cd.members.memid,
       min(starttime) as starttime
from cd.members inner join cd.bookings
on cd.members.memid = cd.bookings.memid
where cd.bookings.starttime > '2012-09-01'
group by cd.members.surname, cd.members.firstname, cd.members.memid
order by memid;