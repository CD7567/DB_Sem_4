WITH RECURSIVE rec(memid, firstname, surname) AS (
    SELECT memid, firstname, surname
        FROM cd.members
        WHERE recommendedby = 1
    UNION
    SELECT m.memid, m.firstname, m.surname
        FROM cd.members m JOIN rec r
            ON m.recommendedby = r.memid
)
SELECT memid, firstname, surname
FROM rec
ORDER BY memid ASC;