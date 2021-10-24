/*
For each city, find the most popular station in that city.
"Popular" means that the station has the highest count of visits.
As above, either starting a trip or finishing a trip at a station, the trip is counted as one visit to that station.

Details: For each station, print city name, most popular station name and its visit count. Sort by city name, ascending.
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

WITH station_popularity AS (
  SELECT
    station.city,
    station.station_name,
    COUNT(station.station_id) AS count_station_id,
    RANK() OVER (
      PARTITION BY station.city
      ORDER BY COUNT(station.station_id) DESC
    ) station_popularity_rank
  FROM all_trips
  JOIN station ON all_trips.trip_station_id == station.station_id
  GROUP BY station.station_id
)
SELECT city, station_name, count_station_id
FROM station_popularity
WHERE station_popularity_rank = 1
ORDER BY city;
