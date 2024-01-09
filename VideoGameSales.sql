use projectportfolio;
/*
Video Game Sales Project. 
In this project, I will be analyzing sales of over 16,000 games. 
Questions I will answer will be.
Which Genre, Platform, Game and Publisher dominates in sales globally?
Which Genre, Platform, Game and Publisher dominates in sales in North America?
Which Genre, Platform, Game and publisher dominates in sales in Europe?
Which Genre, Platform, Game and publisher dominates in sales in Japan?
All sales are recorded in the Millions
 */
 
select * from vgsales;

----------------------------------------------------------------------------------------------------------------------------------------------- 
-- Global sale for Genre, Platform, Game and Publisher.
select Genre
, count(Genre) as NumberofGames
, round(sum(Global_Sales), 2) As TotalGenreGlobalSales
from vgsales
group by Genre
order by sum(Global_Sales) DESC;

/* Action Genre sold the most with 1722.9 M in global sales however sports Genre with have less than 1000 games than action are shy by 400M in global sales.*/

select Platform
, round(sum(Global_Sales),2) as TotalPlatformGlobalSales
from vgsales
group by Platform
order by sum(Global_Sales) DESC;

-- Playstation 2 is the leading platform in global sales with a total of 1233.5 M

select Game
, platform
, Publisher
, Global_Sales as TotalGameGLobalSales
from vgsales
order by Global_Sales DESC
limit 50;

/*To my suprise Wii Sports is the game with the most global sales 
This would makes sense as Wii Sports is included with Wii Concole when purchasing it, the Wii being the 4th most purchased concole.*/


select Publisher
, count(Publisher) as NumberOfGamesReleased
, round(sum(Global_Sales),2) as TotalPublisherGlobalSales
from vgsales
group by Publisher
order by sum(Global_Sales) DESC;

/* Nintendo lead in global sales for publisher with 1784.4 M in revenue, 
This shouldn't come as a suprise since the top 15 games in revenue were published by Nintendo*/

----------------------------------------------------------------------------------------------------------------------------------------------- 

-- North America sale for Genres, Platform, Games and Publisher
-- For Platform, games and Publisher I will limit it to the top 10 of sales
select Genre
, count(Genre) as NumberofGames
, round(sum(NA_Sales),1) As TotalGenreSalesinNorthAmerica
from vgsales
group by Genre
order by sum(NA_Sales) DESC;

/* As predicted action genre takes over sales in NA, while the top 3 stayed the same we notice a differece after this point, 
Role-Playing games while populor around the world, drop down from 4th place to 7 in NA.*/


/* Which concole is the most sold in North America, with the Playstation 2 being sold the most worldwide by a big margin I predict it would be the same for NA.
However I predict that the PS3 would beat the XBox 360 for the number 2 spot for NA*/
select Platform
, round(Sum(NA_Sales),2) as TotalPlatformSalesinNorthAmerica
from vgsales
group by Platform
order by sum(NA_Sales) DESC;

/* XBox 360 beat the playstation 2 for the number one spot by 20 million 
The Wii also beat the PS3 for third place.    */

/* Which game had the most sales in NA*/ 
select Game
, platform
, Publisher
, NA_Sales,2 as TotalGameSalesinNorthAmerica
from vgsales
order by NA_Sales DESC
limit 50;

/* WII Sports once again dominates in sales in NA with duck hunt being a suprising 3rd place*/

/* Publishers that made the most sales*/
select Publisher
, count(Publisher) as NumberOfGamesReleased
, round(sum(NA_Sales),2) as TotalPublisherSalesinNorthAmerica
from vgsales
group by Publisher
order by sum(Global_Sales) DESC;

/* Nintendo still dominates in sale NA with most of the publishers being in the same spot as global*/


----------------------------------------------------------------------------------------------------------------------------------------------- 
-- Euorpean sales for Genre, Platform, Games and Publisher.

select Genre
, count(Genre) as NumberofGames
, round(sum(EU_Sales),2) As TotalGenreSalesinEurope
from vgsales
group by Genre
order by sum(EU_Sales) DESC;

/* Action games are still number one when it comes to sales along with Sports and Shooters*/

select Platform
, Round(Sum(EU_Sales),2) as TotalPlatformSalesinEurope
from vgsales
group by Platform
order by sum(EU_Sales) DESC;

/* Playstation 3 is the most sold console in Europe while Playstation 2 and XBox 360 come after it*/


select Game,
 Platform,
 Publisher,
 EU_Sales as TotalGameSalesinEurope
from vgsales
order by EU_Sales DESC
limit 50;

/* WII Sports once again is the most sold game*/


select Publisher,
 count(Publisher) as NumberOfGamesReleased,
 round(sum(EU_Sales),2) as TotalPublisherSalesinEurope
from vgsales
group by Publisher
order by sum(EU_Sales) DESC;

/* Nintendo is still the publisher with the most sold games*/
----------------------------------------------------------------------------------------------------------------------------------------------- 
-- Japanease sales for Genre, Platform, Games and Publisher. 

select Genre,
 count(Genre) as NumberofGames,
 round(sum(JP_Sales),2) As TotalGenreSalesinJapan
from vgsales
group by Genre
order by sum(JP_Sales) DESC;

/* Role-Playing games are the most sold Genre in Japan*/


select Platform,
 round(Sum(JP_Sales),2) as TotalPlatformSalesinJapan
from vgsales
group by Platform
order by sum(JP_Sales) DESC;

/* Nintendos DS is the most sold console in Japan which shouldn't come as a suprise since its a native console*/


select Game,
 platform,
 Publisher,
 JP_Sales as TotalGameSalesinJapan
from vgsales
order by JP_Sales DESC
limit 50;

/* Both Pokemon games Red/Blue and Gold/Silver are the most sold games in Japan*/

select Publisher,
 count(Publisher) as NumberOfGamesReleased,
 round(sum(JP_Sales),2) as TotalPublisherSalesinJapan
from vgsales
group by Publisher
order by sum(JP_Sales) DESC;

/* Nintendo once again takes first place however we see other publishers that are native to Japan take the top 5 such as
Namco Bandai
Konami Digital
Sony Computer
and Capsom*/
------------------------------------------------------------------------------------------------------------------------------
/* Now I will use the information from my previous code I will import a new dataset with the popular game streaming site Twitch.
Here I will demonstrate the Join funtion*/

select * 
from vgsales sales
join twitch_game_data views
	on sales.Game = views.Game;


select views.Game
, concat(views.Month, '/', views.Year) as 'Date(MM/YYYY)'
, views.Avg_viewers
,Sales.Game
,sales.Platform
,sales.Global_Sales
from vgsales sales
join twitch_game_data views
	on sales.Game = views.Game
order by views.Avg_viewers DESC;

select views.Game
, concat(views.Month, '/', views.Year) as 'Date(MM/YYYY)'
, views.Avg_viewers
,views.Game
,sales.Platform
,sales.Global_Sales
from twitch_game_data views 
join vgsales sales
	on sales.Game = views.Game
order by views.Avg_viewers DESC



/* Grand Theft Auto V had the most average viwership on May of 2021 with a average viewership of 341,075 average viwers. 
Next being World of Warcraft with 124,925 which was achieved September of 2019.
GTA V */

