## Week 3 Questions

### What is our overall conversion rate?

```sql
select 
    count(distinct case when checkouts >=1 then session_id end) as total_sessions_purhcased,
    count(distinct session_id) as total_sessions,
    round(100*(total_sessions_purhcased / total_sessions), 3) as conv_rate
from dev_db.dbt_chrono202323gmailcom.int_session_events_agg;
```

The conversion rate is 62.46%.

### What is our conversion rate by product?

```sql
select 
    name,
    p.product_id,
    count(distinct case when checkout >=1 then session_id end) as total_sessions_purchased,
    count(distinct session_id) as total_sessions,
    round(100*(total_sessions_purchased / total_sessions), 3) as conv_rate
from dev_db.dbt_chrono202323gmailcom.fact_product_conv fpc
join dev_db.dbt_chrono202323gmailcom.stg_postgres__products p
on fpc.product_id = p.product_id
group by 1,2
order by conv_rate desc;
```

| NAME|PRODUCT_ID|TOTAL_SESSIONS_PURCHASED|TOTAL_SESSIONS|CONV_RATE|
|:--------|:------------------|:-----------------------------------------| :------------------------| :---------------|
|String of pearls|fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80|39|64|60.938|
|Arrow Head|74aeb414-e3dd-4e8a-beef-0fa45225214d|35|63|55.556|
|Cactus|c17e63f7-0d28-4a95-8248-b01ea354840e|30|55|54.546|
|ZZ Plant|b66a7143-c18a-43bb-b5dc-06bb5d1d3160|34|63|53.968|
|Bamboo|689fb64e-a4a2-45c5-b9f2-480c2155624d|36|67|53.731|
|Rubber Plant|579f4cd0-1f45-49d2-af55-9ab2b72c3b35|28|54|51.852|
|Monstera|be49171b-9f72-4fc9-bf7a-9a52e259836b|25|49|51.020|
|Calathea Makoyana|b86ae24b-6f59-47e8-8adc-b17d88cbd367|27|53|50.943|
|Fiddle Leaf Fig|e706ab70-b396-4d30-a6b2-a1ccf3625b52|28|56|50.000|
|Majesty Palm|5ceddd13-cf00-481f-9285-8340ab95d06d|33|67|49.254|
|Aloe Vera|615695d3-8ffd-4850-bcf7-944cf6d3685b|32|65|49.231|
|Devil's Ivy|35550082-a52d-4301-8f06-05b30f6f3616|22|45|48.889|
|Philodendron|55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3|30|62|48.387|
|Jade Plant|a88a23ef-679c-4743-b151-dc7722040d8c|22|46|47.826|
|Spider Plant|64d39754-03e4-4fa0-b1ea-5f4293315f67|28|59|47.458|
|Pilea Peperomioides|5b50b820-1d0a-4231-9422-75e7f6b0cecf|28|59|47.458|
|Dragon Tree|37e0062f-bd15-4c3e-b272-558a86d90598|29|62|46.774|
|Money Tree|d3e228db-8ca5-42ad-bb0a-2148e876cc59|26|56|46.429|
|Orchid|c7050c3b-a898-424d-8d98-ab0aaad7bef4|34|75|45.333|
|Bird of Paradise|05df0866-1a66-41d8-9ed7-e2bbcddd6a3d|27|60|45.000|
|Ficus|843b6553-dc6a-4fc4-bceb-02cd39af0168|29|68|42.647|
|Birds Nest Fern|bb19d194-e1bd-4358-819e-cd1f1b401c0c|33|78|42.308|
|Pink Anthurium|80eda933-749d-4fc6-91d5-613d29eb126f|31|74|41.892|
|Boston Fern|e2e78dfc-f25c-4fec-a002-8e280d61a2f2|26|63|41.270|
|Alocasia Polly|6f3a3072-a24d-4d11-9cef-25b0b5f8a4af|21|51|41.177|
|Peace Lily|e5ee99b6-519f-4218-8b41-62f48f59f700|27|66|40.909|
|Ponytail Palm|e18f33a6-b89a-4fbc-82ad-ccba5bb261cc|28|70|40.000|
|Snake Plant|e8b6528e-a830-4d03-a027-473b411c7f02|29|73|39.726|
|Angel Wings Begonia|58b575f2-2192-4a53-9d21-df9a0c14fc25|24|61|39.344|
|Pothos|4cda01b9-62e2-46c5-830f-b7f262a58fb1|21|61|34.426|
