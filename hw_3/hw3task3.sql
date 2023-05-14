SELECT
    m.firstname, m.surname,
    t.hours AS hours,
    RANK() OVER (ORDER BY t.hours DESC) AS rank
FROM cd.members m JOIN (
    SELECT b.memid, ROUND(ROUND(SUM(b.slots) / 2, -1), -1) AS hours
    FROM cd.bookings b
    GROUP BY b.memid
) AS t ON t.memid = m.memid
ORDER BY
    rank, 
    m.surname,
    m.firstname;