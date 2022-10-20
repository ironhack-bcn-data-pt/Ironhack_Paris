
/*select order_id, price from order_items
order by price desc
limit 1000;*/

/*SELECT max(Price) 
FROM order_items;

SELECT min(shipping_limit_date) 
FROM order_items;

SELECT customer_state, count(*)
from customers
group by customer_state;


*/

/* use olist;

SELECT customer_state, count(customer_id),customer_city, COUNT(customer_id)
FROM customers
GROUP BY customer_city;

SELECT 'SP', customer_city, count(customer_id)
FROM customers
Group by customer_city
Order by customer_id;*/

/*select declared_monthly_revenue, business_segment
from closed_deals
where declared_monthly_revenue >0
group by business_segment
order by declared_monthly_revenue desc;*/

/*select count(declared_monthly_revenue)
from closed_deals
where declared_monthly_revenue > 0;*/

/*SELECT review_score, count(review_score)
from order_reviews
group by review_score
order by review_score desc;*

/* */

/*ALTER TABLE order_reviews
ADD Score_descr VARCHAR(20);

update order_reviews
set Score_descr = 'One'
where review_score = 1;

update order_reviews
set Score_descr = 'Two'
where review_score = 2;

update order_reviews
set Score_descr = 'Three'
where review_score = 3;

update order_reviews
set Score_descr = 'Four'
where review_score = 4;

update order_reviews
set Score_descr = 'Five'
where review_score = 5;

select Score_descr, count(Score_descr) from order_reviews
group by Score_descr
order by count(score_descr) ;*/

select review_score, count(review_score)
from order_reviews
group by Score_descr
order by count(score_descr)