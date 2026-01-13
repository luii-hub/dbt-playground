-- Since we are editing SQL in a code editor, we must follow the database rules of PostgreSQL, 
-- which folds unquoted identifiers to lowercase.
-- Therefore, we will use lowercase for all identifiers in this file.
-- If we wanted to preserve casing, we would need to double quote all identifiers,
-- which is not a common practice in dbt projects.

-- Check dbt_fundamentals/dbt_project.yml and how it configures the models. Use 'dbt seed --full-refresh'
-- to load the raw.jaffle_shop_customers and raw.jaffle_shop_orders tables before running.

with customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from raw.jaffle_shop_customers

),

orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from raw.jaffle_shop_orders

),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final
