select member, facility, cost
from (select concat(firstname, ' ', surname) as member,
             joindate,
             starttime,
             name as facility,
                 case
                     when m.memid = 0 then
                     guestcost * slots
                 else
                     membercost * slots
             end as cost
      from 
          cd.members as m,
          cd.bookings as b,
          cd.facilities as f
      where
          date_trunc('day', b.starttime) = '2012-09-14' and
          b.facid = f.facid and
          m.memid = b.memid
      order by cost desc,
               member,
               facility
     ) as t
where cost > 30;