select *
from coins
where
    symbol = 'BTC'
    and
    avg_price < 100;