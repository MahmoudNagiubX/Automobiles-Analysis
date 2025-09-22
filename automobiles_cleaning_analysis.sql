USE automobiles;
GO

-- Data Cleaning 
UPDATE AutoData
SET make = 'volkswagen'
WHERE make LIKE 'vw%';

UPDATE AutoData
SET make = 'mazda'
WHERE make LIKE 'maxda%';

UPDATE AutoData
SET make = 'volkswagen'
WHERE make LIKE 'vokswagen%';

UPDATE AutoData
SET make = 'toyota'
WHERE make LIKE 'toyouta%';

UPDATE AutoData
SET make = 'porsche'
WHERE make LIKE 'porcshce%';

ALTER TABLE AutoData
DROP COLUMN symboling, doornumber, enginelocation, 
            carlength, carwidth, carheight, enginetype, 
            boreratio, stroke, compressionratio;


-- SQL Analysis
--1. List the top 10 most expensive cars with their make, body style, horsepower, and price.
SELECT TOP (5) make,carbody, horsepower,price
FROM AutoData
ORDER BY price DESC;

--2. Find the average price of cars grouped by carbody.
SELECT	carbody, CAST (AVG(price) AS INT) AS AVG_PRICE
FROM AutoData
GROUP BY carbody
ORDER BY AVG_PRICE DESC;

--3. Which fuel type gas vs diesel has the higher average price?
SELECT fueltype AS FUEL_TYPE, CAST (AVG(price) AS INT) AS AVG_PRICE
FROM AutoData
GROUP BY fueltype
ORDER BY AVG_PRICE DESC;

--4. Show the top 5 car brands with the highest average price.
SELECT TOP(5) make AS CAR_BRAND, CAST(AVG(price) AS INT) AS AVG_PRICE
FROM AutoData
GROUP BY make
ORDER BY AVG_PRICE DESC;

--5. Count how many cars each brand has in the dataset.
SELECT LEFT(make, CHARINDEX(' ', make + ' ') - 1) AS Brand,
	COUNT(*) AS BrandCount
FROM AutoData
GROUP BY LEFT(make, CHARINDEX(' ', make + ' ') - 1)
ORDER BY BrandCount DESC;

--6. Find the relationship between different horsepower range and avg price.
SELECT 
	CASE
        WHEN horsepower <= 100 THEN '<=100'
        WHEN horsepower BETWEEN 101 AND 150 THEN '101-150'
        WHEN horsepower BETWEEN 151 AND 200 THEN '151-200'
        WHEN horsepower BETWEEN 201 AND 250 THEN '201-250'
        ELSE '250+'
    END AS Horsepower_Range, 
	CAST (AVG(price) AS INT) AS AVG_PRICE
FROM AutoData
GROUP BY 
	CASE
		WHEN horsepower <= 100 THEN '<=100'
		WHEN horsepower BETWEEN 101 AND 150 THEN '101-150'
		WHEN horsepower BETWEEN 151 AND 200 THEN '151-200'
		WHEN horsepower BETWEEN 201 AND 250 THEN '201-250'
		ELSE '250+'
	END
ORDER BY Horsepower_Range DESC;

--7. Which drivewheel type has the highest average price
SELECT drivewheel, CAST (AVG(PRICE) AS INT) AS AVG_PRICE
FROM AutoData
GROUP BY drivewheel
ORDER BY AVG_PRICE DESC;

--8. Compare different engine size ranges to fuel efficiency in city and highway.
SELECT 
	CASE 
        WHEN enginesize <= 100 THEN 'Small (<=100)'
        WHEN enginesize BETWEEN 101 AND 200 THEN 'Medium (101-200)'
        WHEN enginesize BETWEEN 201 AND 300 THEN 'Large (201-300)'
        ELSE 'Very Large (>300)'
    END AS Engine_Size_Range,
	AVG(citympg) AS Fuel_Efficiency_City_Driving,
	AVG(highwaympg) As Fuel_Efficiency_High_Way
FROM AutoData
GROUP BY 	
	CASE 
        WHEN enginesize <= 100 THEN 'Small (<=100)'
        WHEN enginesize BETWEEN 101 AND 200 THEN 'Medium (101-200)'
        WHEN enginesize BETWEEN 201 AND 300 THEN 'Large (201-300)'
        ELSE 'Very Large (>300)'
    END
ORDER BY Engine_Size_Range DESC;

--9. Check which body style tends to have the highest horsepower on average.
SELECT carbody, AVG(horsepower) AS AVG_HORSEPOWER
FROM AutoData
GROUP BY carbody
ORDER BY AVG_HORSEPOWER DESC;

--10. Find the correlation-like comparison: show avg price vs avg curbweight grouped by brand.
SELECT TOP (5) LEFT(make,CHARINDEX(' ', make + ' ') - 1) AS BRAND,
	CAST (AVG(price) AS INT) AS AVG_PRICE,
	AVG(curbweight) AS AVG_CURBWEIGHT
FROM AutoData
GROUP BY LEFT(make,CHARINDEX(' ', make + ' ') - 1)
ORDER BY AVG_CURBWEIGHT DESC;

-- 11. Identify luxury cars (price > 20,000) and list their make, fuel type and horsepower.
SELECT TOP(5)make,fueltype,horsepower,price
FROM AutoData
WHERE price > 20000
ORDER BY price DESC;

--12. Find the cheapest and most expensive price for a car in each make.
SELECT LEFT(make, CHARINDEX(' ', make + ' ') - 1) AS CAR,
	MAX(price) AS MOST_EXPENSIVE_CAR,
	MIN(price) AS CHEAPEST_CAR
FROM AutoData
GROUP BY LEFT(make, CHARINDEX(' ', make + ' ') - 1)
ORDER BY MOST_EXPENSIVE_CAR DESC;

--13. Which features (cylindernumber, aspiration, fuel system) are most common among expensive cars (price > 25,000)?
SELECT TOP(5)cylindernumber, aspiration, fuelsystem, price
FROM AutoData
WHERE price < 15000
ORDER BY price DESC;

--14. What is the relationship between engine horsepower and the peak RPM? 
--Find the average car price for different peak RPM ranges.
SELECT 
    CASE 
        WHEN peakrpm < 4500 THEN 'Low RPM (<4500)'
        WHEN peakrpm BETWEEN 4500 AND 5500 THEN 'Medium RPM (4500-5500)'
        ELSE 'High RPM (>5500)'
    END AS RPM_RANGE,
    AVG(horsepower) AS AVG_HORSEPOWER
FROM AutoData
GROUP BY 
    CASE 
        WHEN peakrpm < 4500 THEN 'Low RPM (<4500)'
        WHEN peakrpm BETWEEN 4500 AND 5500 THEN 'Medium RPM (4500-5500)'
        ELSE 'High RPM (>5500)'
    END
ORDER BY AVG_HORSEPOWER DESC;

SELECT * FROM AutoData;

