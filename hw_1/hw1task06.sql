select dt, high_price, vol
from coins
where
    symbol = 'DOGE'
    and
    dt like '2018%'
    and
    avg_price > 0.001;