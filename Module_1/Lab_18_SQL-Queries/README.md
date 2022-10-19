![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)
# Lab | My first queries

Please, download the file applestore.csv.
Install MySQL/Postgresql on your computer.
Create a database
Upload the file as a new table of your database

Use the *data* table to query the data about Apple Store Apps and answer the following questions: 

**1. What are the different genres?**

prime_genre:

Book
Business
Education
Entertainment
Finance
Food & Drink
Games
Health & Fitness
Lifestyle
Medical
Music
Navigation
News
Photo & Video
Productivity
Reference
Shopping
Social Networking
Sports
Travel
Utilities
Weather
(blank)


**2. Which is the genre with the most apps rated?**

Games with 167 ratings

**3. Which is the genre with most apps?**

Games

**4. Which is the one with least?**

Medical

**5. Find the top 10 apps most rated.**

Facebook	2974676
Pandora - Music & Radio	1126879
Pinterest	1061624
Bible	985920
Angry Birds	824451
Fruit Ninja Classic	698516
Solitaire	679055
PAC-MAN	508808
Calorie Counter & Diet Tracker by MyFitnessPal	507706
The Weather Channel: Forecast, Radar & Alerts	495626

**6. Find the top 10 apps best rated by users.**

:) Sudoku +	5
TurboScan Pro - document & receipt scanner: scan multiple pages and photos to PDF	5
Plants vs. Zombies	5
Learn to Speak Spanish Fast With MosaLingua	5
Plants vs. Zombies HD	5
The Photographer's Ephemeris	5
Sudoku +	5
Learn English quickly with MosaLingua	5
Kurumaki Calendar -month scroll calendar-	5
Domino's Pizza USA	5

**7. Take a look at the data you retrieved in question 5. Give some insights.**

Social media apps are the most used therefore have most rates from users

**8. Take a look at the data you retrieved in question 6. Give some insights.**

Mix of games, language aps and business applications

**9. Now compare the data from questions 5 and 6. What do you see?**

Most rated games are not always most downloaded

**10. How could you take the top 3 regarding both user ratings and number of votes?**

select track_name,user_rating from applestore
order by rating_count_tot DESC, user_rating ;

Facebook	3.5
Pandora - Music & Radio	4
Pinterest	4.5

**11. Do people care about the price of an app?** Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?

#Majority of apps rated were free (19801234 from 24011650 = 82%), people prefer to use apps that are free

update applestore
set track_name = 'Other'
Where price = 0;


update applestore
set track_name = 'Paid'
Where price > 0;

select track_name, rating_count_tot from applestore
group by track_name;

------------------

SELECT track_name, price, rating_count_tot
FROM applestore 
GROUP BY track_name;

## Deliverables 
You need to submit a `.sql` file that includes the queries used to answer the questions above, as well as an `.md` file including your answers. 
