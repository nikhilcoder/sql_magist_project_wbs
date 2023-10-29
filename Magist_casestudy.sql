select 
t.product_category_name_english
,max(distinct oi.price) as max_product_price
,min(distinct oi.price) as min_product_price
,avg(distinct oi.price) as avg_item_price
,count(distinct p.product_id) as unique_product_exists
,count(distinct oi.product_id) as unique_product_sold
,sum(oi.order_item_id) as items_sold
,sum(oi.price) as product_revenue
,sum(oi.freight_value) as freight_cost
,sum(oi.freight_value)/(sum(oi.price)+sum(oi.freight_value)) as freight_as_revshare
,avg(datediff(o.order_delivered_customer_date, o.order_purchase_timestamp)) as days_to_deliver
from magist.order_items as oi
left join magist.orders as o 
on oi.order_id = o.order_id
left join magist.products as p 
on oi.product_id = p.product_id
left join magist.order_payments as op
on op.order_id = oi.order_id
left join magist.product_category_name_translation t 
on p.product_category_name = t.product_category_name
group by 1;
