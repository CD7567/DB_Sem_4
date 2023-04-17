select distinct self1.firstname as firstname, self1.surname as surname
from cd.members self1 inner join cd.members self2
on self1.memid = self2.recommendedby
where self2.recommendedby notnull
order by surname, firstname;