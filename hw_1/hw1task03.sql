select 
    count(id) as underweight_count
from hw
where
    (weight / 2.2046) / (height * height * 0.0254 * 0.0254) < 18.5;