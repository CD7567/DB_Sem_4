select
    upper(full_nm) as full_name,
    min(dt) as dt,
    high_price as price
from coins 
where (full_nm, high_price) in
    (
        select
            full_nm,
            max(high_price)
        from coins
        group by full_nm
    )
group by full_name, high_price
order by high_price desc, full_name;