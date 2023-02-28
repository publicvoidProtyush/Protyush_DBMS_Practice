CREATE DATABASE travelongo;

USE travelongo;

CREATE TABLE passenger
(
   id INT AUTO_INCREMENT PRIMARY KEY,
   passenger_name VARCHAR(50),
   category VARCHAR(50),
   gender VARCHAR(20),
   boarding_city VARCHAR(20),
   destination_city VARCHAR(20),
   distance INT,
   bus_type VARCHAR(20)
);

CREATE TABLE price 
(
    bus_type VARCHAR(20),
    distance INT,
    price INT
);

INSERT INTO passenger(passenger_name, category, gender, boarding_city, destination_city, distance, bus_type)
VALUES('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');

INSERT INTO passenger(passenger_name, category, gender, boarding_city, destination_city, distance, bus_type)
VALUES('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');

INSERT INTO passenger(passenger_name, category, gender, boarding_city, destination_city, distance, bus_type)
VALUES('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');

INSERT INTO passenger(passenger_name, category, gender, boarding_city, destination_city, distance, bus_type)
VALUES('Khusboo', 'AC', 'F', 'Chennai', 'Munmbai', 1500, 'Sleeper');

INSERT INTO passenger(passenger_name, category, gender, boarding_city, destination_city, distance, bus_type)
VALUES('Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper');

INSERT INTO passenger(passenger_name, category, gender, boarding_city, destination_city, distance, bus_type)
VALUES('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');

INSERT INTO passenger(passenger_name, category, gender, boarding_city, destination_city, distance, bus_type)
VALUES('Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper');

INSERT INTO passenger(passenger_name, category, gender, boarding_city, destination_city, distance, bus_type)
VALUES('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');

INSERT INTO passenger(passenger_name, category, gender, boarding_city, destination_city, distance, bus_type)
VALUES('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

INSERT INTO price VALUES('Sleeper', 350, 770);

INSERT INTO price VALUES('Sleeper', 500, 1100);

INSERT INTO price VALUES('Sleeper', 600, 1320);

INSERT INTO price VALUES('Sleeper', 700, 1540);

INSERT INTO price VALUES('Sleeper', 1000, 2200);

INSERT INTO price VALUES('Sleeper', 1200, 2640);

INSERT INTO price VALUES('Sleeper', 1500, 2700);

INSERT INTO price VALUES('Sitting', 500, 620);

INSERT INTO price VALUES('Sitting', 600, 744);

INSERT INTO price VALUES('Sitting', 700, 868);

INSERT INTO price VALUES('Sitting', 1000, 1240);

INSERT INTO price VALUES('Sitting', 1200, 1488);

INSERT INTO price VALUES('Sitting', 1500, 1860);

-- 3)	How many females and how many male passengers travelled for a minimum distance of 600 KM s?

SELECT gender, COUNT(gender) AS Total FROM passenger
WHERE distance >= 600 GROUP BY gender;

-- 4)	Find the minimum ticket price for Sleeper Bus.

SELECT MIN(price) AS low_price FROM price
WHERE bus_type = 'Sleeper';

-- 5)	Select passenger names whose names start with character 'S' 

SELECT passenger_name FROM passenger
WHERE passenger_name LIKE 'S%';

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output

SELECT p.passenger_name, p.boarding_city, p.destination_city, p.bus_type, price.price FROM passenger p
INNER JOIN price ON (p.distance = price.distance AND p.bus_type = price.bus_type);

-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus  for a distance of 1000 KM s

SELECT p.passenger_name, price.price FROM passenger p, price
WHERE (p.bus_type = 'Sitting' AND price.bus_type = 'Sitting'AND p.distance = 1000 AND price.distance = 1000);

-- OR

/*
SELECT passenger.passenger_name, A.price FROM passenger INNER JOIN
(SELECT price.bus_type, price.distance, price.price FROM price WHERE bus_type = 'Sitting' AND distance >= 1000) AS A
ON passenger.bus_type = A.bus_type AND passenger.distance = A.distance; */

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

SELECT price FROM price 
WHERE distance = (SELECT distance FROM passenger WHERE (boarding_city = 'Bengaluru' AND destination_city = 'Panaji') 
                  OR(boarding_city = 'Panaji' AND destination_city = 'Bengaluru'));
       
-- 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order

SELECT DISTINCT distance FROM passenger 
ORDER BY distance DESC;



-- 10)	Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables 

SELECT passenger_name, (distance / (SELECT SUM(distance) FROM passenger)) * 100 AS precentage
FROM passenger;

/*
11)	Display the distance, price in three categories in table Price
a)	Expensive if the cost is more than 1000
b)	Average Cost if the cost is less than 1000 and greater than 500
c)	Cheap otherwise
*/

SELECT distance, price ,
CASE
    WHEN price > 1000 THEN 'Expensive'
    WHEN price > 500 AND price < 1000 THEN 'Average Cost'
    ELSE 'Cheap'
END AS Average_cost FROM price;

CALL `PRICE_CATEGORY`();