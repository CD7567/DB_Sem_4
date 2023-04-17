select concat(firstname, ' ', surname) as member,
(
    select concat(firstname, ' ', surname)
    from cd.members recommenders
    where members.recommendedby = recommenders.memid
) as recommender
from cd.members
order by member;