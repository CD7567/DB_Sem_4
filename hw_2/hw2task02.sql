select recommendedby, count(memid) as count
from cd.members
where recommendedby notnull
group by recommendedby
order by recommendedby;