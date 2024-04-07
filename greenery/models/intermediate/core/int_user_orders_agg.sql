{{
    config(
        materialized = 'table'
    )
}}

with orders as (
    select * from {{ ref('stg_postgres__orders') }}
)

select 
    user_id,
    order_id,
    promo_id,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    status,
    estimated_delivery_at_utc,
    delivered_at_utc,
    case when status = 'delivered' then datediff('days', created_at_utc, delivered_at_utc) else null end as days_to_deliver,
    row_number() over (partition by user_id order by created_at_utc) order_num
from orders
