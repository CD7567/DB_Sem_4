select facid,
       date_part('month', starttime) as month,
       sum(slots) as slots
    from cd.bookings
    where date_part('year', starttime) = 2012
    group by facid, month

union all

select facid,
       null::double precision as month,
       sum(slots) as slots
    from cd.bookings
    where date_part('year', starttime) = 2012
    group by facid

union all

select null::integer as facid,
       null::double precision as month,
       sum(slots) as slots
    from cd.bookings
    where date_part('year', starttime) = 2012

order by facid, month;