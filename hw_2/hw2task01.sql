select full_nm as full_name,
       avg(avg_price) as avg_price,
       max(high_price) as max_price,
       min(low_price) as min_price
from coins
group by full_nm;