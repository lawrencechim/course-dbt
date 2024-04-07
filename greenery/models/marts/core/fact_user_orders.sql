{{
    config(
        materialized = 'table'
    )
}}

with user_orders_agg as (
    select * from {{ ref('int_user_orders_agg') }}
),

order_items as (
    select * from {{ ref('stg_postgres__order_items') }}
)

select 
    user_id,
    uoa.order_id,
    product_id,
    promo_id,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    status,
    estimated_delivery_at_utc,
    delivered_at_utc,
    days_to_deliver,
    order_num,
    quantity as order_quantity
from user_orders_agg uoa
left join order_items oi
on uoa.order_id = oi.order_id