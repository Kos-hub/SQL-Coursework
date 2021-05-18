--QUESTION 11
SELECT trip_id, CONCAT(a,'%') AS a, CONCAT(b,'%') AS b, CONCAT(c,'%') AS c
FROM (SELECT trip_id,
	ROUND(COUNT(case when category = 'A' then category end)/COUNT(category)*100) as a,
	ROUND(COUNT(case when category = 'B' then category end)/COUNT(category)*100) as b,
	ROUND(COUNT(case when category = 'C' then category end)/COUNT(category)*100) as c 
	FROM manifest
	GROUP BY trip_id
	HAVING COUNT(case when category = 'C' then category end) > 0
	ORDER BY C desc) AS subquery;

--QUESTION 12
SELECT registration
FROM vehicle
WHERE registration NOT IN 
	(SELECT registration
	FROM vehicle 
	JOIN trip ON (trip.vehicle_id = vehicle.vehicle_id)
	WHERE (departure_date <= '2012-05-01' AND return_date >= '2012-05-01') OR
	(departure_date >= '2012-05-01' AND departure_date <= '2012-05-05')
ORDER BY departure_date);

--QUESTION 13
SELECT MONTHNAME(departure_date) AS Month,
CONCAT(first_name, ' ', last_name) AS Name,
SUM(DATEDIFF(return_date, departure_date)) as Days,
SUM(DATEDIFF(return_date, departure_date))-24 as Bonus
FROM driver
	JOIN trip ON (driver.employee_no = trip.employee_no)
GROUP BY Name, month
HAVING Days > 24
ORDER BY Month desc, Days desc;

--QUESTION 14
SELECT first_name, last_name,
COUNT(barcode) as items,
WEEK(departure_date, 7) AS weekno
FROM manifest 
	JOIN trip ON (manifest.trip_id = trip.trip_id)
	JOIN driver ON (trip.employee_no = driver.employee_no)
GROUP BY first_name, last_name, weekno
ORDER BY items desc
LIMIT 1;

--QUESTION 15
SELECT CONCAT(ROUND(AVG(capacity)), '%') AS Capacity
FROM 
	(SELECT vehicle_id, (ROUND(SUM(DATEDIFF(return_date, departure_date))))/
	(SELECT DATEDIFF(MAX(return_date), MIN(departure_date))
	FROM trip)*100 AS capacity
	FROM trip GROUP BY vehicle_id) 
AS subquery;