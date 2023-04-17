select self1.firstname as memfname,
       self1.surname as memsname,
       self2.firstname as recfname,
       self2.surname as recsname
from cd.members self1 left join cd.members self2
on self1.recommendedby = self2.memid
order by memsname, memfname, recfname, recsname;