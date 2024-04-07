

1) What is our user repeat rate?
    -- 79.84%   
       
    -- SQL
    with orders_cohort as (
        select 
            user_id,
            count(distinct order_id) as user_orders
        from dev_db.dbt_chrono202323gmailcom.stg_postgres__orders
        group by 1
    ),

    users_bucket as (
        select 
            user_id,
            (user_orders = 1)::int as has_one_purchase,
            (user_orders = 2)::int as has_two_purchases,
            (user_orders >= 2)::int as has_two_plus_purchases
        from orders_cohort
    )

    select avg(has_two_plus_purchases)*100 as repeat_rate from users_bucket;

2)  What are good indicators of a user who will likely purchase again? 
    What about indicators of users who are likely NOT to purchase again? 
    If you had more data, what features would you want to look into to answer this question?

    Some indicators are:
        a) Geographic information (ie: by zip code, state or region in the country)
        b) Recent purchase history (how many orders were placed in last 7 days, 30 days, etc)
        c) Users who have a high shipping cost to order cost ratio also may be reluctant to buy

    Other features to look at would be income (if available), presence of competitor in the users neighbourhood, 
    effect of various marketing channels, etc

3) Explain the product mart models you added. Why did you organize the models in the way you did?

    I created a "fact_user_sessions" table in the product mart as I assume product team would be mostly interested 
    in session level data per user, such as number of actions per page_views, checkouts, add_to_carts, and 
    packages_shipped as well as session length information.

    I created a "fact_user_orders" table in the core mart ,Most of the teams would be interested in order 
    level data per user, along with aggregate information such as order cost, quantity, shipping etc.

4) What assumptions are you making about each model? (i.e. why are you adding each test?)

    a) For each of the table, I made sure that the primary keys (usually suffixed with "id") are all not null and unique.
    b) Certain numerical values such as order cost, shipping cost, order total, should be a positive value
    c) Certain columns (such as status) should only acccept a set of accepted values

    All of the tests have passed successfully so it looks like the staging tables are created with good logical.

5)  Your stakeholders at Greenery want to understand the state of the data each day. 
    Explain how you would ensure these tests are passing regularly and how you would alert 
    stakeholders about bad data getting through.

    Run "dbt test" right after "dbt run" to make sure all of the tests pass. We could also play with the freshness 
    parameter to make sure that we have relatively updated data each day we run the dbt models.


6)  Run the product snapshot model using dbt snapshot and query it in snowflake to see how the 
    data has changed since last week. Which products had their inventory change from week 1 to week 2? 

    I'm guessing I didn't configure this correctly since it's not showing any updates when I run "dbt snapshot".