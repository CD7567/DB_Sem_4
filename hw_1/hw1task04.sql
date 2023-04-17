select id, 
     (weight / 2.2046) / (height * 0.0254 * height * 0.0254) as bmi, 
     case
          when (weight / 2.2046) / (height * 0.0254 * height * 0.0254) < 18.5 then 'underweight'
          when (weight / 2.2046) / (height * 0.0254 * height * 0.0254) < 25 then 'normal'
          when (weight / 2.2046) / (height * 0.0254 * height * 0.0254) < 30 then 'overweight'
          when (weight / 2.2046) / (height * 0.0254 * height * 0.0254) < 35 then 'obese'
          else 'extremely obese'
     end as type
from hw
order by 
     bmi desc,
     id desc;