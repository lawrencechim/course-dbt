{{
    config(
        materialized = 'table',
        post_hook = "{{ grant_roles('REPORTING') }}"
    )
}}
-- post_hook = 'grant select on {{ this }} to role REPORTING'


with order_items as (
    select * from {{ ref('stg_postgres__order_items') }}
), 

events as (
    select * from {{ ref('stg_postgres__events') }}
), 

session_events_agg as (
    select * from {{ ref('int_session_events_agg') }}
)

select 
    e.user_id
    ,e.session_id
    ,coalesce(e.product_id, oi.product_id) as product_id
    ,first_session_event_at_utc
    ,last_session_event_at_utc
    {{ event_types('stg_postgres__events', 'event_type') }}
    -- sum(case when event_type = 'page_view' then 1 else 0 end) as page_views,
    -- sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts,
    -- sum(case when event_type = 'checkout' then 1 else 0 end) as checkouts,
    -- sum(case when event_type = 'package_shipped' then 1 else 0 end) as packages_shipped
from events e
left join order_items oi
on e.order_id = oi.order_id
left join session_events_agg sea
on e.session_id = sea.session_id
group by 1, 2, 3, 4, 5
