![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)
# Lab | MySQL Select

## Introduction

 In this lab, we will practice selecting and projecting data. You can finish all questions with only these clauses:
- `SELECT`
- `SELECT DISTINCT`
- `COUNT`
- `FROM`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- `SUM`
- `LIMIT`

The Sql script is here: https://drive.google.com/file/d/1tT1OTdIgkI5tkeeXIsnZwMC5SxI1FE9m/view
Please submit your solutions in a text file `solutions.sql`.

#### 1. From the `order_items` table, find the price of the highest priced order and lowest price order.

Lowest = 0.85
Highest = 6735

#### 2. From the `order_items` table, what is range of the shipping_limit_date of the orders?

Max: 2020-04-10 00:35:08
Min: 2016-09-19 02:15:34

#### 3. From the `customers` table, find the states with the greatest number of customers.

Lowest = RR with 46
Highest = SP with 41746

#### 4. From the `customers` table, within the state with the greatest number of customers, find the cities with the greatest number of customers.

use olist;

SELECT customer_state, count(customer_id),customer_city, COUNT(customer_id)
FROM customers
GROUP BY customer_city;

SELECT 'SP', customer_city, count(customer_id)
FROM customers
Group by customer_city
Order by customer_id;
----------------

SP	salvador	1245
SP	sao bernardo do campo	938
SP	santos	713
SP	goiania	692
SP	sao jose dos campos	691
SP	recife	613
SP	florianopolis	570
SP	contagem	426
SP	piracicaba	369
SP	campo grande	320
SP	sao caetano do sul	277
SP	maringa	271
SP	taubate	270
SP	duque de caxias	266
SP	maceio	247
SP	caxias do sul	224
SP	betim	203

#### 5. From the `closed_deals` table, how many distinct business segments are there (not including null)?

32 business segments

#### 6. From the `closed_deals` table, sum the declared_monthly_revenue for duplicate row values in business_segment and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).

8000000	phone_mobile
300000	pet
250000	audio_video_electronics

#### 7. From the `order_reviews` table, find the total number of distinct review score values.

5	57420
4	19200
3	8287
2	3235
1	11858

#### 8. In the `order_reviews` table, create a new column with a description that corresponds to each number category for each review score from 1 - 5, then find the review score and category occurring most frequently in the table.

Five	57420
Four	19200
One	11858
Three	8287
Two	3235
---------------------
ALTER TABLE order_reviews
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
order by count(score_descr)


#### 9. From the `order_reviews` table, find the review value occurring most frequently and how many times it occurs.

5	57420