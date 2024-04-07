

1) How many users do we have?
    -130 users  
       
        select count(distinct user_id) 
        from dev_db.dbt_chrono202323gmailcom.stg_postgres__users;

2) On average, how many orders do we receive per hour?
    -15 orders/hour

        select avg(hourly_orders) from (
            select hour(created_at), count(*) as hourly_orders
            from dev_db.dbt_chrono202323gmailcom.stg_postgres__orders
            group by 1
        ) avg_orders;

3) On average, how long does an order take from being placed to being delivered?
    -Approximately 4 days (3.89 days)

        select avg(timestampdiff('day', created_at, delivered_at)) 
        from dev_db.dbt_chrono202323gmailcom.stg_postgres__orders
        where status = 'delivered';

4) How many users have only made one purchase? Two purchases? Three+ purchases?
    -1 purchase:  25
    -2 purchases: 28
    -3 purchases: 71

        select count(*) from (
            select user_id, count(distinct order_id) num_orders
            from dev_db.dbt_chrono202323gmailcom.stg_postgres__orders
            group by user_id
            having num_orders = 1) 
        num_users_with_orders;

5) On average, how many unique sessions do we have per hour?
    - 16.33 sessions per hour

        select avg(hourly_sessions) from (
            select year(created_at), month(created_at), day(created_at), hour(created_at), count(distinct session_id) as hourly_sessions
            from dev_db.dbt_chrono202323gmailcom.stg_postgres__events
            group by 1, 2, 3, 4
            order by 1, 2, 3, 4) 
        avg_hourly_sessions;
