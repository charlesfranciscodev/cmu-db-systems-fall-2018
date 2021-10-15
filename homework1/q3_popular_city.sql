/*
Find the percentage of trips in each city.
A trip belongs to a city as long as its start station or end station is in the city.
For example, if a trip started from station A in city P and ended in station B in city Q,
then the trip belongs to both city P and city Q.
If P equals to Q, the trip is only counted once.

Print city name and ratio between the number of trips that belong to that city against the total number of trips
Sort by ratio (decreasing), and break ties by city name (increasing).
*/

CREATE TEMP VIEW IF NOT EXISTS all_trips AS
SELECT start_station_id AS trip_station_id
FROM trip
WHERE start_station_id == end_station_id
UNION ALL
SELECT start_station_id AS trip_station_id
FROM trip
WHERE start_station_id != end_station_id
UNION ALL
SELECT end_station_id AS trip_station_id
FROM trip
WHERE start_station_id != end_station_id;

SELECT station.city, ROUND(100.0 * COUNT(1) / (SELECT COUNT(1) FROM all_trips), 4) AS ratio
FROM all_trips
JOIN station ON all_trips.trip_station_id == station.station_id
GROUP BY station.city
ORDER BY ratio DESC, station.city;
