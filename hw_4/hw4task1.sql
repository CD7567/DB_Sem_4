WITH RECURSIVE fib(n, prev1, prev2) AS (
    SELECT 0::bigint, 1::numeric, 1::numeric
    UNION ALL
    SELECT n + 1, prev2, prev1 + prev2
    FROM fib
    WHERE n < 99
)
SELECT n AS nth, prev1 AS value
FROM fib
ORDER BY n;