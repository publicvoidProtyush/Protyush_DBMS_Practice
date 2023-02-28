CREATE DEFINER=`root`@`localhost` PROCEDURE `PRICE_CATEGORY`()
BEGIN
SELECT distance, price ,
CASE
    WHEN price > 1000 THEN 'Expensive'
    WHEN price > 500 AND price < 1000 THEN 'Average Cost'
    ELSE 'Cheap'
END AS Average_cost FROM price;
END