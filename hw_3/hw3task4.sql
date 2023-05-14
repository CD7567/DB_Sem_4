with t3 as (
    SELECT firstname, t2.facid, t2.slots
        FROM cd.members
        JOIN (
            SELECT facid, memid, slots
            FROM cd.bookings
        ) as t2 on cd.members.memid = t2.memid
)
,t1 as (
    SELECT name, membercost, guestcost, t3.slots, t3.firstname
    FROM cd.facilities
    JOIN t3 on t3.facid = cd.facilities.facid
    )
, t4 as (
    SELECT name,
           sum(CASE
               WHEN firstname = 'GUEST' THEN slots * guestcost
                ELSE slots * membercost
           END) as revenue
    FROM t1
    GROUP BY name
)
, t5 as (
    SELECT name, ntile(3) over (ORDER BY revenue DESC) as revenue
    FROM t4
    ORDER BY revenue, name
)
SELECT name,
       CASE
           WHEN revenue = 1 THEN 'high'
           WHEN revenue = 2 THEN 'average'
           WHEN revenue = 3 THEN 'low'
       END AS revenue
FROM t5;