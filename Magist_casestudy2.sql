with tech_category as
(select oi.*
from magist.order_items as oi
left join magist.orders as o 
on oi.order_id = o.order_id
left join magist.products as p 
on oi.product_id = p.product_id
left join magist.order_payments as op
on op.order_id = oi.order_id
left join magist.product_category_name_translation t 
on p.product_category_name = t.product_category_name

where oi.price > 0
and t.product_category_name_english in ('auto','cds_dvds_musicals','cine_photo','computers','computers_accessories','consoles_games','dvds_blu_ray','electronics','fixed_telephony','pc_gamer','telephony')
),
non_tech_category as
(select oi.*
from magist.order_items as oi
left join magist.orders as o 
on oi.order_id = o.order_id
left join magist.products as p 
on oi.product_id = p.product_id
left join magist.order_payments as op
on op.order_id = oi.order_id
left join magist.product_category_name_translation t 
on p.product_category_name = t.product_category_name

where oi.price > 0
and t.product_category_name_english not in ('auto','cds_dvds_musicals','cine_photo','computers','computers_accessories','consoles_games','dvds_blu_ray','electronics','fixed_telephony','pc_gamer','telephony')
)


select count(distinct product_id) as unique_product_sold, count(order_item_id) as items_sold,  'Tech' as Type 
from tech_category

union

select count(distinct product_id) as unique_product_sold, count(order_item_id) as items_sold,  'Non-Tech' as Type 
from non_tech_category



