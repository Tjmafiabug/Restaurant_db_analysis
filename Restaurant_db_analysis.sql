use restuarant_db;
#OBJECTIVE-1

-- 1. View the menu_items table on the menu.
select * from menu_items; 

-- 2. find the number of items on the menu.
select count(menu_item_id) as Total_items from menu_items;

-- 3. What are the least and most expensive items on the menu ?
(select item_name, price, 'Most Expensive' as Category
from menu_items
order by price desc
limit 1)

UNION ALL

(select item_name, price, 'Cheapest' as Category 
from menu_items
order by price 
limit 1);


-- 4. How many italian dishes are on the menu ?

select count(menu_item_id) as Total_italian_dishes from menu_items
where category = 'italian'; 

-- 5. what are the least and the most expensive italian dishes on the menu ?

(select *, 'Cheapest' as Price_category from menu_items
where category = 'italian'
order by price
limit 1)

union all

(select *, 'Most Expensive' as Price_category from menu_items
where category = 'italian'
order by price desc
limit 1);

-- 6. How many dishes are in each category ?
select category, count(menu_item_id) as Total_dishes from menu_items
group by category
;

-- 7. What is the average dish price within the each category ?
select avg(price) as Average_price, category from menu_items
group by category
;

#OBJECTIVE-2

-- 1. View the order_details table.

select * from order_details;

-- 2. what is the date range of the table ?
(select min(order_date), 'Earliest date' as date from
order_details)

union all

(select max(order_date),'Latest date' as date from
order_details);

-- 3. How many orders were made within this date range ?
select count(distinct order_id) as Total_orders from order_details;
 
-- 4. How many distinct items were ordered within this date_range ?
select count(distinct item_id) as Total_items_ordered from order_details;

-- 5. Which orders had the most number mof items ?

select order_id, count(item_id) as Total_items
from order_details
group by order_id
order by total_items desc
;

-- 6. How many orders had more than 12 items ?
select order_id, count(item_id) as Total_Items
from order_details
group by order_id
having count(item_id) > 12
; 

#OBJECTIVE-3

-- 1. Combine the menu_items and order_details tables into a single table.
select *
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
;

-- 2. What were the least and the most ordered items ? What categories were they in ?
(select mi.item_name,mi.category, count(od.order_id) as Times_ordered, 'Highest' as Category
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
group by mi.item_name, mi.category
order by Times_ordered desc
limit 1)

union all

(select mi.item_name,mi.category, count(od.order_id) as Times_ordered, 'Lowest' as Category
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
group by mi.item_name, mi.category
order by Times_ordered 
limit 1)
;


-- 3. What were the top 5 orders that spent the most money ?

select od.order_id, sum(mi.price) as Total_Money_spent
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
group by order_id
order by Total_Money_spent desc
limit 5
;

-- 4. View the details of the highest spend order, What insights can you gather from the result.
select od.order_id,od.order_date, od.order_time, mi.category, mi.item_name, mi.menu_item_id, mi.price 
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
where order_id = '440'
group by od.order_id,od.order_date, od.order_time, mi.category, mi.item_name, mi.menu_item_id, mi.price
;










